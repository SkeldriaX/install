#!/bin/bash
# 🚀 Script de instalación y despliegue con PM2 para SkeldriaWebsite
# 📬 Soporte: fvxkyqnx@francodev.fun
# 🌐 https://francodev.fun

# Colores para mejorar la salida (si el terminal lo soporta)
GREEN='\033[0;32m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m' # Sin color
SUPMAIL='skeldriax@francodev.fun'

echo -e "${CYAN}🔧 SkeldriaWebsite Installer${NC}"

# Preguntar nombre para el proceso en PM2
read -p "👉 Ingresa el nombre que deseas asignar al servidor en PM2: " APP_NAME
if [[ -z "$APP_NAME" ]]; then
  echo -e "${RED}❌ Error: El nombre del proceso no puede estar vacío.${NC}"
  exit 1
fi

# Clonar repositorio
echo -e "${GREEN}🚀 Clonando repositorio...${NC}"
git clone https://github.com/SkeldriaX/SkeldriaWebsite.git || {
  echo -e "${RED}❌ Error al clonar el repositorio.${NC}"
  exit 1
}

cd SkeldriaWebsite || {
  echo -e "${RED}❌ Error: no se pudo entrar al directorio SkeldriaWebsite.${NC}"
  exit 1
}

# Instalar dependencias
echo -e "${GREEN}📦 Instalando dependencias...${NC}"
npm install || {
  echo -e "${RED}❌ Error al instalar dependencias.${NC}"
  exit 1
}

# Construir proyecto
echo -e "${GREEN}🔨 Construyendo el proyecto...${NC}"
npm run build || {
  echo -e "${RED}❌ Error durante la construcción.${NC}"
  exit 1
}

# Iniciar con PM2
echo -e "${GREEN}🌐 Iniciando servidor con PM2...${NC}"
pm2 start npm --name "$APP_NAME" -- run serve || {
  echo -e "${RED}❌ Error al iniciar el servidor con PM2.${NC}"
  exit 1
}

# Configurar inicio automático
echo -e "${GREEN}💾 Guardando configuración de PM2...${NC}"
pm2 startup -u "$(whoami)" --hp "$HOME"
pm2 save

# Mensaje final
echo -e "${CYAN}✅ El servidor '${APP_NAME}' ya está corriendo en PM2.${NC}"
echo -e "${CYAN}👉 Comandos útiles:${NC}"
echo "   pm2 list              # Ver procesos activos"
echo "   pm2 logs $APP_NAME    # Ver logs del servidor"
echo "   pm2 stop $APP_NAME    # Detener el servidor"
echo "   pm2 restart $APP_NAME # Reiniciar el servidor"

echo -e "\n🔗 ${CYAN}Script por:${NC} https://github.com/FvxkYqnxXD"
echo -e "📬 ${CYAN}Contacto/Soporte:${NC} skeldriax@francodev.fun"
echo -e "💖 ${CYAN}Donaciones:${NC} https://skeldriax.dev/donaciones/"
