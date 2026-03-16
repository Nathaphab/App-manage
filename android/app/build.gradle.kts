android {
    namespace = "com.nathaphab.clubapp" 
    
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    // 👇 แก้ไขตรงส่วนนี้ครับ เพิ่มรายการ excludes ให้ครบถ้วน 👇
    packaging {
        resources {
            excludes += listOf(
                "META-INF/DEPENDENCIES",
                "META-INF/NOTICE",
                "META-INF/LICENSE",
                "META-INF/LICENSE.txt",
                "META-INF/notice.txt",
                "META-INF/NOTICE.txt",
                "META-INF/license.txt",
                "META-INF/ASL2.0",
                "META-INF/LGPL2.1",
                "META-INF/AL2.0",
                "META-INF/*.kotlin_module"
            )
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.nathaphab.clubapp" 
        
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // ใช้การตั้งค่า debug เพื่อให้ build ผ่านได้โดยไม่ต้องสร้าง keystore จริง
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}