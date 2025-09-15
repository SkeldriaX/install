#!/bin/bash

echo "======================================"
echo "🔧 Configuración de SkeldriaSecurity Bot"
echo "======================================"
echo ""

# Verificar Node.js
if ! command -v node &> /dev/null; then
    echo "❌ Node.js no está instalado. Por favor instálalo antes de continuar."
    echo "🔗 https://nodejs.org/"
    exit 1
fi

# Verificar npm
if ! command -v npm &> /dev/null; then
    echo "❌ npm no está instalado. Por favor instala npm para continuar."
    echo "🔗 https://docs.npmjs.com/downloading-and-installing-node-js-and-npm"
    exit 1
fi

echo "1) Configurar Ahora (Automático)"
echo "2) Configurar Más Tarde (Manual)"
echo ""
read -p "Selecciona una opción [1-2]: " opcion

if [ "$opcion" == "2" ]; then
    echo "📝 Instalación manual seleccionada. Puedes configurar el bot más tarde."
    echo "Clonando repositorio..."
    git clone https://github.com/SkeldriaX/SkeldriaSecurity.git
    cd SkeldriaSecurity || exit
    echo "Listo. Revisa el archivo config.json para editarlo manualmente."
    exit 0
fi

echo "🚀 Instalación automática iniciada..."
git clone https://github.com/SkeldriaX/SkeldriaSecurity.git
cd SkeldriaSecurity || exit

echo "📦 Instalando dependencias..."
npm install || { echo "❌ Error al instalar dependencias. Revisa tu entorno."; exit 1; }

echo ""
echo "🔐 Introduce los datos de configuración uno por uno:"

read -p "🔑 TOKEN DEL BOT: " token
read -p "🆔 ID DEL CLIENTE (clientID): " clientID
read -p "📌 Prefijo de comandos (ej: s!): " prefix
read -p "🔊 Canal de voz (voiceCN): " voiceCN
read -p "🧩 Clave FvxkYqnxXD (opcional): " fvx
read -p "👤 Nombre del segundo owner (owner2name): " owner2
read -p "📋 ID del canal de logs (GuildLogs): " logs

echo "🛠️ Generando archivo config.json..."

cat > config.json <<EOF
{
  "token": "$token",
  "clientID": "$clientID",
  "prefix": "$prefix",
  "voiceCN": "$voiceCN",
  "FvxkYqnxXD": "$fvx",
  "owner2name": "$owner2",
  "GuildLogs": "$logs",
  "messages": {
    "COOLDOWN_MESSAGE": "Estas en cooldown por: \`<duration>\`!"
  }
}
EOF

echo ""
echo "✅ Configuración completada con éxito."
echo "▶️ Puedes iniciar el bot con: node index.js/ node ."
