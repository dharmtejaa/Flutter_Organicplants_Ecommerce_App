plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android") // Modern Kotlin plugin
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services") // Firebase
}

android {
    namespace = "com.example.organicplants"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    defaultConfig {
        applicationId = "com.example.organicplants"
        minSdk = 23
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    buildTypes {
        release {
            // Replace with your real keystore in production
            signingConfig = signingConfigs.getByName("debug")
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }
}

dependencies {
    implementation("com.google.firebase:firebase-analytics-ktx")
    // Add other Firebase or Kotlin libraries as needed
}

flutter {
    source = "../.."
}
