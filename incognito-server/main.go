package main

import (
	"crypto/rand"
	"encoding/hex"
	"fmt"
	"log"
	"net/http"
	"os"
	"strconv"
	"strings"
	"time"

	tgbotapi "github.com/go-telegram-bot-api/telegram-bot-api/v5"
	"github.com/joho/godotenv"
	su "github.com/nedpals/supabase-go"
)

var supabase *su.Client
var superAdminID int64

// Estructura para interactuar con la Base de Datos Supabase
type KeyRecord struct {
	KeyHash      string    `json:"key_hash"`
	CreatedBy    int64     `json:"creada_por"`
	Status       string    `json:"estado"`
	ExpiresAt    string    `json:"expira_en"`
	VpsIP        string    `json:"vps_ip"`
}

func main() {
	// 1. Cargar variables de entorno
	err := godotenv.Load(".env")
	if err != nil {
		log.Println("No se encontró archivo .env, usando variables del sistema.")
	}

	telegramToken := os.Getenv("TELEGRAM_BOT_TOKEN")
	supabaseUrl := os.Getenv("SUPABASE_URL")
	supabaseKey := os.Getenv("SUPABASE_SERVICE_KEY")
	adminIDStr := os.Getenv("SUPER_ADMIN_ID")

	if telegramToken == "" || supabaseUrl == "" || supabaseKey == "" {
		log.Fatal("Faltan variables de entorno cruciales (TELEGRAM_BOT_TOKEN, SUPABASE_URL, SUPABASE_SERVICE_KEY).")
	}

	superAdminID, _ = strconv.ParseInt(adminIDStr, 10, 64)

	// 2. Inicializar cliente de Supabase
	supabase = su.CreateClient(supabaseUrl, supabaseKey)
	log.Println("[INFO] Conectado a Supabase correctamente.")

	// 3. Iniciar el bot de Telegram
	bot, err := tgbotapi.NewBotAPI(telegramToken)
	if err != nil {
		log.Fatal("Error iniciando bot:", err)
	}

	bot.Debug = false
	log.Printf("[INFO] Bot INCOGNITO activo como %s", bot.Self.UserName)

	// Manejador de mensajes entrantes
	u := tgbotapi.NewUpdate(0)
	u.Timeout = 60
	updates := bot.GetUpdatesChan(u)

	// 4. Iniciar Servidor web en una Goroutine (Para escuchar al script setup.sh)
	go startWebServer(bot)

	// 5. Escuchar Telegram
	for update := range updates {
		if update.Message != nil { 
			handleTelegramCommand(bot, update.Message)
		}
	}
}

// Lógica de mensajes de Telegram
func handleTelegramCommand(bot *tgbotapi.BotAPI, msg *tgbotapi.Message) {
	userId := msg.From.ID

	// Por ahora solo validaremos que sea el Super Admin
	if userId != superAdminID {
		reply := tgbotapi.NewMessage(msg.Chat.ID, "⛔ ACCESO DENEGADO. No tienes autorización para usar INCOGNITO.")
		bot.Send(reply)
		return
	}

	cmd := strings.ToLower(msg.Text)

	switch cmd {
	case "/start":
		reply := tgbotapi.NewMessage(msg.Chat.ID, "👑 Bienvenido a INCOGNITO Admin.\nUse /generar para crear una nueva Key.")
		bot.Send(reply)
	case "/generar":
		key := generateUniqueKey()
		
		// Guardar en Supabase
		err := saveKeyToSupabase(key, userId)
		if err != nil {
			reply := tgbotapi.NewMessage(msg.Chat.ID, "❌ Error guardando la key en Supabase: "+err.Error())
			bot.Send(reply)
			log.Println("Error DB:", err)
			return
		}

		responseText := fmt.Sprintf("✅ **KEY GENERADA CON ÉXITO**\n\n`%s`\n\n_Expira en 4 horas._", key)
		reply := tgbotapi.NewMessage(msg.Chat.ID, responseText)
		reply.ParseMode = "Markdown"
		bot.Send(reply)
	default:
		reply := tgbotapi.NewMessage(msg.Chat.ID, "Comando desconocido. Opciones: /start, /generar")
		bot.Send(reply)
	}
}

// Genera una cadena aleatoria
func generateUniqueKey() string {
	bytes := make([]byte, 5) // 10 caracteres hexadecimales
	rand.Read(bytes)
	return "INCOGNITO-" + strings.ToUpper(hex.EncodeToString(bytes))
}

func saveKeyToSupabase(keyHash string, userID int64) error {
	record := KeyRecord{
		KeyHash:   keyHash,
		CreatedBy: userID,
		Status:    "DISPONIBLE",
		ExpiresAt: time.Now().UTC().Add(4 * time.Hour).Format(time.RFC3339),
	}

	var results []KeyRecord
	err := supabase.DB.From("keys_generadas").Insert(record).Execute(&results)
	return err
}

func startWebServer(bot *tgbotapi.BotAPI) {
	http.HandleFunc("/validar", func(w http.ResponseWriter, r *http.Request) {
		keyHash := r.URL.Query().Get("key")
		vpsIp := r.RemoteAddr // Simplificado, idealmente usar headers de proxy inverso si existe

		if keyHash == "" {
			http.Error(w, "NO_AUTORIZADO", http.StatusUnauthorized)
			return
		}

		// Buscar Key en Supabase (Lógica simulada para evitar complejidad grande de ORM ahora)
		var records []KeyRecord
		err := supabase.DB.From("keys_generadas").Select("*").Eq("key_hash", keyHash).Execute(&records)

		if err != nil || len(records) == 0 {
			w.Write([]byte("NO_AUTORIZADO"))
			return
		}

		keyRecord := records[0]

		if keyRecord.Status == "USADA" && keyRecord.VpsIP == vpsIp {
			// Ya estaba autorizada de antes, respuesta LIFETIME
			w.Write([]byte("AUTORIZADO|LIFETIME"))
			return
		}

		expTime, _ := time.Parse("2006-01-02T15:04:05", strings.Split(keyRecord.ExpiresAt, ".")[0])
		
		if keyRecord.Status == "DISPONIBLE" && time.Now().UTC().Before(expTime) {
			// Marcar como usada
			updateData := map[string]interface{}{
				"estado": "USADA",
				"vps_ip": vpsIp,
			}
			var updateResp []KeyRecord
			supabase.DB.From("keys_generadas").Update(updateData).Eq("key_hash", keyHash).Execute(&updateResp)

			// ¡NOTIFICACIÓN ESTRELLA DEL BOT!
			msgText := fmt.Sprintf("💻 **NUEVA VPS INSTALADA**\n\n🔑 Key Usada: `%s`\n🌐 IP: `%s`\n\nEl cliente final se ha activado correctamente.", keyHash, vpsIp)
			msg := tgbotapi.NewMessage(keyRecord.CreatedBy, msgText)
			msg.ParseMode = "Markdown"
			bot.Send(msg)

			w.Write([]byte("AUTORIZADO|LIFETIME"))
			return
		}

		w.Write([]byte("NO_AUTORIZADO"))
	})

	log.Println("[INFO] Web server INCOGNITO escuchando en puerto 8080...")
	log.Fatal(http.ListenAndServe("0.0.0.0:8080", nil))
}
