# 🌍 Countries App

A beautiful Flutter application that displays a comprehensive list of countries with detailed information. Built with modern architecture patterns and featuring a stunning UI with light/dark theme support.

## ✨ Features

### 🎨 **User Interface**
- **Minimal & Attractive Design**: Clean, modern UI with eye-catching elements
- **Light/Dark Theme**: Seamless theme switching with a toggle in the header
- **Responsive Layout**: Works perfectly on all screen sizes
- **Smooth Animations**: Elegant transitions and loading states

### 📱 **Core Functionality**
- **Country List**: Browse through all countries with pagination
- **Infinite Scrolling**: Load 10 countries at a time with smooth pagination
- **Pull-to-Refresh**: Reset the list to initial state
- **Search & Filter**: Easy navigation through country data
- **Country Details**: Tap any country to view detailed information

### 🏗️ **Technical Features**
- **BLoC Architecture**: Clean separation of business logic and UI
- **Dependency Injection**: Proper dependency management
- **Error Handling**: Graceful error states and loading indicators
- **State Management**: Efficient state management with BLoC pattern
- **API Integration**: Fetches data from RESTful APIs

## 🏛️ Architecture

This app follows the **Clean Architecture** pattern with **BLoC** for state management:

```
lib/
├── core/                    # Core functionality
│   ├── bloc/               # BLoC implementations
│   ├── constants/          # App constants and colors
│   ├── errors/             # Error handling
│   └── usecase/            # Base use case classes
├── features/               # Feature modules
│   ├── home/              # Home feature
│   │   ├── data/          # Data layer
│   │   ├── domain/        # Domain layer
│   │   └── presentation/  # Presentation layer
│   └── splash/            # Splash screen
└── main.dart              # App entry point
```

### **Architecture Layers**

1. **Presentation Layer**: UI components, BLoC widgets, and screens
2. **Domain Layer**: Business logic, entities, and use cases
3. **Data Layer**: Repository implementations and data sources

## 🚀 Getting Started

### **Prerequisites**
- Flutter SDK (3.0 or higher)
- Dart SDK (2.17 or higher)
- Android Studio / VS Code
- Git

### **Installation**

1. **Clone the repository**
   ```bash
   git clone https://github.com/Sambhav0707/tamasha_live_assignment.git
   cd tamasha_live_assignment
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### **Build for Production**

```bash
# Android APK
flutter build apk --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

## 📱 Screenshots

### **Splash Screen**
- Beautiful app branding with loading indicator
- 3-second delay with smooth transition to home screen

### **Home Screen**
- Country list with pagination (10 items per page)
- Theme toggle switch in header
- Pull-to-refresh functionality
- Infinite scrolling with loading indicators

### **Country Details**
- Comprehensive country information
- Official and common names
- Native names in different languages
- Beautiful card-based layout

## 🛠️ Technologies Used

- **Flutter**: UI framework
- **Dart**: Programming language
- **BLoC**: State management
- **HTTP**: API communication
- **GetIt**: Dependency injection
- **Equatable**: Value equality

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^8.1.3
  http: ^1.1.0
  get_it: ^7.6.4
  equatable: ^2.0.5
```

## 🎯 Key Features Implementation

### **Theme Switching**
- Centralized color management with `AppColors`
- BLoC-based theme state management
- Smooth theme transitions throughout the app

### **Pagination**
- BLoC-managed pagination logic
- Efficient memory usage with lazy loading
- Smooth scrolling experience

### **Error Handling**
- Comprehensive error states
- User-friendly error messages
- Graceful fallbacks

## 🔧 Configuration

### **API Configuration**
The app fetches country data from a RESTful API. Update the API endpoint in:
```
lib/features/home/data/data_sources/remote_data_source.dart
```

### **Theme Configuration**
Customize colors in:
```
lib/core/constants/app_colors.dart
```

## 📊 Performance

- **Optimized Loading**: Efficient pagination reduces initial load time
- **Memory Management**: Proper disposal of controllers and listeners
- **Smooth Animations**: 60fps animations with proper state management
- **Responsive Design**: Adapts to different screen sizes

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Sambhav0707**
- GitHub: [@Sambhav0707](https://github.com/Sambhav0707)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- BLoC library contributors
- The open-source community

---

⭐ **Star this repository if you found it helpful!**
