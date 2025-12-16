#!/bin/bash

# Script para generar el keystore de release para Android
# Este script crea un keystore JKS para firmar la aplicación en modo release

KEYSTORE_DIR="android/keystore"
KEYSTORE_FILE="$KEYSTORE_DIR/upload-keystore.jks"
KEYSTORE_PROPERTIES="android/key.properties"

# Crear directorio keystore si no existe
mkdir -p "$KEYSTORE_DIR"

# Verificar si el keystore ya existe
if [ -f "$KEYSTORE_FILE" ]; then
    echo "⚠️  El keystore ya existe en $KEYSTORE_FILE"
    echo "¿Deseas sobrescribirlo? (s/n)"
    read -r response
    if [ "$response" != "s" ] && [ "$response" != "S" ]; then
        echo "Operación cancelada."
        exit 0
    fi
fi

# Solicitar información para el keystore
echo "🔐 Generando keystore para firma de release"
echo ""
echo "Por favor, proporciona la siguiente información:"
echo ""

read -p "Alias de la clave (ej: upload): " KEY_ALIAS
read -sp "Contraseña del keystore: " STORE_PASSWORD
echo ""
read -sp "Contraseña de la clave (puede ser la misma): " KEY_PASSWORD
echo ""
read -p "Nombre completo (CN): " CN
read -p "Organización (O): " ORG
read -p "Unidad organizacional (OU): " OU
read -p "Ciudad (L): " CITY
read -p "Estado/Provincia (ST): " STATE
read -p "Código de país (C) [2 letras, ej: US]: " COUNTRY

# Validar que se proporcionaron valores mínimos
if [ -z "$KEY_ALIAS" ] || [ -z "$STORE_PASSWORD" ] || [ -z "$KEY_PASSWORD" ]; then
    echo "❌ Error: Alias y contraseñas son obligatorios"
    exit 1
fi

# Generar el keystore
echo ""
echo "Generando keystore..."

keytool -genkey -v \
    -keystore "$KEYSTORE_FILE" \
    -alias "$KEY_ALIAS" \
    -keyalg RSA \
    -keysize 2048 \
    -validity 10000 \
    -storepass "$STORE_PASSWORD" \
    -keypass "$KEY_PASSWORD" \
    -dname "CN=$CN, OU=$OU, O=$ORG, L=$CITY, ST=$STATE, C=$COUNTRY"

if [ $? -eq 0 ]; then
    echo "✅ Keystore generado exitosamente en $KEYSTORE_FILE"
    
    # Actualizar key.properties
    echo ""
    echo "Actualizando key.properties..."
    
    cat > "$KEYSTORE_PROPERTIES" << EOF
storePassword=$STORE_PASSWORD
keyPassword=$KEY_PASSWORD
keyAlias=$KEY_ALIAS
storeFile=keystore/upload-keystore.jks
EOF
    
    echo "✅ key.properties actualizado"
    echo ""
    echo "⚠️  IMPORTANTE:"
    echo "   - Guarda de forma segura las contraseñas y el keystore"
    echo "   - El archivo key.properties está en .gitignore y no se subirá al repositorio"
    echo "   - Si pierdes el keystore o las contraseñas, no podrás actualizar tu app en Google Play"
    echo ""
    echo "📝 Para construir el APK/AAB firmado, ejecuta:"
    echo "   flutter build apk --release"
    echo "   o"
    echo "   flutter build appbundle --release"
else
    echo "❌ Error al generar el keystore"
    exit 1
fi

