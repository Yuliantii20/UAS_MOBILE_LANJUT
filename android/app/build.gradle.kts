android {
    namespace = "com.example.uas_mobile_lanjut"

    compileSdk = 35

    ndkVersion = flutter.ndkVersion

    defaultConfig {
        applicationId = "com.example.uas_mobile_lanjut"

        minSdk = flutter.minSdkVersion
        targetSdk = 35

        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}