# Profile Demo Client
## Installation

### 1. Install flutter 
Steps: https://flutter.io/docs/get-started/install

### 2. Clone this repo

### 3. Build

#### 3.1 Android
##### 3.1.1 Go to applications root directory - `cd <app dir>`
##### 3.1.2 Run `flutter build apk` (`flutter build` defaults to `--release`). 
##### Note: Release APK is created at `<app dir>/build/app/outputs/apk/release/app-release.apk`.
#### 3.2 iOS
##### 3.2.1 Go to applications root directory - `cd <app dir>`
##### 3.2.2 Run `flutter build ios` (`flutter build` defaults to `--release`). Note: that this step requires code signing certificate

### 4. Install on a device
#### 4.1 Android
##### 4.1.1 Connect Android device to a computer with a USB cable.
##### 4.1.2 `cd <app dir>` where `<app dir>` is application directory.
##### 4.1.3 Run `flutter install`
#### 4.2 iOS
##### 4.2.1 Open Xcode and run `.xcworkspace` file in iOS folder