import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

val localProperties = Properties()
val localPropertiesFile = rootProject.file("local.properties")
if (localPropertiesFile.exists()) {
    localProperties.load(FileInputStream(localPropertiesFile))
}

val flutterVersionCode = localProperties.getProperty("flutter.versionCode")?.toIntOrNull() ?: 1
val flutterVersionName = localProperties.getProperty("flutter.versionName") ?: "1.0"

android {
    namespace = "com.smartmoney"
    compileSdk = 35
    
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }
    
    kotlinOptions {
        jvmTarget = "1.8"
    }
    
    sourceSets {
        getByName("main") {
            java.srcDirs("src/main/kotlin")
        }
    }
    
    defaultConfig {
        applicationId = "com.smartmoney"
        minSdk = flutter.minSdkVersion
        targetSdk = 35
        versionCode = flutterVersionCode
        versionName = flutterVersionName
        multiDexEnabled = true
    }
    
    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation(platform("com.google.firebase:firebase-bom:32.7.0"))
    implementation("com.google.firebase:firebase-analytics")
    implementation("androidx.multidex:multidex:2.0.1")
}

apply(plugin = "com.google.gms.google-services")

// Copiar APK após o build (no final do arquivo)
afterEvaluate {
    tasks.named("assembleDebug").configure {
        doLast {
            val apkSource = File(buildDir, "outputs/flutter-apk/app-debug.apk")
            val apkDest = File(projectDir.parentFile.parentFile, "build/app/outputs/flutter-apk/app-debug.apk")
            
            if (apkSource.exists()) {
                apkDest.parentFile.mkdirs()
                apkSource.copyTo(apkDest, overwrite = true)
                println("✅ APK copiado para: ${apkDest.absolutePath}")
            }
        }
    }
}
