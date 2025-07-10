// def localProperties = new Properties()
// def localPropertiesFile = rootProject.file('local.properties')
// if (localPropertiesFile.exists()) {
//     localPropertiesFile.withReader('UTF-8') { reader ->
//         localProperties.load(reader)
//     }
// }

// def flutterRoot = localProperties.getProperty('flutter.sdk')
// if (flutterRoot == null) {
//     throw new GradleException("Flutter SDK not found. Define location with flutter.sdk in the local.properties file.")
// }

// def flutterVersionCode = localProperties.getProperty('flutter.versionCode')
// if (flutterVersionCode == null) {
//     flutterVersionCode = '1'
// }

// def flutterVersionName = localProperties.getProperty('flutter.versionName')
// if (flutterVersionName == null) {
//     flutterVersionName = '1.0'
// }

// apply plugin: 'com.android.application'
// apply from: "$flutterRoot/packages/flutter_tools/gradle/flutter.gradle"

// android {
//     compileSdkVersion 31

//     defaultConfig {
//         // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
//         applicationId "com.example.flutter_braintree_example"
//         minSdkVersion 21
//         targetSdkVersion 31
//         versionCode flutterVersionCode.toInteger()
//         versionName flutterVersionName
//     }

//     buildTypes {
//         release {
//             // TODO: Add your own signing config for the release build.
//             // Signing with the debug keys for now, so `flutter run --release` works.
//             signingConfig signingConfigs.debug
//         }
//     }
// }

// flutter {
//     source '../..'
// }

import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    // id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "com.example.flutter_braintree_example"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true
    }

    dependencies {
        coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.flutter_braintree_example"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 21
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

//    signingConfigs {
//         create("release") {
//             keyAlias = keystoreProperties["keyAlias"] as String
//             keyPassword = keystoreProperties["keyPassword"] as String
//             storeFile = keystoreProperties["storeFile"]?.let { file(it) }
//             storePassword = keystoreProperties["storePassword"] as String
//         }
//     }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
            // isMinifyEnabled = true
            // isShrinkResources = true
      
        }
    }
    
}

flutter {
    source = "../.."
}

