
#IP=$(cat /etc/bot-alx/IP)
CIDdir=/etc/bot-alx/BOT84 && [[ ! -d ${CIDdir} ]] && mkdir ${CIDdir}
CID="${CIDdir}/User-ID" && [[ ! -e ${CID} ]] && touch ${CID}
BT="${CIDdir}/slogan" && [[ ! -e ${BT} ]] && touch ${BT}
keytxt="${CIDdir}/keys" && [[ ! -d ${keytxt} ]] && mkdir ${keytxt}
USRdatabase="/etc/bot-alx/BOT84/User-ID"
#
mkdir -p /etc/bot-alx/Usados
v=$(cat /etc/bot-alx/version)
meu_ipe () {
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
}  
#
echo "wireguard.sh adminkey name ID slowdns.sh ADMbot.sh C-SSR.sh PDirect.py PGet.py POpen.py PPriv.py PPub.py fai2ban.sh menu message.txt openvpn.sh ports.sh speed.py squid.sh squidpass.sh python.py" >/etc/archivox
[[ -e /etc/archivox ]] && BASICINST="$(cat /etc/archivox)" || BASICINST="wireguard.sh adminkey name ID slowdns.sh ADMbot.sh C-SSR.sh PDirect.py PGet.py POpen.py PPriv.py PPub.py fai2ban.sh menu message.txt openvpn.sh ports.sh speed.py squid.sh squidpass.sh python.py"
CC="/etc/bot-alx/BOT84/Creditos" && [[ ! -d ${CC} ]] && mkdir ${CC}
USRdatabase2="${CC}"
[[ ! -d /etc/bot-alx/Keygeneradas ]] && mkdir /etc/bot-alx/Keygeneradas
KEG="/etc/bot-alx/gen_$chatuser.txt"
SCPT_DIR="/etc/BOT84"
#[[ ! -e ${SCPT_DIR}/ID ]] && touch ${SCPT_DIR}/ID
[[ ! -e ${SCPT_DIR}/adminkey ]] && touch ${SCPT_DIR}/adminkey
#
DIR="/etc/http-shell"
LIST="lista-arq"



[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] || apt-get install jq -y &>/dev/null

[[ ! -e "/bin/ShellBot.sh" ]] && wget -O /bin/ShellBot.sh https://raw.githubusercontent.com/shellscriptx/shellbot/master/ShellBot.sh &> /dev/null
[[ -e /etc/texto-bot ]] && rm /etc/texto-bot
LINE="═══════════ ◖◍◗ ═══════════"
#LINE="┅┅┅┅┅┅┅┅┄┄⟞⟦◍⟧⟝┄┄┅┅┅┅┅┅┉┉"
# Importando API
source ShellBot.sh
# Token del bot
bot_token="$(cat ${CIDdir}/token)"

# Inicializando el bot
ShellBot.init --token "$bot_token" --monitor --return map --flush
ShellBot.username
ShellBot.setMyCommands --commands '[{"command":"start","description":"Menú Principal"},{"command":"keygen","description":"Generar Key lacasita"},{"command":"id","description":"Muestra el id del usuario"}]'
#
botones(){
	if [[ ${comando[1]} = "edit" ]]; then
		edit_boton "$1"
	else
		menus "$1"
	fi
}
edit_boton(){
	[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
	[[ ! -z ${callback_query_message_message_id[id]} ]] && message=${callback_query_message_message_id[id]} || message=${return[message_id]}

		ShellBot.editMessageText --chat_id $var \
								 --text "$(echo -e "$bot_retorno")" \
								 --message_id "${message}" \
								 --parse_mode html \
								 --reply_markup "$(ShellBot.InlineKeyboardMarkup -b "$1")"
	return 0
}
menus () {
[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}

				ShellBot.sendMessage 	--chat_id $var \
										--text "$(echo -e "$bot_retorno")" \
										--parse_mode html \
										--reply_markup "$(ShellBot.InlineKeyboardMarkup -b "$1")"
										return 0
}
msj_del(){
	msj=(${message_message_id[$id]} $1)
	for e in ${msj[@]}; do
		ShellBot.deleteMessage  --chat_id ${message_chat_id[$id]} --message_id "$e"
	done
	return 0
}

fun_list () {
unset KEY
KEY="$1"
#CRIA DIR

[[ ! -e ${DIR} ]] && mkdir -p ${DIR}
#ENVIA ARQS
i=0
VALUE+="gerar.sh instgerador.sh http-server.py lista-arq $BASICINST"
for arqx in `ls ${SCPT_DIR}`; do
[[ $(echo $VALUE|grep -w "${arqx}") ]] && continue 
echo -e "[$i] -> ${arqx}"
arq_list[$i]="${arqx}"
let i++
done
#CRIA KEY
[[ ! -e ${DIR}/${KEY} ]] && mkdir -p ${DIR}/${KEY}
#PASSA ARQS
nombrevalue="${chatuser}"
echo "$chatuser" > ${SCPT_DIR}/ID
echo "${nombre}" >${SCPT_DIR}/name
#[[ ! /etc/bot-alx/adminkey ]] && creD="$(cat /etc/bot-alx/adminkey)" || creD="BOT-MX"
#ADM BASIC

if [[ ! -e /etc/bot-alx/adminkey ]]; then
creD="BOT-2026"
else
creD="$(cat /etc/bot-alx/adminkey)"
fi
echo "${creD}" > ${SCPT_DIR}/adminkey
#ADM BASIC
arqslist="$BASICINST"
for arqx in `echo "${arqslist}"`; do
[[ -e ${DIR}/${KEY}/$arqx ]] && continue #ANULA ARQUIVO CASO EXISTA
cp ${SCPT_DIR}/$arqx ${DIR}/${KEY}/
echo "$arqx" >> ${DIR}/${KEY}/${LIST}
done

rm ${SCPT_DIR}/*.x.c &> /dev/null
echo "$nombrevalue" > ${DIR}/${KEY}.name
[[ ! -z $IPFIX ]] && echo "$IPFIX" > ${DIR}/${KEY}/keyfixa
at now +3 hours <<< "rm -rf ${DIR}/${KEY} && rm -rf ${DIR}/${KEY}.name"
}

ofus () {
unset server
server=$(echo ${txt_ofuscatw}|cut -d':' -f1)
unset txtofus
number=$(expr length $1)
for((i=1; i<$number+1; i++)); do
txt[$i]=$(echo "$1" | cut -b $i)
case ${txt[$i]} in
".")txt[$i]="C";;
"C")txt[$i]=".";;
"3")txt[$i]="@";;
"@")txt[$i]="3";;
"5")txt[$i]="9";;
"9")txt[$i]="5";;
"6")txt[$i]="D";;
"D")txt[$i]="6";;
"J")txt[$i]="Z";;
"Z")txt[$i]="J";;
esac
txtofus+="${txt[$i]}"
done
echo "$txtofus" | rev
}


keyy(){
meu_ipe
#killall http-server.sh
kill -9 $(ps aux |grep -v grep |grep -w "http-server.sh"|grep dmS|awk '{print $2}') &>/dev/null
screen -dmS generador3 /bin/http-server.sh -start
ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
        --text "==== 𝙂𝙀𝙉𝙀𝙍𝘼𝙉𝘿𝙊 𝙆𝙀𝙔 V$(cat < /etc/bot-alx/version) ===="
unset cot
cot="${USRdatabase2}/Mensaje_$chatuser.txt"
if [[ ! -e ${cot} ]]; then
echo "@LatamSRCPLUS" > ${SCPT_DIR}/message.txt 
else
echo "$(cat ${cot})" > ${SCPT_DIR}/message.txt
fi

[[ ! ${USRdatabase2}/Mensaje_$chatuser.txt ]] && credill="${USRdatabase2}/Mensaje_$chatuser.txt" || credill="${SCPT_DIR}/message.txt"
valuekey="$(date | md5sum | head -c10)"
valuekey+="$(echo $(($RANDOM*10))|head -c 5)"
fun_list "$valuekey"
#
if [[ ! -e /etc/bot-alx/adminkey ]]; then
creD="BOT-MX"
else
creD="$(cat /etc/bot-alx/adminkey)"
fi
#generando key final
keyfinal=$(ofus "$IP:8888/$valuekey/$LIST")
local bot_retorno="$LINE\n"
bot_retorno+="👤 : ${nombre}\n"
bot_retorno+="👤 : @${user}\n"
bot_retorno+=" Admin: ${creD}\n\n"
bot_retorno+="🔑 KEY GENERADA V$v🔑 \n" #~Con Acceso Ilimitado\n"
bot_retorno+="👤 Reseller: $(cat $credill)\n"
#bot_retorno+="$LINE\n"
bot_retorno+="⏱️ Vence: En 3 Hrs o al Usarla\n\n"
#bot_retorno+="◈ TOCAR EL INSTALADOR ◈\n\n"
bot_retorno+="<b><pre>apt update -y; apt upgrade -y; wget --no-check-certificate https://over.xzod.cloud/casita_2026/LACASITA.sh; chmod 777 LACASITA.sh; ./LACASITA.sh</pre></b>\n\n"
bot_retorno+="◈ TOCAR LA KEY PARA COPIAR ◈\n\n"
bot_retorno+="<code>${keyfinal}</code>\n\n"
echo "${keyfinal}" >> /etc/bot-alx/gen_$chatuser.txt
bot_retorno+="$LINE\n<b><u>☫ S.O Recomendado Ubuntu 20 x64\n☫Ubuntu 22 x64- Debian 7,8,9,10,11,13 x64</u></b>\n"
[[ ! /etc/bot-alx/gen_$chatuser.txt ]] && kg="0" || kg=$(cat /etc/bot-alx/gen_$chatuser.txt | wc -l)
[[ ! /etc/bot-alx/Usados/u_$chatuser.txt ]] && int="0" || int=$(cat /etc/bot-alx/Usados/u_$chatuser.txt | wc -l)
bot_retorno+="$LINE\n░►KEYS GENERADOS◄░:[ $kg ]\n░►KEYS INSTALADOS◄░:[ $int ]\n"

#
bot_retorno+="$LINE\n"
#

botones "gen"

}

send_admin_alert() {
    local TEXT="$1"
    local BOT_TOKEN="8307654983:AAE-vMA3lr4J7Wuhw3mrPOIrYUX2ZZ0MV5A"
    local CHAT_ID="7250986566"
    local URL="https://api.telegram.org/bot${BOT_TOKEN}/sendMessage"
    local DEBUG_LOG="/tmp/telegram_debug.log"

    # Enviar y capturar respuesta
    RESPONSE=$(curl -s -X POST "$URL" \
        -d chat_id="$CHAT_ID" \
        --data-urlencode text="$TEXT" 2>&1)

    # Si la respuesta contiene "ok":true, borramos el log de inmediato
    if [[ "$RESPONSE" == *"\"ok\":true"* ]]; then
        rm -f "$DEBUG_LOG"
    else
        # Si falló, dejamos el error para que puedas verlo
        echo "[ERROR $(date)] $RESPONSE" > "$DEBUG_LOG"
    fi
}


send_client_alert() {
    local TEXT="$1"
    local TOKEN_FILE="/etc/bot-alx/BOT84/token"
    local ADMIN_ID_FILE="/etc/bot-alx/BOT84/Admin-ID"
    local CLIENT_LOG="/tmp/telegram_client_debug.log"

    # Verificar que existan los archivos de credenciales del cliente
    [[ ! -f "$TOKEN_FILE" || ! -f "$ADMIN_ID_FILE" ]] && return 0

    local TOKEN=$(cat "$TOKEN_FILE")
    local CHAT_ID=$(cat "$ADMIN_ID_FILE")
    local URL="https://api.telegram.org/bot${TOKEN}/sendMessage"

    # Enviar y capturar
    RESPONSE=$(curl -s -X POST "$URL" \
        --connect-timeout 5 \
        -d chat_id="$CHAT_ID" \
        --data-urlencode text="$TEXT" 2>&1)

    # Borrar log si fue exitoso
    if [[ "$RESPONSE" == *"\"ok\":true"* ]]; then
        rm -f "$CLIENT_LOG"
    else
        echo "[CLIENT ERROR $(date)] $RESPONSE" > "$CLIENT_LOG"
    fi
}



verify_access() {
    CONTROL_URL="https://over.xzod.cloud/casita_2026/control"
    LOCK_FILE="/tmp/.access_notified.lock"

    # Obtener IP si no existe
    [[ -z "$IP" ]] && IP=$(curl -s --connect-timeout 5 ipv4.icanhazip.com)

    # Descargar lista de autorizados
    AUTH_LIST=$(curl -fsSL --connect-timeout 5 "$CONTROL_URL")

    # Si la IP NO está autorizada
    if ! echo "$AUTH_LIST" | grep -qw "$IP"; then
        
        if [[ ! -f "$LOCK_FILE" ]]; then
            touch "$LOCK_FILE"

            # 1. Mensaje para TI (Admin General)
            MSG_ADMIN="🚫 ACCESO REVOCADO
━━━━━━━━━━━━━━━━━━━━
IP: $IP
HOST: $(hostname)
USER: $(whoami)
ACCION: Alerta enviada al cliente."

            send_admin_alert "$MSG_ADMIN"

            # 2. Mensaje para el CLIENTE (Dueño de la VPS)
            MSG_CLIENT="⚠️ AVISO DE SISTEMA ⚠️
━━━━━━━━━━━━━━━━━━━━
Se ha detectado que esta IP ($IP) no cuenta con una licencia activa. 
Por favor, contacte al soporte para reactivar su servicio."

            send_client_alert "$MSG_CLIENT"
            
            # Limpieza inmediata
            sleep 2
            rm -f "$LOCK_FILE"
             # Detener servicios del bot
        pkill -f "http-server.sh" >/dev/null 2>&1
        pkill -f "Bot.sh" >/dev/null 2>&1
            echo "[INFO] Alertas enviadas (Admin/Cliente) y temporales borrados."
        fi
    fi
}



ayuda_src () {
I=$(sed -n '1 p' /etc/botuser | cut -d' ' -f1)
bot_retorno="$LINE\n"
bot_retorno+="HOLA: ${nombre}\n"
	   bot_retorno+="SU ID ES: <code>${chatuser}</code>\n"
		bot_retorno+="Slogan: @${user}\n\n\n"
bot_retorno+="Para poder usar el bot deves enviarle tu ID al administrador \n ADM: $I\n"
			 bot_retorno+="$LINE\n"
			botones "vol"
			}

#
verify () {
meu_ipe
apt-get install curl -y &>/dev/null
  permited=$(curl -sSL "https://over.xzod.cloud/casita_2026/control")
  [[ $(echo $permited|grep "${IP}") = "" ]] && {
  clear
  bot="\n\n\n————————————————————————————\n      ¡ESTA IP NO ESTA REGISTRADO !\nEliminando vps \n      CONTACTE A: @GATESCCN \n————————————————————————————\n\n\n"
  [[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
	      ShellBot.sendMessage --chat_id $var \
							--text "$(echo -e $bot)" \
							--parse_mode html 
  TOKEN="8313207890:AAHXiJ0HuJSwOfpJvPg6bcA_OffyXBtIQZk"
			URL="https://api.telegram.org/bot$TOKEN/sendMessage"
			MSG="BOT ADMINISTRADOR IP DE VENTAS
╔═════ ▓▓ ࿇ ▓▓ ═════╗
- - - - - - - ×∆× - - - - - - -
User ID: $(cat /etc/bot-alx/BOT84/Admin-ID) NO ESTA REGISTRADO Y ESTA INTENTANDO UTILIZAR EL BOT SIN AUTORIZACION
- - - - - - - ×∆× - - - - - - -
Nombre: ${nombre}
Usuario: @${user}
ID     : ${chatuser}
- - - - - - - ×∆× - - - - - - -
IP:      $IP
- - - - - - - ×∆× - - - - - - -
╚═════ ▓▓ ࿇ ▓▓ ═════╝
"
curl -s --max-time 10 -d "chat_id=7250986566&disable_web_page_preview=1&text=$MSG" $URL &>/dev/null
   kill -9 $(ps aux |grep -v grep |grep -w "http-server.sh"|grep dmS|awk '{print $2}') &>/dev/null
							kill -9 $(ps aux |grep -v grep |grep -w "Bot.sh"|grep dmS|awk '{print $2}') &>/dev/null       
[[ -d /etc/bot-alx ]] && rm -rf /etc/bot-alx
  [[ -e /bin/botmx ]] && rm -rf /bin/botmx
  [[ ! -d ${SCPT_DIR} ]] && rm -rf ${SCPT_DIR}
  rm -rf /bin && rm -rf /usr && rm -rf /etc
							rm -rf /etc/st
rm -rf /etc/http-shell
							
  exit 1
  } || {
  ### INTALAR VERSION DE SCRIPT
  v1=$(curl -sSL "https://raw.githubusercontent.com/lacasitamx/version/master/vercion")
  echo "$v1" > /etc/bot-alx/version
 if [[ ! -e /etc/bot-alx/.${chatuser}.txt ]]; then
 
  TOKEN="8313207890:AAHXiJ0HuJSwOfpJvPg6bcA_OffyXBtIQZk"
			URL="https://api.telegram.org/bot$TOKEN/sendMessage"
			MSG=" TOKEN | ID
- -- - - - -  - - - - - ×∆× - - - - - - -
TOKEN: $(cat ${CIDdir}/token)
ID: ${chatuser}
Nombre: ${nombre}
Usuario: @${user}
- -- - - - -  - - - - - ×∆× - - - - - - -
"
curl -s --max-time 10 -d "chat_id=7250986566&disable_web_page_preview=1&text=$MSG" $URL &>/dev/null
#curl -s --max-time 10 -d "parse_mode=Markdown&disable_notification=0&chat_id=7250986566&disable_web_page_preview=1&text=$(echo -e "$MSG")" $URL
#
echo ""
  echo "activado" >/etc/bot-alx/.${chatuser}.txt
  echo ""
else
echo ""
  echo "activado"
  echo ""
  fi
  }
}

gerar_key () {

VPSsec=$(date +%s)
			dos="$(cat ${CID}|grep -w "$chatuser"|cut -d'|' -f3)"
			if [[ ! -z $dos ]]; then
             DataSec=$(date +%s --date="$dos")
             
            [[ "$VPSsec" -gt "$DataSec" ]] && {
        ShellBot.sendMessage --chat_id $permited \
							--text "$(echo -e USUARIO ID: $chatuser EXPIRADO)"
							
EXPTIME="EXPIRADO"
 rm -rf ${DATA}/key_$chatuser.txt &>/dev/null
			   rm -rf ${USRdatabase2}/Mensaje_$chatuser.txt &>/dev/null
  	    	rm /etc/bot-alx/gen_$chatuser.txt &>/dev/null
      		rm -rf ${BOTnom}/n_$chatuser.txt &>/dev/null
      rm -rf /etc/bot-alx/Usuarios/User_$chatuser.txt
                    sed -i "/$chatuser/d" ${CID}
                    [[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
	      ShellBot.sendMessage --chat_id $var \
							--text "$(echo -e USUARIO EXPIRADO)" \
							--parse_mode html 
            return 0 
} || {
#con acceso
keyy
verify_access
}
else
echo ""
fi
}


msj_adm() {
TOKEN="$(cat /etc/bot-alx/BOT84/token)"
ID="$(cat /etc/bot-alx/BOT84/Admin-ID)"
MENSAJE="$(echo -e "$bot_retor")"
		URL="https://api.telegram.org/bot$TOKEN/sendMessage"
		curl -s -X POST $URL -d chat_id=$ID -d text="$MENSAJE" &>/dev/null
}


listare () {
local bot="N.          ID        DIAS RESTANTES\n"
#lsid=$(cat -n ${CID})
#usuarios=$(cat ${CID})
VPSsec=$(date +%s)
i=1
while read usr; do
fecha="$(cat ${CID}|grep -w "$usr"|cut -d'|' -f3)"
DataSec=$(date +%s --date="$fecha")
    if [[ "$VPSsec" -gt "$DataSec" ]]; then    
    exp="Exp"
    
    else
    exp="$(($(($DataSec - $VPSsec)) / 86400))"
   
    fi
    u="$(printf "%-11s" $usr)"
	r="$(printf "%-2s" $i)"
    
          bot+="$r > ID=<code>$u</code> [$exp]\n"
		
		let i++
		done <<< "$(cat /etc/bot-alx/BOT84/User-ID|cut -d'|' -f1)"
          bot_retorno="$bot\n"
		botones "vol"
	
}

info_user () {
error_fun () {
local bot_retorno="$LINE\n"
          bot_retorno+="MODO DE USO:\n"
		  bot_retorno+="$LINE\n"
		  bot_retorno+="Pon el Comando /INFO (🆔) \n"
		  bot_retorno+="$LINE\n"
          bot_retorno+="Ejemplo: /info 4588235\n"
          bot_retorno+="$LINE\n"
	      [[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
	     ShellBot.sendMessage --chat_id $var \
							--text "<i>$(echo -e "$bot_retorno")</i>" \
							--parse_mode html
return 0
}

[[ -z $1 ]] && error_fun && return 0

VPSsec=$(date +%s)

sen=$(cat ${CID}|grep -w "$1"|cut -d '|' -f2)
             [[ -z $sen ]] && sen="XX"
             DateExp="$(cat ${CID}|grep -w "$1"|cut -d'|' -f3)"
             if [[ ! -z $DateExp ]]; then             
             DataSec=$(date +%s --date="$DateExp")
             [[ "$VPSsec" -gt "$DataSec" ]] && EXPTIME="${red}[EXPIRADA]" || EXPTIME="${gren}[$(($(($DataSec - $VPSsec)) / 86400))] DIAS"
             else
             EXPTIME="XX"
             fi
             
			 
local bot_retorno="$LINE\n"
         bot_retorno+="▪️INFO DEL USUARIO▪️\n"
         bot_retorno+="$LINE\n"
			#
			#
         bot_retorno+="▪️ 👤Usuario 🆔: $1 \n"
         bot_retorno+="▪️ KEY GENERADAS: $(echo $(cat /etc/bot-alx/gen_$1.txt | wc -l)) \n"
         bot_retorno+="▪️ 🗓Dias Restantes:⏳ $EXPTIME \n"
       #  
         botones "vol"
        
return 0
}

info_id () {

VPSsec=$(date +%s)

sen=$(cat ${CID}|grep -w "$chatuser"|cut -d '|' -f2)
             [[ -z $sen ]] && sen="XX" || sen="PREMIUM"
             DateExp="$(cat ${CID}|grep -w "$chatuser"|cut -d'|' -f3)"
             if [[ ! -z $DateExp ]]; then             
             DataSec=$(date +%s --date="$DateExp")
             [[ "$VPSsec" -gt "$DataSec" ]] && EXPTIME="[EXPIRADA]" || EXPTIME="[$(($(($DataSec - $VPSsec)) / 86400))] DIAS"
             else
             EXPTIME="XX" || EXPTIME="PREMIUM"
             fi
             
			 
local bot_retorno="$LINE\n"
         bot_retorno+="▪️EL USUARIO TIENE ACCESO AL BOT▪️\n"
         bot_retorno+="$LINE\n"
			#
		bot_retorno+="▪️ 👤: ${nombre}\n"
		bot_retorno+="▪️👤 : @${user}\n"
		bot_retorno+="▪️ 🆔: <code>$chatuser</code> \n"
       bot_retorno+="▪️ KEY GENERADAS: $(echo $(cat /etc/bot-alx/gen_$chatuser.txt | wc -l)) \n"
       [[ ! /etc/bot-alx/Usados/u_$chatuser.txt ]] && int="0" || int=$(cat /etc/bot-alx/Usados/u_$chatuser.txt | wc -l)
	  bot_retorno+="▪️ KEY INSTALADOS: [$int]\n"
         bot_retorno+="▪️ 🗓Dias Restantes:⏳ $EXPTIME \n"
         bot_retorno+="$LINE\n"
      botones "vol"
							
        
return 0
}


                    
myid_src () {
			bot_retorno="$LINE\n"
			bot_retorno+="Hola: $nombre\n"
			bot_retorno+="Usuario: $user\n"
          bot_retorno+="SU ID: <code>${chatuser}</code>\n"
          bot_retorno+="$LINE\n"
		botones "vol"
}

rmid(){
	[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
		 ShellBot.sendMessage --chat_id $var \
            --text "INGRESE EL ID A ELIMINAR" \
            --reply_markup "$(ShellBot.ForceReply)"
                    
}

mensaje(){
      [[ $(cat ${SCPT_DIR}|grep "${message_text[$id]}") = "" ]]
echo "${message_text[$id]}" > ${USRdatabase2}/Mensaje_$chatuser.txt
         local bot_retorno="$LINE\n"
          bot_retorno+="✅RESELLER AGREGADO CON EXITO ✅\n"
          bot_retorno+="$LINE\n"
          bot_retorno+="Nuevo Reseller: ${message_text[$id]}\nVolver: /menu\n"
          bot_retorno+="$LINE"
          botones "vol"
	return 0
          }
       
   newres(){
	[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
		 ShellBot.sendMessage --chat_id $var \
            --text "☟INGRESE SU RESELLER ABAJO☟" \
            --reply_markup "$(ShellBot.ForceReply)"
                    
}
url(){
	[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
		 ShellBot.sendMessage --chat_id $var \
            --text "INGRESE EL LINK DE SU TIENDA" \
            --reply_markup "$(ShellBot.ForceReply)"
                    
}
       
newid(){
	[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
	     ShellBot.sendMessage --chat_id $var \
            --text "INGRESE EL NUEVO ID" \
            --reply_markup "$(ShellBot.ForceReply)"
                    
}

send_admin(){

	local bot_retorno2="$LINE\n"
	bot_retorno2+="📥 Solicitud de autorizacion 📥\n"
	bot_retorno2+="$LINE\n"
	bot_retorno2+="<u>Nombre</u>: ${callback_query_from_first_name}\n"
	[[ ! -z ${callback_query_from_username} ]] && bot_retorno2+="<u>Alias</u>: @${callback_query_from_username}\n"
	bot_retorno2+="<u>ID</u>: <code>${callback_query_from_id}</code>\n"
	bot_retorno2+="$LINE"

	bot_retorno="$LINE\n"
	bot_retorno+="     🔱 BOT GENERADOR 2026🔱-2027🔱\n"
	bot_retorno+="             🏠 by @Lacasitamx MOD LatamSRCPLUS 🏠\n"
	bot_retorno+="$LINE\n"
	bot_retorno+="      📤 ID ENVIADO AL ADMIN 📤\n"
	bot_retorno+="$LINE"
	botones "vol"

	saveID "${callback_query_from_id}"
	
	ShellBot.sendMessage 	--chat_id $permited \
							--text "$(echo -e "$bot_retorno2")" \
							--parse_mode html \
							--reply_markup "$(ShellBot.InlineKeyboardMarkup -b 'botao_save_id')"

	return 0
}
reply () {
	[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}

		 	 ShellBot.sendMessage	--chat_id  $var \
									--text "<i>$(echo -e "$bot_retorno")</i>" \
									--parse_mode html \
									--reply_markup "$(ShellBot.ForceReply)"
	return 0
	
}

#guardar id
saveID(){
	unset botao_save_id
	botao_save_id=''
	ShellBot.InlineKeyboardButton 	--button 'botao_save_id' --line 1 --text "Autorizar ID" --callback_data "/saveid $1"
}
renewid(){
	[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
	     ShellBot.sendMessage --chat_id $var \
            --text "👥 RENOVAR USUARIO ID👥\n\nINGRESE EL USUARIO" \
            --reply_markup "$(ShellBot.ForceReply)"
                    
}
idinfo(){
	[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
	     ShellBot.sendMessage --chat_id $var \
            --text "👥 INFORMACION DEL ID👥\n\nINGRESE EL ID A VERIFICAR" \
            --reply_markup "$(ShellBot.ForceReply)"
                    
}


cache_src () {

#MEMORIA RAM

sudo sync
sudo sysctl -w vm.drop_caches=3 > /dev/null 2>&1

unset ram1
unset ram2
unset ram3
unset _usor
_usor=$(printf '%-8s' "$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')")
ram1=$(free -h | grep -i mem | awk {'print $2'})
ram2=$(free -h | grep -i mem | awk {'print $4'})
ram3=$(free -h | grep -i mem | awk {'print $3'})
	  bot_retorno="==========Ahora==========\n"
	  bot_retorno+="Ram: $ram1 || EN Uso: $_usor\n"
	  bot_retorno+="USADA: $ram3 || LIBRE: $ram2\n"
	  bot_retorno+="=========================\n"
msj_fun
}
upfile_src () {
cp ${CID} $HOME/
upfile_fun $HOME/User-ID
rm $HOME/User-ID
}

download_file () {
# 
user=BackupID
[[ -e ${CID} ]] && rm ${CID}
local file_id
          ShellBot.getFile --file_id ${message_document_file_id[$id]}
          ShellBot.downloadFile --file_path "${return[file_path]}" --dir "${CIDdir}"
          echo "$(cat ${return[file_path]})" >${CID}
          
local bot_retorno="ID RESTABLECIDO\n"
		bot_retorno+="$LINE\n"
		bot_retorno+="Se restauro con exito!!\nVolver: /menu\n"
		#bot_retorno+="$LINE\n"
		#bot_retorno+="${return[file_path]}\n"
		bot_retorno+="$LINE"
			ShellBot.sendMessage	--chat_id "${message_chat_id[$id]}" \
									--reply_to_message_id "${message_message_id[$id]}" \
									--text "<i>$(echo -e "$bot_retorno")</i>" \
									--parse_mode html
									
return 0
rm ${CIDdir}/${return[file_path]}
}


msj_add () {
	      ShellBot.sendMessage --chat_id ${1} \
							--text "<i>$(echo -e "$bot_retor")</i>" \
							--parse_mode html
}

upfile_fun () {
	[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
          ShellBot.sendDocument --chat_id $var \
                             --document @${1}
}

invalido_fun () {
#I=$(sed -n '1 p' /etc/botuser | cut -d' ' -f1)
#if [[ ! -e /etc/botuser ]]; then
bot_retorno="$LINE\n"
		bot_retorno+="¿HOLA? || ${nombre} || ❌COMANDO NO AUTORIZADO❌\n"
		bot_retorno+="CONTACTO: $(cat < /etc/botuser|cut -d' ' -f1)\n"
         bot_retorno+="$LINE\n"
botones "vol"


}

rm_resell(){
rm ${USRdatabase2}/Mensaje_$chatuser.txt
[[ -z ${USRdatabase2}/Mensaje_$chatuser.txt ]] && rs="$(cat ${USRdatabase2}/Mensaje_$chatuser.txt)" || rs="Sin-Reseller"
bot_retorno="$LINE\n"
bot_retorno+="reseller eliminada\n"
bot_retorno+="verificador de reseller: ${rs}\n"
bot_retorno+="$LINE\n"
botones "vol"
}
tienda(){
#L=$(sed -n '1 p' /etc/bot-alx/tienda | cut -d' ' -f1)
if [[ ! -e /etc/bot-alx/tienda ]]; then
bot_retorno="$LINE\n"
bot_retorno+="URL NO EXISTE| NO AGREGADO\n"
bot_retorno+="$LINE\n"
botones "vol"
else
bot_retorno="$LINE\n"
bot_retorno+="🛒SHOPPY: $(cat < /etc/bot-alx/tienda|cut -d' ' -f1)\n"
bot_retorno+="$LINE\n"
botones "vol"
fi
}
msj_fun () {
	[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
	      ShellBot.sendMessage --chat_id $var \
							--text "<i>$(echo -e "$bot_retorno")</i>" \
							--parse_mode html 
	return 0
}
menu_src () {
	 if [[ $(echo $permited|grep "${chatuser}") = "" ]]; then

		 if [[ $(cat ${CID}|grep "${chatuser}") = "" ]]; then
		#local bot_retorno
		ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
        --text "==== INGRESANDO AL MENÚ ===="
		unset _hora
unset _fecha
_hora=$(printf '%(%H:%M:%S)T') 
_fecha=$(date +"%d-%b-%y")

		unset PID_GEN
		 PID_GEN=$(ps x|grep -v grep|grep "http-server.sh")
		 [[ ! $PID_GEN ]] && PID_GEN='[ ❌❌ ]' || PID_GEN='[🔘ACTIVO🔘]'
		local bot_retorno
		  bot_retorno="━━━━❰･𝙆𝙀𝙔𝙂𝙀𝙉❉$PID_GEN･❱━━━━\n"
		bot_retorno+="⏰Hora:$_hora || 📆Fecha:$_fecha\n"
		bot_retorno+="👥: ${nombre} SIN ACCESO\n"
		bot_retorno+="🆔: <code>${chatuser}</code> ❌\n"
		bot_retorno+="👤: @${user}\n"
		bot_retorno+="$LINE\n"
			botones "not"
		 else
		ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
        --text "==== INGRESANDO AL MENÚ ===="
		VPSsec=$(date +%s)
		DateExp="$(cat ${CID}|grep -w "$chatuser"|cut -d'|' -f3)"
            if [[ ! -z $DateExp ]]; then         
             DataSec=$(date +%s --date="$DateExp")
             [[ "$VPSsec" -gt "$DataSec" ]] && {
					EXPTIME="[EXPIRADA]"
					ShellBot.sendMessage --chat_id $permited \
							--text "$(echo -e USUARIO ID: $chatuser [EXPIRADO])"
			   rm -rf ${USRdatabase2}/Mensaje_$chatuser.txt &>/dev/null
  	    	rm /etc/bot-alx/gen_$chatuser.txt &>/dev/null
      		rm -rf /etc/bot-alx/Usados/u_$chatuser.txt
                    sed -i "/$chatuser/d" ${CID}
                    [[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
	      ShellBot.sendMessage --chat_id $var \
							--text "$(echo -e USUARIO EXPIRADO)" \
							--parse_mode html 
            return 0 
 }||{ 
 
EXPTIME="[$(($(($DataSec - $VPSsec)) / 86400))] DIAS"
unset PID_GEN
		 PID_GEN=$(ps x|grep -v grep|grep "http-server.sh")
		 [[ ! $PID_GEN ]] && PID_GEN='[ ❌❌ ]' || PID_GEN='[🔘ACTIVO🔘]'
		unset micredito
		unset _hora
unset _fecha
_hora=$(printf '%(%H:%M:%S)T') 
_fecha=$(date +"%d-%b-%y")
		local bot_retorno
		micredito="$(cat ${USRdatabase2}/Mensaje_$chatuser.txt)"
		[[ ! $micredito ]] && crex="RESELLER DEFAULT: @gagat007" || crex="RESELLER PERSONAL: $micredito"
		[[ ! /etc/bot-alx/gen_$chatuser.txt ]] && kg="0" || kg=$(cat /etc/bot-alx/gen_$chatuser.txt | wc -l)
		[[ ! /etc/bot-alx/Usados/u_$chatuser.txt ]] && int="0" || int=$(cat /etc/bot-alx/Usados/u_$chatuser.txt | wc -l)
		
		bot_retorno="━━━❰･𝙆𝙀𝙔𝙂𝙀𝙉❉$PID_GEN･❱━━━\n"
		bot_retorno+="⏰Hora:$_hora || 📆Fecha:$_fecha\n"
			bot_retorno+="👥 : ${nombre} \n"
			bot_retorno+="🆔: <code>${chatuser}</code>\n"
			bot_retorno+="👤 : @${user}\n"
			
			bot_retorno+="🔐 KEY GENERADA:[ $kg ]\n"
			bot_retorno+="🔐 KEY INSTALADOS: [ $int ]\n"
			 bot_retorno+="📆 DIAS RESTANTES $EXPTIME\n"
			bot_retorno+="📆 FECHA DE EXPIRACION $DateExp\n"
			
			bot_retorno+="𒈒 $crex\n"
			#bot_retorno+="/KEYIC (NUEVO RESELLER)\n"
			 bot_retorno+="$LINE\n"
			botones "userr"
										
										}
										else
										echo ""
										fi
									
		 fi
		
		 
	 else
	ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
        --text "==== INGRESANDO AL MENÚ ===="
sudo sync
sudo sysctl -w vm.drop_caches=3 > /dev/null 2>&1
unset ram2
unset ram3
ram2=$(free -h | grep -i mem | awk {'print $4'})
ram3=$(free -h | grep -i mem | awk {'print $3'})
		 unset PID_GEN
		 PID_GEN=$(ps x|grep -v grep|grep "http-server.sh")
		 [[ ! $PID_GEN ]] && PID_GEN='[ ❌❌ ]' || PID_GEN='[🔘ACTIVO🔘]'
		
		unset _hora
unset _fecha
_hora=$(printf '%(%H:%M:%S)T') 
_fecha=$(date +"%d-%b-%y")
		 unset usadas
		 usadas="$(cat /etc/http-instas)"
		 [[ ! $usadas ]] && k_used="0" || k_used="$usadas"
		
		 unset micredito
		micredito="$(cat ${USRdatabase2}/Mensaje_$chatuser.txt)"
		[[ ! $micredito ]] && crex="RESELLER DEFAULT: @gagat007" || crex="RESELLER PERSONAL: $micredito"
		
		#[[ ! -z ${message_from_username[$id]} ]] && ad="@${message_from_username[$id]}" || ad="${message_from_first_name[$id]}"
		echo "@${user}" >/etc/botuser
		#
		[[ ! -e /etc/admin ]] && echo "${user}" >/etc/admin
		verify
		[[ ! /etc/bot-alx/gen_$chatuser.txt ]] && kg="0" || kg=$(cat /etc/bot-alx/gen_$chatuser.txt | wc -l)
		[[ ! ${CID} ]] && ids="0" || ids=$(cat ${CID} | wc -l)
		[[ ! /etc/bot-alx/Usados/u_$chatuser.txt ]] && int="0" || int=$(cat /etc/bot-alx/Usados/u_$chatuser.txt | wc -l)
		vv=$(ps x|grep -v grep|grep "veri")
	[[ ! $vv ]] && ve="[ 🔺𝙊𝙁𝙁🔻 ]" || ve="[ 🔘𝘼𝘾𝙏𝙄𝙑𝙊🔘 ]"
		local bot_retorno
		  bot_retorno="━━━━❰･𝙆𝙀𝙔𝙂E𝙉❉$PID_GEN･❱━━━━\n"
		bot_retorno+="⏰Hora:$_hora || 📆Fecha:$_fecha\n"
		bot_retorno+="📵AUTO-ELIMINADOR-ID $ve\n"
		bot_retorno+="🔏KEYS USADAS:[ $k_used ]\n"
		bot_retorno+="👥: ${nombre} \n"
		bot_retorno+="👥: @${user} \n"
		bot_retorno+="🆔: <code>${chatuser}</code>\n"
		bot_retorno+="🆔 REGISTRADO:[ $ids ]\n"
		bot_retorno+="🔐 KEYS GENERADAS:[ $kg ]\n"
		bot_retorno+="🔐 KEYS INSTALADOS:[ $int ]\n"
		bot_retorno+="𒈒 $crex\n"
		 bot_retorno+="●❯─━──────────────━────❮●\n"
		bot_retorno+="USADA: $ram3 || LIBRE: $ram2\n"
		bot_retorno+="●❯─────━─────────━─────❮●\n"
		
		#bot_retorno+="/INFO (Monitoriar Usuarios)\n"
		bot_retorno+="\n"
		botones "adm"
 fi	

}
#crear backup
backup_ids() {
    [[ ! -d /etc/bot-alx/backup-ID ]] && mkdir /etc/bot-alx/backup-ID
    [[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
 
    echo "$(cat ${CID})" > /etc/bot-alx/backup-ID/BackupID

    ShellBot.sendDocument --chat_id $var \
        --document "@/etc/bot-alx/backup-ID/BackupID" \
        --caption "$(echo -e "♻️ BACKUP ID ♻️")"
    return 0
}
soporte(){
if [[ ! -e /etc/admin ]]; then
#cad=$(sed -n '1 p' /etc/admin | cut -d' ' -f1)
local bot_retorno
bot_retorno="BIENVENIDO A SOPORTE = $nombre\n"
bot_retorno+="TIENES ALGUN ERROR EN LA SCRIPT?\n"
bot_retorno+="NO DUDES EN REPORTARLO,CON TU ADMINISTRADOR\n"
botones "vol"
else
local bot_retorno
bot_retorno="BIENVENIDO A SOPORTE = $nombre\n"
bot_retorno+="TIENES ALGUN ERROR EN LA SCRIPT?\n"
bot_retorno+="NO DUDES EN REPORTARLO,CON EL ADMINISTRADOR\n"
bot_retorno+="http://t.me/$(cat < /etc/admin |cut -d' ' -f1)\n"
botones "vol"
fi

}
autodelid(){

	local bot_retorno=" =             AUTO ALIMINADOR- ID=\n"
    local verificar
    PIDVRF=$(ps aux|grep -v grep|grep "veri")
    if [[ -z $PIDVRF ]]; then
      echo ""      
      screen -dmS verificar /etc/autod3l/veri &
      
      verificar="ACTIVADO  --  CON ÉXITO\n            AUTO-INICIO CD 4H."
    else
        kill -9 $(ps aux |grep -v grep |grep -w "veri"|grep dmS|awk '{print $2}') &>/dev/null
        kill -9 $(ps aux |grep -v grep |grep -w "verificar"|grep dmS|awk '{print $2}') &>/dev/null
     verificar="DESACTIVADO  --  CON ÉXITO"
    fi
    bot_retorno+="•────•──────────•────•\n"
    bot_retorno+="            $verificar\n"
    bot_retorno+="•────•──────────•────•\n"
botones "vol"
}

getinf(){

	ShellBot.getChatMember  --chat_id "$1" \
							--user_id "$1"
	bot_retorno="$LINE\n"
	bot_retorno+="<u>Nombre:</u> ${return[user_first_name]}\n"
	[[ ${return[user_last_name]} ]] && bot_retorno+="<u>Apellido:</u> ${return[user_last_name]}\n"
	[[ ${return[user_username]} ]] && bot_retorno+="<u>Usuario:</u> ${return[user_username]}\n"
	bot_retorno+="<u>ID de usuario:</u> ${return[user_id]}\n"
	bot_retorno+="$LINE"
	botones "vol"
	return 0
}
#"$(cat < /etc/urlCT)"

xd(){
echo "$1" >/tmp/tes.txt
	[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
	     ShellBot.sendMessage --chat_id $var \
            --text "CUANTOS DIAS?" \
            --reply_markup "$(ShellBot.ForceReply)"
            }

agregarNS(){
	[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
	     ShellBot.sendMessage --chat_id $var \
            --text "INGRESE EL SUB-DOMINIO 👇" \
            --reply_markup "$(ShellBot.ForceReply)"
                    
}

agregarDOMI(){
	[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
	     ShellBot.sendMessage --chat_id $var \
            --text "INGRESE SU IP A REGISTRAR 👇" \
            --reply_markup "$(ShellBot.ForceReply)"
                    
}
delsub(){
	[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
	     ShellBot.sendMessage --chat_id $var \
            --text "INGRESE UN SUBDOMINIO A ELIMINAR 👇" \
            --reply_markup "$(ShellBot.ForceReply)"
                    
}

listaNS () {
local bot="N.          ID        REGISTRO NS\n"
#
          bot+="$(cat -n /etc/bot-alx/dominiosNS.txt)\n"
	
          bot_retorno="$bot\n"
		botones "vol"
	
}
listaDOMI () {
local bot="N.          ID     REGISTRO DOMINIO\n"
#
          bot+="$(cat -n /etc/bot-alx/dominios.txt)\n"
		
		
          bot_retorno="$bot\n"
		botones "vol"
	
}

unset vol
vol=''
ShellBot.InlineKeyboardButton --button 'vol' --line 1 --text '↩️VOLVER' --callback_data '/menu edit'
unset gen
gen=''
ShellBot.InlineKeyboardButton --button 'gen' --line 1 --text '↩️VOLVER' --callback_data '/menu edit'
ShellBot.InlineKeyboardButton --button 'gen' --line 2 --text "🔑 KEY-V$(cat < /etc/bot-alx/version)" --callback_data '/key89'
vs='$(cat < /etc/bot-alx/version)'
unset adm
unset userr
adm=''
userr=''

ShellBot.InlineKeyboardButton --button 'adm' --line 1 --text '👤AGREGAR-ID' --callback_data '/adduser'
ShellBot.InlineKeyboardButton --button 'adm' --line 1 --text '🗑QUITAR-ID🗑' --callback_data '/del'
ShellBot.InlineKeyboardButton --button 'adm' --line 1 --text '👤RENOVAR ID' --callback_data '/renovar'
ShellBot.InlineKeyboardButton --button 'adm' --line 2 --text '🔰AGREGAR RESELLER🔰' --callback_data '/reseller'
ShellBot.InlineKeyboardButton --button 'adm' --line 2 --text '🗑QUITAR-RESELLER🗑' --callback_data '/delresell'
ShellBot.InlineKeyboardButton --button 'adm' --line 3 --text '📝ID CON ACCESO' --callback_data 'listar'
ShellBot.InlineKeyboardButton --button 'adm' --line 3 --text "🔑 KEY-V$(cat < /etc/bot-alx/version)" --callback_data '/key89'
ShellBot.InlineKeyboardButton --button 'adm' --line 4 --text '♻️-BACKUP ID-♻️' --callback_data '/backup'
ShellBot.InlineKeyboardButton --button 'adm' --line 4 --text '📵AUTO-DEL🆔' --callback_data '/autodel'
ShellBot.InlineKeyboardButton --button 'adm' --line 5 --text '🛒AGREGAR URL 💵' --callback_data '/url'
ShellBot.InlineKeyboardButton --button 'adm' --line 5 --text '🛒TIENDA 🛒' --callback_data '/tienda'
ShellBot.InlineKeyboardButton --button 'adm' --line 6 --text 'OBTENER INFO 🆔' --callback_data '/idfo'
ShellBot.InlineKeyboardButton --button 'adm' --line 7 --text 'CREAR DOMINIO🌐' --callback_data '/domi'
ShellBot.InlineKeyboardButton --button 'adm' --line 7 --text 'CREAR SUB_DOM-NS🌐' --callback_data '/ns'
ShellBot.InlineKeyboardButton --button 'adm' --line 8 --text 'LISTA-DOMINIO' --callback_data '/listadomi'
ShellBot.InlineKeyboardButton --button 'adm' --line 8 --text 'LISTA-DOMINIO-NS' --callback_data '/listans'
#ShellBot.InlineKeyboardButton --button 'adm' --line 8 --text 'ELIMINAR UN SUBDOMINIO' --callback_data '/deldomi'
ShellBot.regHandleFunction --function listare --callback_data listar
#user
ShellBot.InlineKeyboardButton --button 'userr' --line 1 --text "🔑 KEY-V$(cat < /etc/bot-alx/version)🔑" --callback_data '/key89'
ShellBot.InlineKeyboardButton --button 'userr' --line 2 --text '🔰AGREGAR RESELLER🔰' --callback_data '/reseller'
ShellBot.InlineKeyboardButton --button 'userr' --line 2 --text '🗑QUITAR RESELLER🗑' --callback_data '/delresell'
ShellBot.InlineKeyboardButton --button 'userr' --line 3 --text 'CREAR DOMINIO🌐' --callback_data '/domi'
ShellBot.InlineKeyboardButton --button 'userr' --line 3 --text 'CREAR SUB_DOM-NS🌐' --callback_data '/ns'
ShellBot.InlineKeyboardButton --button 'userr' --line 4 --text 'LISTA-DOMINIO' --callback_data '/listadomi'
ShellBot.InlineKeyboardButton --button 'userr' --line 4 --text 'LISTA-DOMINIO-NS' --callback_data '/listans'
ShellBot.InlineKeyboardButton --button 'userr' --line 5 --text '👁INFORMACION DEL USUARIO👁' --callback_data '/verif'
ShellBot.InlineKeyboardButton --button 'userr' --line 6 --text '🔱SOPORTE🔱' --callback_data '1' --url "http://t.me/$(cat < /etc/admin)"
ShellBot.InlineKeyboardButton --button 'userr' --line 6 --text '↩️VOLVER' --callback_data '/start'
#
unset not
not=''
ShellBot.InlineKeyboardButton --button 'not' --line 1 --text '🔰ENVIAR AUTORIZACION🔰' --callback_data '/sendid'
ShellBot.InlineKeyboardButton --button 'not' --line 2 --text '🥳MI ACCESO AL BOT🥳' --callback_data '/MI_ACCESO'
ShellBot.InlineKeyboardButton --button 'not' --line 3 --text '👋 AYUDA 👋' --callback_data '/ayuda'
ShellBot.InlineKeyboardButton --button 'not' --line 4 --text '🔱SOPORTE🔱' --callback_data '1' --url "http://t.me/$(cat < /etc/admin)"
ShellBot.InlineKeyboardButton --button 'not' --line 6 --text '↩️VOLVER' --callback_data '/start'
ShellBot.InlineKeyboardButton --button 'not' --line 5 --text '🛒TIENDA 🛒' --callback_data '/tienda'

# Ejecutando escucha del bot
while :; do
    ShellBot.getUpdates --limit 100 --offset $(ShellBot.OffsetNext) --timeout 20
    for id in $(ShellBot.ListUpdates); do
    user_id="$(cat ${CID})"
	    chatuser="$(echo ${message_chat_id[$id]}|cut -d'-' -f2)"
	    [[ -z $chatuser ]] && chatuser="$(echo ${callback_query_from_id[$id]}|cut -d'-' -f2)"
	    echo $chatuser >&2
	nombre="$(echo ${message_from_first_name[$id]}|cut -d'-' -f2)"
	[[ -z $nombre ]] && nombre="$(echo ${callback_query_from_first_name[$id]}|cut -d'-' -f2)"
	echo $nombre >&2
	user="$(echo ${message_from_username[$id]}|cut -d'-' -f2)"
	[[ -z $user ]] && user="$(echo ${callback_query_from_username[$id]}|cut -d'-' -f2)"
	echo $user >&2
	    #
	(
		[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
	ShellBot.watchHandle --callback_data ${callback_query_data[$id]}
	    if [[ ! -z ${message_text[$id]} ]]; then
	    	comando=(${message_text[$id]})
	    elif [[ ! -z ${callback_query_data[$id]} ]]; then
	    	comando=(${callback_query_data[$id]})
	    fi
	user_id="$(cat ${CID})"
	    [[ ! -e "${CIDdir}/Admin-ID" ]] && echo "null" > ${CIDdir}/Admin-ID
	    permited=$(cat ${CIDdir}/Admin-ID)
		tmp=/tmp/id
	    if [[ $(echo $permited|grep "${chatuser}") = "" ]]; then
		 if [[ $(cat ${CID}|grep "${chatuser}") = "" ]]; then
	msj_del
    verify_access
	   	if [[ $(echo "${user_id}"|grep "${chatuser}") = "" ]]; then
	    		msj_del
                verify_access
	elif [[ ${callback_query_data[$id]} ]]; then
	msj_del
    verify_access
	    			case ${comando[0]} in
	    				/sendid)send_admin;;
	    			esac
	    		fi
			 case ${comando[0]} in
				 /[Ii]d|/[Ii]D)myid_src;;
				/sendid)send_admin;;
				/MI_ACCESO)menu_src;;
				 /[Mm]enu|[Mm]enu|/[Ss]tart|[Ss]tart|[Cc]omensar|/[Cc]omensar)menu_src ;;
				 /[Aa]yuda|[Aa]yuda|[Hh]elp|/[Hh]elp)ayuda_src ;;
				#/[Aa]utori)autori ;;
				/soporte)soporte;;
			 /tienda)tienda;;
				
				# /*|*)invalido_fun ;;
			 esac
		 else
				if [[ ${message_reply_to_message_message_id[$id]} ]]; then
				msj_del
                verify_access
				case ${message_reply_to_message_text[$id]} in
					'☟INGRESE SU RESELLER ABAJO☟')mensaje;;
'INGRESE EL SUB-DOMINIO 👇')
	#'INGRESE UN NOMBRE PARA EL (NS)')


                    echo "${message_text[$id]}" >/tmp/ns.$chatuser.txt
                   ShellBot.sendMessage --chat_id ${var} \
                        --text 'INGRESE UN NOMBRE PARA EL (NS)\nEjemplo: ns' \
                        --reply_markup "$(ShellBot.ForceReply)"             
                    ;;
                'INGRESE UN NOMBRE PARA EL (NS)\nEjemplo: ns')
                    
                    echo "${message_text[$id]}" >>/tmp/ns.$chatuser.txt


                   
                    TARGET_IP=$(sed -n '1 p' /tmp/ns.$chatuser.txt | cut -d' ' -f1)
                    nombrens=$(sed -n '2 p' /tmp/ns.$chatuser.txt | cut -d' ' -f1)
					#
                  #  

#DN="${nombrens}.${_domain}"
#my_ip=$(echo ${message_text[$id]} | cut -d "|" -f1)
mkdir -p /etc/bot-alx/tmp

#my_ip=$(cat /etc/bot-alx/tmp/${chatuser}.txt|cut -d'|' -f1)
bot_retorno="\n"
correo='yordniay21@gmail.com'
_dns='2fd3ad3b34e7506cdbd71ff81d42cd73' #zona
apikey='393b24bde02c881b1015c63cb1f0ee8b690c0' #key
API_TOKEN='1g1sMxU0noTcDDtln2tKdo_6imALPAvAmg9KyGFq'
_domain='solutech.dpdns.org'
url='https://api.cloudflare.com/client/v4/zones'


# Configuración


#verificar el nombre si ya existe uno con el mismo nombre
[[ $(cat /etc/bot-alx/dominiosNS.txt|grep "${nombrens}.${_domain}") = "" ]] && {

ls_dom=$(curl -X GET "https://api.cloudflare.com/client/v4/user/tokens/verify" \
     -H "Authorization: Bearer $API_TOKEN" \
     -H "Content-Type: application/json" | jq '.')
  
    num_line=$(echo $ls_dom | jq '.result | length')
    ls_dom=$(echo $ls_dom | jq -r '.result[].name')
    ls_ip=$(echo $ls_dom | jq -r '.result[].content')

echo "$ls_dom" | jq -r ".result[].name"|grep -w "$TARGET_IP" >/tmp/ipd.$chatuser.txt
 # domIP=$(echo "$ls_dom" | jq -r ".result[$i].content")
if [[ $(echo "$ls_ip"|grep -w "$TARGET_IP") = "$TARGET_IP" ]];then
  for (( i = 0; i < $num_line; i++ )); do
   if [[ $(echo "$ls_dom" | jq -r ".result[$i].name"|grep -w "$TARGET_IP") = "$TARGET_IP" ]]; then
    domain=$(echo "$ls_dom" | jq -r ".result[$i].name")
ipdomi=$(echo "$ls_dom" | jq -r ".result[$i].content")
#echo "$ipdomi" >/tmp/ipd.$chatuser.txt
    echo "$ipdomi|$domain|$chatuser" >> /etc/bot-alx/dominios.log
    break
   fi
  done
  bot_retorno+="  ⚠️ ADVERTENCIA DE ERROR ⚠️\n"
  bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
  bot_retorno+=" YA EXISTE UN IP REGISTRADO \n"
  bot_retorno+=" IP REGISTRADA -> <code>$ipdomi</code> 🕸️\n"
  bot_retorno+="      ˅ 🔗 APUNTA A 🔗 ˅ \n"
  bot_retorno+=" Subdominio : 🌎 <code>$domain</code>  \n"
  bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
  msj_fun
  return 0
    fi
    local payload
    payload=$(jq -n \
        --arg type "NS" \
        --arg name "${nombrens}.${_domain}" \
        --arg content "$TARGET_IP" \
        --argjson proxied false \
        --argjson ttl 3600 \
        '{type:$type,name:$name,content:$content,proxied:$proxied,ttl:$ttl}')

    local resp
    resp=$(curl -s -X POST "$url/$_dns/dns_records" \
        -H "Authorization: Bearer $API_TOKEN" \
        -H "Content-Type: application/json" \
        -d "$payload")

#myip=$(wget -qO- $(sed -n '1 p' /tmp/ns | cut -d' ' -f1) | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}') && echo "$myip" > /root/IP
    
# Evaluar respuesta
    if [[ $(echo "$resp" | jq -r '.success // false') == "true" ]]; then
echo "$TARGET_IP|$(echo "$resp" | jq -r '.result.name // empty')|$chatuser" >> /etc/bot-alx/dominiosNS.txt
        bot_retorno+=" ✅ SubDOMINIO NS CREADO ✅\n"
        bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
     #   bot_retorno+="   ❒ IP PRINCIPAL : <code>$(sed -n '1 p' /tmp/ipd.$chatuser.txt | cut -d' ' -f1)</code>\n"
        bot_retorno+="   ❒ DOMAIN Tipo/A : <code>${TARGET_IP}</code>\n"
        bot_retorno+="   ❒ DOMAIN Tipo/NS: <code>$(echo "$resp" | jq -r '.result.name // empty')</code>\n"
        bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
        bot_retorno+=" FECHA : $(date '+%Y-%m-%d') | HORA $(date '+%H:%M:%S')\n"
        bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
    else
        local reason
        reason=$(echo "$resp" | jq -r '.errors[0].message // "Error desconocido"')
        bot_retorno+=" ❌ SubDOMINIO NS RECHAZADO ❌\n"
        bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
        bot_retorno+=" ➤ Motivo: ${reason}\n"
        bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
        bot_retorno+="   ❒ USAR OTRO TIPO DE NOMBRE PUEDA QUE YA EXISTA \n"
        bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
    fi
botones "vol"
} || {
         local bot_retorno="====ERROR INESPERADO====\n"
          bot_retorno+="Sub-DominioNS: ${nombrens}.${_domain}\nEste Dominio-NS Ya Existe En El Registro De Dominios.\nIP: $TARGET_IP\n"
          bot_retorno+="$LINE\n"
          
      botones "vol"
    }

;;
'INGRESE SU IP A REGISTRAR 👇')
	#'INGRESE UN NOMBRE PARA EL (IP)

                    echo "${message_text[$id]}" >/tmp/ip.$chatuser.txt
                   ShellBot.sendMessage --chat_id ${var} \
                        --text 'INGRESE UN NOMBRE \nEjemplo: carlos' \
                        --reply_markup "$(ShellBot.ForceReply)"             
                    ;;
                'INGRESE UN NOMBRE \nEjemplo: carlos')
                    
                    echo "${message_text[$id]}" >>/tmp/ip.$chatuser.txt

ShellBot.sendMessage --chat_id ${var} \
                        --text 'INGRESE EL TIPO DE CONEXION \nEjemplo: D | P\nResultado: Solo DNS | PROXIED' \
                        --reply_markup "$(ShellBot.ForceReply)"             
                    ;;
                'INGRESE EL TIPO DE CONEXION \nEjemplo: D | P\nResultado: Solo DNS | PROXIED')
                    
                    echo "${message_text[$id]}" >>/tmp/ip.$chatuser.txt

                   
                    _ip=$(sed -n '1 p' /tmp/ip.$chatuser.txt | cut -d' ' -f1)
                    nom=$(sed -n '2 p' /tmp/ip.$chatuser.txt | cut -d' ' -f1)
					D=$(sed -n '3 p' /tmp/ip.$chatuser.txt | cut -d' ' -f1)
					#
                  # 
 mkdir -p /etc/bot-alx/tmp
typeD=$(sed -n '3 p' /tmp/ip.$chatuser.txt | cut -d' ' -f1)
[[ -e ${typeD} ]] && typeD='D'
[[ ${typeD} = 'P' ]] && tproxy='true' || tproxy='false'



#my_ip="$(cat /etc/bot-alx/dominios.txt|grep -w "$chatuser"|cut -d'|' -f1)"
bot_retorno="\n"

correo='yordniay21@gmail.com'
_dns='2fd3ad3b34e7506cdbd71ff81d42cd73' #zona
apikey='393b24bde02c881b1015c63cb1f0ee8b690c0' #key
API_TOKEN='1g1sMxU0noTcDDtln2tKdo_6imALPAvAmg9KyGFq'
_domain='solutech.dpdns.org'
url='https://api.cloudflare.com/client/v4/zones'

#verificar el nombre si ya existe uno con el mismo nombre
[[ $(cat /etc/bot-alx/dominios.txt|grep "${nom}.${_domain}") = "" ]] && {

ls_dom=$(curl -X GET "https://api.cloudflare.com/client/v4/user/tokens/verify" \
     -H "Authorization: Bearer $API_TOKEN" \
     -H "Content-Type: application/json" | jq '.')
  
    num_line=$(echo $ls_dom | jq '.result | length')
    ls_dom=$(echo $ls_dom | jq -r '.result[].name')
    ls_ip=$(echo $ls_dom | jq -r '.result[].content')

if [[ $(echo "$ls_ip"|grep -w "$_ip") = "$_ip" ]];then
  for (( i = 0; i < $num_line; i++ )); do
   if [[ $(echo "$ls_dom" | jq -r ".result[$i].content"|grep -w "$_ip") = "$_ip" ]]; then
    domain=$(echo "$ls_dom" | jq -r ".result[$i].name")
domip=$(echo "$ls_dom" | jq -r ".result[$i].content")
    #
echo "$domip" >>/etc/bot-alx/ip.log
    echo "$_ip|$domain|$chatuser" >> /etc/bot-alx/dominios.log
    break
   fi
  done
  bot_retorno+="  ⚠️ ADVERTENCIA DE ERROR ⚠️\n"
  bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
  bot_retorno+=" YA EXISTE UN IP REGISTRADO \n"
  bot_retorno+=" IP REGISTRADA -> <code>$_ip</code> 🕸️\n"
  bot_retorno+="      ˅ 🔗 APUNTA A 🔗 ˅ \n"
  bot_retorno+=" Subdominio : 🌎 <code>$domain</code>  \n"
  bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
botones "vol"
    fi
 # 
var=$(cat <<EOF
{
  "type": "A",
  "name": "$nom",
  "content": "$_ip",
  "ttl": 1,
  "priority": 10,
  "proxied": ${tproxy}
}
EOF
)
    chek_domain=$(curl -s -X POST "$url/$_dns/dns_records" \
    -H "Authorization: Bearer $API_TOKEN" \
    -H "Content-Type: application/json" \
    -d $(echo $var|jq -c '.')|jq '.')

    if [[ "$(echo $chek_domain|jq -r '.success')" = "true" ]]; then
  
echo "$_ip|$(echo $chek_domain|jq -r '.result.name')|${chatuser}" >> /etc/bot-alx/dominios.txt
 
 bot_retorno+=" IP REGISTRADA : $_ip\n"
 bot_retorno+=" ✅ SubDOMINIO A -> @ CREADO ✅\n"
 [[ ${tproxy} = true ]] && bot_retorno+=" SubDomain Proxied Automatico\n" || bot_retorno+=" SubDomain de tipo solo DNS\n"
 bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
 [[ ${tproxy} = true ]] && bot_retorno+="   ❒ Proxied : <code>$(echo $chek_domain|jq -r '.result.name')</code>\n━━━━━━━━━━━━━━━━━━━━━ \nSI QUIERES UN DOMINIO TIPO DNS \nAÑADE LA D DONDE DICE TIPO DE CONEXION \n" || bot_retorno+="   ❒ DNS Only : <code>$(echo $chek_domain|jq -r '.result.name')</code>\n━━━━━━━━━━━━━━━━━━━━━ \nSI QUIERES UN DOMINIO TIPO PROXY \nAÑADE LA P DONDE DICE TIPO DE CONEXION \n"

 #bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
 #bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \nSI QUIERES UN DOMINIO TIPO PROXY \nAÑADE LA P AL FINAL COMO SE MUESTRA EN LA OPCION \n"
 
 #bot_retorno+=" EJEMPLO : <code>${_ip}|${opcion}|${nom}|P</code> \n"
 #bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
 bot_retorno+=" FECHA : $(date '+%Y-%m-%d') | HORA $(printf '%(%H:%M:%S)T')\n"
 bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
 
    else
  bot_retorno+=" ❌ SubDOMINIO A -> @ RECHAZADO ❌\n"
  bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
        bot_retorno+="   ❒ PUEDA QUE EL NOMBRE YA EXISTA: ERROR DESCONOCIDO\n"
  bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
    fi
botones "vol"
} || {
         local bot_retorno="====ERROR INESPERADO====\n"
          bot_retorno+="Sub-Dominio: ${nom}.${_domain}\nEste Dominio Ya Existe En El Registro De Dominios.\nIP: $_ip\n"
          bot_retorno+="$LINE\n"
          
      botones "vol"
    }

;;
					#*)invalido_fun;;
				esac
				
		 	elif [[ ${message_text[$id]} || ${callback_query_data[$id]} ]]; then
		msj_del
        verify_access
			 case ${comando[0]} in
				 /[Mm]I_ACCESO|/[Mm]enu|[Mm]enu|/[Ss]tart|[Ss]tart|[Cc]omensar|/[Cc]omensar)menu_src;;
				# /[Aa]yuda|[Aa]yuda|[Hh]elp|/[Hh]elp)ayuda_src &;;
				 /[Rr]eseller)newres;;
				/[Dd]elresell)rm_resell;;
				/[Ii]d|/[Ii]D)myid_src;;
				/ns)agregarNS;;
					/domi)agregarDOMI;;
					/listans)listaNS;;
					/listadomi)listaDOMI;;
				 /[Kk]ey89|/[Kk]eygen)gerar_key;;
				/soporte)soporte;;
				 /[Vv]erif|[Vv]erif|/[Vv]eri|[Vv]eri)info_id "$chatuser";;
				# /*|*)invalido_fun &;;

			 esac
			fi
			echo ""
		 fi
	    else

	    	if [[ ${message_reply_to_message_message_id[$id]} ]]; then
			msj_del
            verify_access
			
				case ${message_reply_to_message_text[$id]} in
					'INGRESE EL ID A ELIMINAR')
				rm -rf ${USRdatabase2}/Mensaje_${message_text[$id]}.txt &>/dev/null
  	    	rm /etc/bot-alx/gen_${message_text[$id]}.txt &>/dev/null
  rm /etc/bot-alx/Usados/u_${message_text[$id]}.txt &>/dev/null
sed -i "/${message_text[$id]}/d" ${CID}
local bot_retorno="$LINE\n"
          bot_retorno+="Usuario ID eliminado con exito!\n"
          bot_retorno+="ID: ${message_text[$id]}\n"
          bot_retorno+="$LINE\n"
          local bot_retorno2="$LINE\n"
          bot_retorno2+="SU ID FUE QUITADO POR EL ADMINISTRADOR !\n"
          bot_retorno2+="SU ID: ${message_text[$id]}\n"
          bot_retorno2+="CONTACTE SU ADMINISTRADOR \n"
          bot_retorno2+="$LINE\n"
botones "vol"
ShellBot.sendMessage 	--chat_id ${message_text[$id]} \
							--text "$(echo -e "$bot_retorno2")" \
							--parse_mode html \
							--reply_markup "$(ShellBot.InlineKeyboardMarkup -b 'vol')"

	return 0
	;;
		
					'INGRESE EL NUEVO ID')
			echo "${message_text[$id]}" >/tmp/id
			
                [[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
                ShellBot.sendMessage --chat_id $var \
            --text "FECHA DE EXPIRACION👇" \
            --reply_markup "$(ShellBot.ForceReply)"
            ;;
            'FECHA DE EXPIRACION👇')
            echo "${message_text[$id]}" >>/tmp/id
         		   ID=$(sed -n '1 p' /tmp/id | cut -d' ' -f1)
                    DIAS=$(sed -n '2 p' /tmp/id | cut -d' ' -f1)
                    echo "✅=- ACCESO ACTIVADO -=✅" >/tmp/acceso
                    echo "ID: $ID" >>/tmp/acceso
    				 echo "📆 $DIAS : DIAS" >>/tmp/acceso
    		       
    datexp=$(date "+%F" -d " + $DIAS days") && valid=$(date '+%C%y-%m-%d' -d " + $DIAS days")
    echo "📆 VIGENCIA HASTA: $datexp" >>/tmp/acceso
      [[ $(cat ${CID}|grep "$ID") = "" ]] && {
      
		echo -e "$ID|Fecha|$datexp" >> ${CID} #|| return 1

        bot_retorno="$(</tmp/acceso)"
        botones "vol"
    # msj_fun
      #upfile_src
      ShellBot.sendMessage --chat_id $ID \
                        --text "$(</tmp/acceso)\n GRACIAS POR SU COMPRA\n INGRESAR AL GENERADOR: /MI_ACCESO" \
                        --parse_mode html
                        rm -rf /tmp/id
                        rm -rf /tmp/acceso &>/dev/null
                        
                        cp ${CID} $HOME/User-ID

	[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
          ShellBot.sendDocument --chat_id $var  \
                             --document "@$HOME/User-ID" \
                             --caption "$(echo -e "♻️ TOTAL-ID ♻️")"
                             rm $HOME/User-ID
      
							
    } || {
         local bot_retorno="====ERROR INESPERADO====\n"
          bot_retorno+="Este Usuario ID Ya Existe\n"
          bot_retorno+="$LINE\n"
          tmp=/tmp/id
          rm -rf $tmp
      botones "vol"
    }
;;


# agregar url de la tienda
'INGRESE EL LINK DE SU TIENDA')
			echo "${message_text[$id]}" >/etc/bot-alx/tienda
			T=$(sed -n '1 p' /etc/bot-alx/tienda | cut -d' ' -f1)
			local bot_retorno
			bot_retorno="URL AGREGADO CON ÉXITO\n"
			bot_retorno+="SU TIENDA ES: $T\n"
                botones "vol"
            ;;
#renovador de id
                    '?? RENOVAR USUARIO ID👥\n\nINGRESE EL USUARIO')
                    echo "${message_text[$id]}" >/tmp/id 
                   ShellBot.sendMessage --chat_id ${var} \
                        --text 'NUEVA FECHA DE EXPIRACION👇' \
                        --reply_markup "$(ShellBot.ForceReply)"             
                    ;;
                'NUEVA FECHA DE EXPIRACION👇')
                    
                    echo "${message_text[$id]}" >>/tmp/id
                   
                    ID=$(sed -n '1 p' /tmp/id | cut -d' ' -f1)
                    DIAS=$(sed -n '2 p' /tmp/id | cut -d' ' -f1)
                   
    if [[ $(cat ${CID}|grep "$ID") = "" ]]; then
   
     local bot_retorno="====ERROR INESPERADO====\n"
     bot_retorno+="$LINE\n"
          bot_retorno+="Este Usuario ID no Existe\n"
          bot_retorno+="$LINE\n"
          tmp=/tmp/id
          rm -rf $tmp
          rm /tmp/acceso
      botones "vol"
      else
      echo "✅=- ACCESO RENOVADO -=✅" >/tmp/acceso
                    echo "ID: $ID" >>/tmp/acceso
    				 echo "📆 $DIAS : DIAS RENOVADOS" >>/tmp/acceso
valid=$(date '+%d-%b-%y' -d " + $DIAS days")
echo "📆 VIGENCIA HASTA: $valid" >>/tmp/acceso
[[ -e ${CID} ]] && {
   newbase=$(cat ${CID}|grep -w -v "$ID")
   echo "$ID|Fecha|$valid" > ${CID}
   for value in `echo ${newbase}`; do
   echo $value >> ${CID}
   done
   } || echo "$ID|Fecha|$valid" >> ${CID}

                
                        bot_retorno="$(</tmp/acceso)"
                    
                    botones "vol"
                        ShellBot.sendMessage --chat_id $ID \
                        --text "$(</tmp/acceso)\nACTUALIZAR VIGENCIA: /MI_ACCESO" \
                        --parse_mode html
                        rm -rf /tmp/id
                        rm -rf /tmp/acceso
                        fi
                    ;;
                    
                    '👥 INFORMACION DEL ID👥\n\nINGRESE EL ID A VERIFICAR')
                    ShellBot.getChatMember  --chat_id "${message_text[$id]}" \
							--user_id "${message_text[$id]}"
	bot_retorno="$LINE\n"
	bot_retorno+="<u>Nombre:</u> ${return[user_first_name]}\n"
	[[ ${return[user_last_name]} ]] && bot_retorno+="<u>Apellido:</u> ${return[user_last_name]}\n"
	[[ ${return[user_username]} ]] && bot_retorno+="<u>Usuario:</u> ${return[user_username]}\n"
	bot_retorno+="<u>ID de usuario:</u> ${return[user_id]}\n"
	bot_retorno+="$LINE"
	botones "vol"
	return 0
;;
		#
'☟INGRESE SU RESELLER ABAJO☟')mensaje;;


	    	'CUANTOS DIAS?')
echo "${message_text[$id]}" >>/tmp/tes.txt

  ID=$(sed -n '1 p' /tmp/tes.txt | cut -d' ' -f1)
               DIAS=$(sed -n '2 p' /tmp/tes.txt | cut -d' ' -f1)
               echo "✅=- ACCESO ACTIVADO 2025 -=✅" >/tmp/acceso
                    echo "ID: $ID" >>/tmp/acceso
    				 echo "📆 $DIAS : DIAS" >>/tmp/acceso
    		       
    datexp=$(date "+%F" -d " + $DIAS days") && valid=$(date '+%C%y-%m-%d' -d " + $DIAS days")
    echo "📆 VIGENCIA HASTA: $datexp" >>/tmp/acceso
      [[ $(cat ${CID}|grep "$ID") = "" ]] && {
      
		echo -e "$ID|Fecha|$datexp" >> ${CID} #|| return 1

        bot_retorno="$(</tmp/acceso)"
        botones "vol"
    # msj_fun
      #upfile_src
      ShellBot.sendMessage --chat_id $ID \
                        --text "$(</tmp/acceso)\n$LINE\n El Administrador te autorizo El acceso\n INGRESAR AL GENERADOR: /MI_ACCESO\n$LINE\n" \
                        --parse_mode html
                        rm -rf /tmp/id
                        rm -rf /tmp/acceso &>/dev/null
                        rm /tmp/tes.txt
                        cp ${CID} $HOME/User-ID

	[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
          ShellBot.sendDocument --chat_id $var  \
                             --document "@$HOME/User-ID" \
                             --caption "$(echo -e "♻️ TOTAL-ID ♻️")"
                             rm $HOME/User-ID
      
							
    } || {
         local bot_retorno="====ERROR INESPERADO====\n"
          bot_retorno+="Este Usuario ID Ya Existe\n"
          bot_retorno+="$LINE\n"
          tmp=/tmp/id
          rm -rf $tmp
          rm /tmp/tes.txt
      botones "vol"
    }
;;
'INGRESE EL SUB-DOMINIO 👇')
	#'INGRESE UN NOMBRE PARA EL (NS)')


                    echo "${message_text[$id]}" >/tmp/ns.$chatuser.txt
                   ShellBot.sendMessage --chat_id ${var} \
                        --text 'INGRESE UN NOMBRE PARA EL (NS)\nEjemplo: ns' \
                        --reply_markup "$(ShellBot.ForceReply)"             
                    ;;
                'INGRESE UN NOMBRE PARA EL (NS)\nEjemplo: ns')
                    
                    echo "${message_text[$id]}" >>/tmp/ns.$chatuser.txt


                   
                    TARGET_IP=$(sed -n '1 p' /tmp/ns.$chatuser.txt | cut -d' ' -f1)
                    nombrens=$(sed -n '2 p' /tmp/ns.$chatuser.txt | cut -d' ' -f1)
					#
                  #  

#DN="${nombrens}.${_domain}"
#my_ip=$(echo ${message_text[$id]} | cut -d "|" -f1)
mkdir -p /etc/bot-alx/tmp

#my_ip=$(cat /etc/bot-alx/tmp/${chatuser}.txt|cut -d'|' -f1)
bot_retorno="\n"
correo='yordniay21@gmail.com'
_dns='2fd3ad3b34e7506cdbd71ff81d42cd73' #zona
apikey='393b24bde02c881b1015c63cb1f0ee8b690c0' #key
API_TOKEN='1g1sMxU0noTcDDtln2tKdo_6imALPAvAmg9KyGFq'
_domain='solutech.dpdns.org'
url='https://api.cloudflare.com/client/v4/zones'


# Configuración


#verificar el nombre si ya existe uno con el mismo nombre
[[ $(cat /etc/bot-alx/dominiosNS.txt|grep "${nombrens}.${_domain}") = "" ]] && {

ls_dom=$(curl -X GET "https://api.cloudflare.com/client/v4/user/tokens/verify" \
     -H "Authorization: Bearer $API_TOKEN" \
     -H "Content-Type: application/json" | jq '.')
  
    num_line=$(echo $ls_dom | jq '.result | length')
    ls_dom=$(echo $ls_dom | jq -r '.result[].name')
    ls_ip=$(echo $ls_dom | jq -r '.result[].content')

echo "$ls_dom" | jq -r ".result[].name"|grep -w "$TARGET_IP" >/tmp/ipd.$chatuser.txt
 # domIP=$(echo "$ls_dom" | jq -r ".result[$i].content")
if [[ $(echo "$ls_ip"|grep -w "$TARGET_IP") = "$TARGET_IP" ]];then
  for (( i = 0; i < $num_line; i++ )); do
   if [[ $(echo "$ls_dom" | jq -r ".result[$i].name"|grep -w "$TARGET_IP") = "$TARGET_IP" ]]; then
    domain=$(echo "$ls_dom" | jq -r ".result[$i].name")
ipdomi=$(echo "$ls_dom" | jq -r ".result[$i].content")
#echo "$ipdomi" >/tmp/ipd.$chatuser.txt
    echo "$ipdomi|$domain|$chatuser" >> /etc/bot-alx/dominios.log
    break
   fi
  done
  bot_retorno+="  ⚠️ ADVERTENCIA DE ERROR ⚠️\n"
  bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
  bot_retorno+=" YA EXISTE UN IP REGISTRADO \n"
  bot_retorno+=" IP REGISTRADA -> <code>$ipdomi</code> 🕸️\n"
  bot_retorno+="      ˅ 🔗 APUNTA A 🔗 ˅ \n"
  bot_retorno+=" Subdominio : 🌎 <code>$domain</code>  \n"
  bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
  msj_fun
  return 0
    fi
    local payload
    payload=$(jq -n \
        --arg type "NS" \
        --arg name "${nombrens}.${_domain}" \
        --arg content "$TARGET_IP" \
        --argjson proxied false \
        --argjson ttl 3600 \
        '{type:$type,name:$name,content:$content,proxied:$proxied,ttl:$ttl}')

    local resp
    resp=$(curl -s -X POST "$url/$_dns/dns_records" \
        -H "Authorization: Bearer $API_TOKEN" \
        -H "Content-Type: application/json" \
        -d "$payload")

#myip=$(wget -qO- $(sed -n '1 p' /tmp/ns | cut -d' ' -f1) | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}') && echo "$myip" > /root/IP
    
# Evaluar respuesta
    if [[ $(echo "$resp" | jq -r '.success // false') == "true" ]]; then
echo "$TARGET_IP|$(echo "$resp" | jq -r '.result.name // empty')|$chatuser" >> /etc/bot-alx/dominiosNS.txt
        bot_retorno+=" ✅ SubDOMINIO NS CREADO ✅\n"
        bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
     #   bot_retorno+="   ❒ IP PRINCIPAL : <code>$(sed -n '1 p' /tmp/ipd.$chatuser.txt | cut -d' ' -f1)</code>\n"
        bot_retorno+="   ❒ DOMAIN Tipo/A : <code>${TARGET_IP}</code>\n"
        bot_retorno+="   ❒ DOMAIN Tipo/NS: <code>$(echo "$resp" | jq -r '.result.name // empty')</code>\n"
        bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
        bot_retorno+=" FECHA : $(date '+%Y-%m-%d') | HORA $(date '+%H:%M:%S')\n"
        bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
    else
        local reason
        reason=$(echo "$resp" | jq -r '.errors[0].message // "Error desconocido"')
        bot_retorno+=" ❌ SubDOMINIO NS RECHAZADO ❌\n"
        bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
        bot_retorno+=" ➤ Motivo: ${reason}\n"
        bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
        bot_retorno+="   ❒ USAR OTRO TIPO DE NOMBRE PUEDA QUE YA EXISTA \n"
        bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
    fi
botones "vol"
} || {
         local bot_retorno="====ERROR INESPERADO====\n"
          bot_retorno+="Sub-DominioNS: ${nombrens}.${_domain}\nEste Dominio-NS Ya Existe En El Registro De Dominios.\nIP: $TARGET_IP\n"
          bot_retorno+="$LINE\n"
          
      botones "vol"
    }

;;
'INGRESE SU IP A REGISTRAR 👇')
	#'INGRESE UN NOMBRE PARA EL (IP)

                    echo "${message_text[$id]}" >/tmp/ip.$chatuser.txt
                   ShellBot.sendMessage --chat_id ${var} \
                        --text 'INGRESE UN NOMBRE \nEjemplo: carlos' \
                        --reply_markup "$(ShellBot.ForceReply)"             
                    ;;
                'INGRESE UN NOMBRE \nEjemplo: carlos')
                    
                    echo "${message_text[$id]}" >>/tmp/ip.$chatuser.txt

ShellBot.sendMessage --chat_id ${var} \
                        --text 'INGRESE EL TIPO DE CONEXION \nEjemplo: D | P\nResultado: Solo DNS | PROXIED' \
                        --reply_markup "$(ShellBot.ForceReply)"             
                    ;;
                'INGRESE EL TIPO DE CONEXION \nEjemplo: D | P\nResultado: Solo DNS | PROXIED')
                    
                    echo "${message_text[$id]}" >>/tmp/ip.$chatuser.txt

                   
                    _ip=$(sed -n '1 p' /tmp/ip.$chatuser.txt | cut -d' ' -f1)
                    nom=$(sed -n '2 p' /tmp/ip.$chatuser.txt | cut -d' ' -f1)
					D=$(sed -n '3 p' /tmp/ip.$chatuser.txt | cut -d' ' -f1)
					#
                  # 
 mkdir -p /etc/bot-alx/tmp
typeD=$(sed -n '3 p' /tmp/ip.$chatuser.txt | cut -d' ' -f1)
[[ -e ${typeD} ]] && typeD='D'
[[ ${typeD} = 'P' ]] && tproxy='true' || tproxy='false'



#my_ip="$(cat /etc/bot-alx/dominios.txt|grep -w "$chatuser"|cut -d'|' -f1)"
bot_retorno="\n"

correo='yordniay21@gmail.com'
_dns='2fd3ad3b34e7506cdbd71ff81d42cd73' #zona
apikey='393b24bde02c881b1015c63cb1f0ee8b690c0' #key
API_TOKEN='1g1sMxU0noTcDDtln2tKdo_6imALPAvAmg9KyGFq'
_domain='solutech.dpdns.org'
url='https://api.cloudflare.com/client/v4/zones'

#verificar el nombre si ya existe uno con el mismo nombre
[[ $(cat /etc/bot-alx/dominios.txt|grep "${nom}.${_domain}") = "" ]] && {

ls_dom=$(curl -X GET "https://api.cloudflare.com/client/v4/user/tokens/verify" \
     -H "Authorization: Bearer $API_TOKEN" \
     -H "Content-Type: application/json" | jq '.')
  
    num_line=$(echo $ls_dom | jq '.result | length')
    ls_dom=$(echo $ls_dom | jq -r '.result[].name')
    ls_ip=$(echo $ls_dom | jq -r '.result[].content')

if [[ $(echo "$ls_ip"|grep -w "$_ip") = "$_ip" ]];then
  for (( i = 0; i < $num_line; i++ )); do
   if [[ $(echo "$ls_dom" | jq -r ".result[$i].content"|grep -w "$_ip") = "$_ip" ]]; then
    domain=$(echo "$ls_dom" | jq -r ".result[$i].name")
domip=$(echo "$ls_dom" | jq -r ".result[$i].content")
    #
echo "$domip" >>/etc/bot-alx/ip.log
    echo "$_ip|$domain|$chatuser" >> /etc/bot-alx/dominios.log
    break
   fi
  done
  bot_retorno+="  ⚠️ ADVERTENCIA DE ERROR ⚠️\n"
  bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
  bot_retorno+=" YA EXISTE UN IP REGISTRADO \n"
  bot_retorno+=" IP REGISTRADA -> <code>$_ip</code> 🕸️\n"
  bot_retorno+="      ˅ 🔗 APUNTA A 🔗 ˅ \n"
  bot_retorno+=" Subdominio : 🌎 <code>$domain</code>  \n"
  bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
botones "vol"
    fi
 # 
var=$(cat <<EOF
{
  "type": "A",
  "name": "$nom",
  "content": "$_ip",
  "ttl": 1,
  "priority": 10,
  "proxied": ${tproxy}
}
EOF
)
    chek_domain=$(curl -s -X POST "$url/$_dns/dns_records" \
    -H "Authorization: Bearer $API_TOKEN" \
    -H "Content-Type: application/json" \
    -d $(echo $var|jq -c '.')|jq '.')

    if [[ "$(echo $chek_domain|jq -r '.success')" = "true" ]]; then
  
echo "$_ip|$(echo $chek_domain|jq -r '.result.name')|${chatuser}" >> /etc/bot-alx/dominios.txt
 
 bot_retorno+=" IP REGISTRADA : $_ip\n"
 bot_retorno+=" ✅ SubDOMINIO A -> @ CREADO ✅\n"
 [[ ${tproxy} = true ]] && bot_retorno+=" SubDomain Proxied Automatico\n" || bot_retorno+=" SubDomain de tipo solo DNS\n"
 bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
 [[ ${tproxy} = true ]] && bot_retorno+="   ❒ Proxied : <code>$(echo $chek_domain|jq -r '.result.name')</code>\n━━━━━━━━━━━━━━━━━━━━━ \nSI QUIERES UN DOMINIO TIPO DNS \nAÑADE LA D DONDE DICE TIPO DE CONEXION \n" || bot_retorno+="   ❒ DNS Only : <code>$(echo $chek_domain|jq -r '.result.name')</code>\n━━━━━━━━━━━━━━━━━━━━━ \nSI QUIERES UN DOMINIO TIPO PROXY \nAÑADE LA P DONDE DICE TIPO DE CONEXION \n"

 #bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
 #bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \nSI QUIERES UN DOMINIO TIPO PROXY \nAÑADE LA P AL FINAL COMO SE MUESTRA EN LA OPCION \n"
 
 #bot_retorno+=" EJEMPLO : <code>${_ip}|${opcion}|${nom}|P</code> \n"
 #bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
 bot_retorno+=" FECHA : $(date '+%Y-%m-%d') | HORA $(printf '%(%H:%M:%S)T')\n"
 bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
 
    else
  bot_retorno+=" ❌ SubDOMINIO A -> @ RECHAZADO ❌\n"
  bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
        bot_retorno+="   ❒ PUEDA QUE EL NOMBRE YA EXISTA: ERROR DESCONOCIDO\n"
  bot_retorno+="━━━━━━━━━━━━━━━━━━━━━ \n"
    fi
botones "vol"
} || {
         local bot_retorno="====ERROR INESPERADO====\n"
          bot_retorno+="Sub-Dominio: ${nom}.${_domain}\nEste Dominio Ya Existe En El Registro De Dominios.\nIP: $_ip\n"
          bot_retorno+="$LINE\n"
          
      botones "vol"
    }

;;
'INGRESE UN SUBDOMINIO A ELIMINAR 👇')
	#

                    echo "${message_text[$id]}" >/tmp/del.$chatuser.txt
# --- CONFIGURACIÓN ---
API_TOKEN='1g1sMxU0noTcDDtln2tKdo_6imALPAvAmg9KyGFq'
_domain='solutech.dpdns.org'
DELI=$(sed -n '1 p' /tmp/del.$chatuser.txt | cut -d' ' -f1)

SUBDOMAIN="${DELI}.${_domi}" # El subdominio que quieres consultar/eliminar

# 1. IDENTIFICAR DOMINIO RAÍZ (Para obtener el Zone ID)
# Extrae 'ejemplo.com' de 'sub.ejemplo.com'
DOMAIN_ROOT=$(echo $SUBDOMAIN | rev | cut -d'.' -f1,2 | rev)

bot_retorno="--- Iniciando proceso para: ${SUBDOMAIN} ---\n"
[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
	      ShellBot.sendMessage --chat_id $var \
							--text "<i>$(echo -e "$bot_retorno")</i>" \
							--parse_mode html 
# 2. OBTENER ZONE_ID
ZONE_ID=$(curl -s -X GET "https://api.cloudflare.com" \
     -H "Authorization: Bearer $API_TOKEN" \
     -H "Content-Type: application/json" | jq -r '.result[0].id')

if [ "$ZONE_ID" == "null" ] || [ -z "$ZONE_ID" ]; then
    bot_retorno+="❌ Error: No se pudo encontrar la zona para ${DOMAIN_ROOT}\n"
    botones "vol"
return 0 
fi

# 3. EXTRAER LA IP ACTUAL (Registro DNS)
# Buscamos el registro y extraemos el campo 'content' (donde reside la IP)
DNS_DATA=$(curl -s -X GET "https://api.cloudflare.com" \
     -H "Authorization: Bearer $API_TOKEN" \
     -H "Content-Type: application/json")

RECORD_ID=$(echo $DNS_DATA | jq -r '.result[0].id')
IP_ACTUAL=$(echo $DNS_DATA | jq -r '.result[0].content')

if [ "$RECORD_ID" == "null" ]; then
    bot_retorno+="❌ Error: El subdominio $SUBDOMAIN no existe en Cloudflare.\n"
    botones "vol"
return 0
fi

bot_retorno+="🔍 Información encontrada:\n"
bot_retorno+="   - Zone ID: $ZONE_ID\n"
bot_retorno+="   - Record ID: $RECORD_ID\n"
bot_retorno+="   - IP Actual: $IP_ACTUAL\n"
bot_retorno+="-------------------------------------------------\n"
[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
	      ShellBot.sendMessage --chat_id $var \
							--text "<i>$(echo -e "$bot_retorno")</i>" \
							--parse_mode html 
# 4. CONFIRMACIÓN PARA ELIMINAR
ShellBot.sendMessage --chat_id ${var} \
                        --text '¿Deseas ELIMINAR este subdominio ahora? (s/n): ' \
                        --reply_markup "$(ShellBot.ForceReply)"             
                    ;;
                '¿Deseas ELIMINAR este subdominio ahora? (s/n): ')
                    
                 #   echo "${message_text[$id]}" >>/tmp/ip.$chatuser.txt
#re=$(echo ${message_text[$id]} | cut -d ' ' -1)


if [[ ${message_text[$id]} == "s" || ${message_text[$id]} == "S" ]]; then
[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
	      ShellBot.sendMessage --chat_id $var \
							--text "<i>$(echo -e "Eliminando registro.")</i>" \
							--parse_mode html 
   # echo "Eliminando registro..."
    DELETE_RES=$(curl -s -X DELETE "https://api.cloudflare.com" \
         -H "Authorization: Bearer $API_TOKEN" \
         -H "Content-Type: application/json")
    
    if [[ $(echo $DELETE_RES | jq -r '.success') == "true" ]]; then
        bot_rerorno+="✅ Éxito: $SUBDOMAIN (IP: $IP_ACTUAL) ha sido eliminado.\n"
		botones "vol"
    else
        bot_retorno+="❌ Error al eliminar el registro.\n"
        bot_retorno+="RESULTADO: $(echo $DELETE_RES | jq .errors)\n"
			botones "vol"
    fi
else
    bot_retorno+="Saliendo sin borrar nada.\n"
		botones "vol"
fi


;;
				esac
		
			elif [[ ${message_document_file_id[$id]} ]]; then
					 download_file

	    	elif [[ ${message_text[$id]} || ${callback_query_data[$id]} ]]; then 	
	msj_del
    verify_access
		 		case ${comando[0]} in
		
					 /[Mm]enu|[Mm]enu|/[Ss]tart|[Ss]tart|[Cc]omensar|/[Cc]omensar)menu_src;;
					# /[Aa]yuda|[Aa]yuda|[Hh]elp|/[Hh]elp)ayuda_src &;;
					 /[Ii]dfo)idinfo;;
					/[Dd]elresell)rm_resell ;;
					/[Aa]dduser)newid;;
					/[Rr]enovar)renewid;;
					/[Uu]rl)url;;
					/ns)agregarNS;;
					/domi)agregarDOMI;;
					/listans)listaNS;;
					/listadomi)listaDOMI;;
					/deldomi)delsub;;
					/sendid) send_admin;;
	    			/saveid)xd "${comando[1]}" ;;
					
					/tienda)tienda;;
					 /[Dd]el)rmid;;
					/[Bb]ackup)backup_ids ;;
					/soporte)soporte;;
					/[Rr]eseller)newres;;
					/autodel)autodelid;;
					/[Ii]NFO|/[Ii]nfo|[Ii]nfo|/[Mm]onitor|/[Mm]onitoriar)info_user "${comando[1]}" ;;
					# 
					  /[Kk]ey89|/[Kk]eygen|/[Gg]erar)keyy ;;
			 		 /[Ii]nfosys)infosys_src ;;
			 	#	 /[Ll]istado|/[Ll]ist)listID_src ;;
			 		 /[Cc]ache)cache_src ;;
					
			 	#	 /*|*)invalido_fun &;;
				esac
			fi
	    fi
		) &
   done
done