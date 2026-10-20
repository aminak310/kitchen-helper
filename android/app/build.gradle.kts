import java.io.FileInputStream
import java.util.Properties

plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    FileInputStream(keystorePropertiesFile).use { stream ->
        keystoreProperties.load(stream)
    }
}

android {
    namespace = "com.amina.khelper"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "30.0.14904198"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "com.amina.khelper"
        minSdk = flutter.minSdkVersion
        // Google Play requires targeting at least Android 14 (API 34)
        targetSdk = 34
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            val keyAliasProp = keystoreProperties.getProperty("keyAlias")?.trim()
            val keyPasswordProp = keystoreProperties.getProperty("keyPassword")?.trim()
            val storePasswordProp = keystoreProperties.getProperty("storePassword")?.trim()
            val storeFileProp = keystoreProperties.getProperty("storeFile")?.trim()

            if (!storeFileProp.isNullOrBlank()) {
                val resolvedFile = rootProject.file(storeFileProp)
                storeFile = if (resolvedFile.exists()) resolvedFile else file(storeFileProp)
                keyAlias = keyAliasProp
                keyPassword = keyPasswordProp
                storePassword = storePasswordProp
            }
        }
    }

    buildTypes {
        release {
            val releaseSigning = signingConfigs.getByName("release")
            signingConfig = if (releaseSigning.storeFile != null && releaseSigning.storeFile!!.exists()) {
                releaseSigning
            } else {
                signingConfigs.getByName("debug")
            }
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
