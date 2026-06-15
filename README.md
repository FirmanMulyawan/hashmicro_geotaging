# HashMicro Attendance App

A Flutter-based mobile attendance application developed as part of the Flutter Developer Technical Test for HashMicro.

## Overview

This application allows users to:

- Login using a dummy authentication API.
- Create and manage outlet locations (Master Data).
- Capture outlet coordinates using GPS.
- Perform attendance (Clock In / Clock Out).
- Validate attendance location within a maximum radius of 50 meters from the registered outlet location.
- Store attendance data locally using ObjectBox.

---

## Features

### Authentication

Authentication is implemented using DummyJSON Authentication API:

API Documentation:
https://dummyjson.com/docs/auth

Login Endpoint:

```http
POST https://dummyjson.com/auth/login
```

Example Credentials:

```json
{
  "username": "emilys",
  "password": "emilyspass"
}
```

Authentication flow:

- User logs in using username and password.
- Access token is returned by the API.
- User information is stored locally using Flutter Secure Storage.

---

### Master Data Outlet

Users can:

- Add a new outlet.
- Capture current GPS coordinates.
- Automatically generate address from latitude and longitude using Geocoding.
- Save outlet information locally using ObjectBox.

Stored outlet data:

- Outlet Name
- Latitude
- Longitude
- Address
- Attendance Photo
- Clock In Time
- Clock Out Time

---

### Attendance

Users can perform attendance at registered outlets.

Attendance process:

1. Select outlet.
2. Application retrieves current GPS position.
3. System calculates distance between user location and outlet location.
4. If distance ≤ 50 meters:
   - User can take a selfie/photo.
   - Clock In is recorded.
5. If distance > 50 meters:
   - Attendance is rejected.

Distance validation uses:

```dart
Geolocator.distanceBetween(
  latitudeUser,
  longitudeUser,
  latitudeOutlet,
  longitudeOutlet,
);
```

---

### Clock In

Captured data:

- Attendance photo
- User latitude
- User longitude
- Timestamp

---

### Clock Out

Captured data:

- Clock Out timestamp

---

## Technology Stack

| Technology | Description |
|------------|-------------|
| Flutter | Mobile Framework |
| GetX | State Management & Navigation |
| Dio | HTTP Client |
| ObjectBox | Local Database |
| Geolocator | GPS Tracking |
| Geocoding | Convert Coordinates to Address |
| Google Maps Flutter | Map Display |
| Image Picker | Camera Integration |
| Flutter Secure Storage | Secure Token Storage |
| ScreenUtil | Responsive UI |

---

## Local Database

ObjectBox is used for local storage.

Entity Example:

```dart
@Entity()
class LocalOutlet {
  @Id()
  int? id;

  int? userId;
  String? nameOutlet;
  String? latitude;
  String? longitude;
  String? address;

  String? imageUrl;

  String? clockIn;
  String? clockOut;

  String? userLatitude;
  String? userLongitude;
}
```

---

## GPS Validation

Maximum attendance radius:

```text
50 meters
```

Validation:

```dart
bool isWithinRadius({
  required double latitudeUser,
  required double longitudeUser,
  required double latitudeOutlet,
  required double longitudeOutlet,
  double radiusMeter = 50,
}) {
  final distance = Geolocator.distanceBetween(
    latitudeUser,
    longitudeUser,
    latitudeOutlet,
    longitudeOutlet,
  );

  return distance <= radiusMeter;
}
```

---

## Dependencies Used

### Main Dependencies

- get
- dio
- objectbox
- geolocator
- geocoding
- google_maps_flutter
- image_picker
- flutter_secure_storage
- flutter_screenutil
- intl
- gap
- skeletonizer

### Local Storage

- objectbox
- shared_preferences
- flutter_secure_storage

### Maps & Location

- geolocator
- geocoding
- google_maps_flutter

### Media

- image_picker
- photo_view

---

## Build Information

```yaml
name: hashmicro
version: 1.0.0+118
```

Flutter SDK:

```yaml
>=3.2.6 <4.0.0
```

---

## How to Run

### 1. Clone Repository

```bash
git clone <repository-url>
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Generate ObjectBox

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 4. Run Application

```bash
flutter run
```

### 5. Build APK

```bash
flutter build apk --release
```

Generated APK:

```text
build/app/outputs/flutter-apk/app-release.apk
```

---

## Permissions

### Android

Required permissions:

```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
<uses-permission android:name="android.permission.CAMERA"/>
```

---

## Assumptions

- Attendance data is stored locally using ObjectBox.
- Authentication uses DummyJSON API.
- GPS accuracy depends on the device.
- Attendance is only accepted within a radius of 50 meters.
- Internet connection is required only during login.

---

## Technical Test Requirements Coverage

| Requirement | Status |
|------------|--------|
| Login | ✅ |
| Authentication API | ✅ |
| Add Outlet | ✅ |
| GPS Geotagging | ✅ |
| Reverse Geocoding | ✅ |
| Local Database | ✅ |
| Clock In | ✅ |
| Clock Out | ✅ |
| Attendance Photo | ✅ |
| Radius Validation (50m) | ✅ |
| Attendance Rejection | ✅ |

---

## Developer

Firman Mulyawan

Flutter Developer Technical Test Submission for HashMicro.