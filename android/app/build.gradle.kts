plugins {
    id("com.android.application")
    id("kotlin-android")
    // Flutter Gradle plugin
    id("dev.flutter.flutter-gradle-plugin")

    // Add Google services plugin for Firebase
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.iet_event_tracker"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.iet_event_tracker"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

// ⛔ DO NOT put plugins {} or dependencies {} inside android {}

dependencies {
    // For most Flutter + Firebase setups, you **don’t need** to manually add Firebase dependencies here –
    // FlutterFire plugins add them automatically.
    //
    // If you really want analytics, you *can* add:
    //
    // implementation(platform("com.google.firebase:firebase-bom:34.6.0"))
    // implementation("com.google.firebase:firebase-analytics")
}

flutter {
    source = "../.."
}
