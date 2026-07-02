# FieldTrack

FieldTrack is a high-fidelity Flutter application built with **Clean Architecture** and **GetX**. It is designed for field personnel to manage tasks, track locations with background geofencing, and work seamlessly in offline environments.

---

## 🏗️ Architecture & Package Choices

The project is built using **Clean Architecture** (Data, Domain, Presentation) to ensure high testability, scalability, and maintainability.

*   **State Management & DI**: **GetX** was chosen for its high-performance reactive state management and lightweight dependency injection.
*   **Networking**: **Dio** is used for robust HTTP requests, utilizing Interceptors for global token refreshing and connectivity pre-checks.
*   **Local Storage**: **Hive** is used for the offline sync queue due to its speed and efficiency as a NoSQL database.
*   **Location Services**: **Geolocator** provides reliable background position tracking.
*   **Persistence**: **Flutter Secure Storage** protects sensitive authentication tokens.

---

## 🚀 Getting Started

### Prerequisites
*   Flutter SDK: `>=3.0.0`
*   Dart SDK: `>=3.0.0`

### Installation
1.  **Clone the repository**:
    ```bash
    git clone https://github.com/masud51435/fieldtrack
    cd fieldtrack
    ```
2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```
3.  **Run the app**:
    ```bash
    flutter run
    ```

---

## 📂 Folder Structure Overview

```text
lib/
├── app/                # Routes, Theme, Global Bindings
├── core/               # Network clients, Services, Storage, Failures
└── features/           # Feature modules (Auth, Home, Location, Profile)
    ├── data/           # Models, DataSources, Repositories
    ├── domain/         # Entities, Repository Interfaces, UseCases
    └── presentation/   # Controllers, Views, Widgets
```

---

## 🔄 Offline Sync Approach

1.  **Optimistic Updates**: UI updates immediately when a task is toggled.
2.  **Queue Management**: Offline changes are stored in a Hive box (`pending_sync`).
3.  **Connectivity Monitoring**: `SyncService` monitors network status via `connectivity_plus`.
4.  **Automatic Sync**: Once online, a bulk sync (`POST /todos/sync`) is triggered to update the server.
5.  **Reactive Refresh**: Upon successful sync, the Home screen silently re-fetches data to prevent timestamp conflicts.

---

## 📍 Geofencing & Notifications

*   **Background Tracking**: Tracks position using `Geolocator` with a 10m distance filter to optimize battery.
*   **Initial Check**: The app performs an immediate GPS check on startup/login to detect if the user is already inside a geofence.
*   **Local Notifications**: High-priority alerts via `flutter_local_notifications` trigger upon geofence entry.
*   **Lifecycle Awareness**: Monitoring starts on login/restart and stops on logout to ensure privacy and battery efficiency.

---

## ⚠️ Assumptions & Limitations

1.  **Background Permissions**: For background geofencing to work on Android 11+, the user must manually select "Allow all the time" in location settings.
2.  **GPS Accuracy**: Geofence triggers rely on the device's GPS precision, which may vary indoors.
3.  **Sync Conflicts**: The app uses a "Last-Write-Wins" approach based on UTC ISO8601 timestamps to resolve sync conflicts.
