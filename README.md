# HealthCheck - Flutter Health Tracking App

A Flutter application for tracking and monitoring vital health metrics including heart rate, blood pressure, and symptoms.

## Features

- ✅ **Track Vital Signs** - Record heart rate, systolic/diastolic blood pressure, and symptoms
- 📊 **Visual Charts** - View health data trends with interactive charts
- 💾 **Local Storage** - All data is stored locally on your device using SharedPreferences
- 🎨 **Clean UI** - Material Design with teal theme
- 📋 **History View** - Access all your past health records
- 📱 **Multi-Screen App** - Splash, Home, Add Vital, History, and Charts screens

## Tech Stack

- **Framework**: Flutter 3.10+
- **Language**: Dart
- **State Management**: Provider (^6.0.5)
- **Local Storage**: SharedPreferences (^2.2.3)
- **Charts**: fl_chart (^0.63.0)
- **Date Formatting**: intl (^0.18.1)
- **UI Icons**: Cupertino Icons (^1.0.8)

## Getting Started

### Prerequisites
- Flutter SDK 3.10 or higher
- Dart 3.0 or higher
- Git

### Installation

1. Clone the repository:
```bash
git clone https://github.com/YOUR_USERNAME/healthcheck.git
cd healthcheck
```

2. Get dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── main.dart                          # App entry point & theme config
├── models/
│   └── health_data.dart              # HealthData model class
├── providers/
│   └── health_data_provider.dart     # State management with ChangeNotifier
├── screens/
│   ├── splash_screen.dart            # App initialization screen
│   ├── home_screen.dart              # Dashboard with latest vitals
│   ├── add_vital_screen.dart         # Form to add new vital signs
│   ├── history_screen.dart           # View past health records
│   └── charts_screen.dart            # Data visualization
├── services/
│   └── storage_service.dart          # Local storage management
└── widgets/
    ├── chart_widget.dart             # Reusable chart component
    ├── custom_card.dart              # Reusable card widget
    └── vital_form_field.dart         # Form input widget
```

## How It Works

1. **Data Model**: `HealthData` stores vital information with timestamp
2. **State Management**: `HealthDataProvider` manages data using Provider pattern
3. **Storage**: `StorageService` handles local persistence with SharedPreferences
4. **UI Screens**: Multiple screens for different functionalities
5. **First Run**: App checks if it's the first run and initializes accordingly

## Color Scheme

- Primary: `#00A99D` (Teal)
- Secondary: `#00695C` (Dark Teal)
- Error: `#E53935` (Red)
- Surface: `#F5F5F5` (Light Gray)

## License

MIT License - feel free to use this project for learning and development purposes.

## Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Provider Package](https://pub.dev/packages/provider)
- [fl_chart Documentation](https://pub.dev/packages/fl_chart)
