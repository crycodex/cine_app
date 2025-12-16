# 🔐 Configuración del Keystore para Release

Este documento explica cómo configurar el keystore para firmar la aplicación en modo release para Android.

## 📋 Requisitos Previos

- Java JDK instalado (para usar `keytool`)
- Flutter SDK configurado

## 🚀 Pasos para Configurar el Keystore

### Opción 1: Usar el Script Automatizado (Recomendado)

1. Ejecuta el script desde la raíz del proyecto:

```bash
./android/generate_keystore.sh
```

2. El script te pedirá:
   - **Alias de la clave**: Un nombre para identificar tu clave (ej: `upload`)
   - **Contraseña del keystore**: Una contraseña segura para proteger el keystore
   - **Contraseña de la clave**: Puede ser la misma que la del keystore
   - **Información del certificado**: Nombre, organización, ciudad, etc.

3. El script generará automáticamente:
   - El archivo keystore en `android/keystore/upload-keystore.jks`
   - Actualizará `android/key.properties` con las credenciales

### Opción 2: Crear el Keystore Manualmente

1. Crea el directorio para el keystore:

```bash
mkdir -p android/keystore
```

2. Genera el keystore usando `keytool`:

```bash
keytool -genkey -v \
  -keystore android/keystore/upload-keystore.jks \
  -alias upload \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000
```

3. Completa la información solicitada cuando se te pida.

4. Actualiza el archivo `android/key.properties` con tus credenciales:

```properties
storePassword=tu_contraseña_del_keystore
keyPassword=tu_contraseña_de_la_clave
keyAlias=upload
storeFile=keystore/upload-keystore.jks
```

## ✅ Verificar la Configuración

Una vez configurado, puedes verificar que todo esté correcto ejecutando:

```bash
flutter build appbundle --release
```

O para generar un APK:

```bash
flutter build apk --release
```

El build debería completarse sin errores y el APK/AAB estará firmado con tu keystore de release.

## ⚠️ Importante

- **NUNCA** subas el keystore o `key.properties` al repositorio
- Guarda una copia de seguridad del keystore en un lugar seguro
- Si pierdes el keystore o las contraseñas, **NO podrás actualizar tu aplicación en Google Play Store**
- El archivo `key.properties` ya está en `.gitignore` y no se subirá al repositorio

## 🔒 Seguridad

- Usa contraseñas fuertes y únicas
- Almacena el keystore en un lugar seguro (nube cifrada, disco externo, etc.)
- Considera usar un gestor de contraseñas para almacenar las credenciales

## 📝 Notas Adicionales

- El keystore tiene una validez de 10000 días (aproximadamente 27 años)
- Puedes usar el mismo keystore para múltiples aplicaciones
- Si necesitas cambiar el keystore, deberás crear una nueva aplicación en Google Play

