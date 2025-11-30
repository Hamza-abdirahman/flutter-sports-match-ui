# Sports Match UI

A Flutter application for an Sports match registration platform with a modern dark theme, smooth animations, and fully responsive design that adapts seamlessly from small phones to tablets.

## 🎯 Features

- **Match Management**: Browse and register for esports tournaments
- **Game Modes**: Explore different game modes (Sniper, Assault, Championship)
- **Team Selection**: Choose between SOLO, DUO, and SQUAD modes
- **Fully Responsive**: Optimized for all screen sizes with orientation support
- **Smooth Animations**: Fluid transitions and interactive elements
- **Dark Theme**: Modern dark UI with solid black background
- **State Management**: Provider pattern for scalable state management
- **Clean Architecture**: Well-organized folder structure with separation of concerns

## 📁 Project Structure

```
lib/
├── main.dart                    # App entry point
├── constants/                   # App-wide constants
│   ├── app_colors.dart         # Color palette (solid black theme)
│   ├── app_dimensions.dart     # Spacing and sizing constants
│   └── app_strings.dart        # Text constants
├── models/                      # Data models
│   ├── game_mode.dart          # Game mode model
│   └── match.dart              # Match model
├── providers/                   # State management
│   ├── app_state_provider.dart
│   ├── game_mode_provider.dart
│   └── match_provider.dart
├── theme/                       # App theming
│   └── app_theme.dart
├── utils/                       # Utility classes
│   └── responsive_utils.dart   # Responsive design utilities
├── views/                       # Screen/page widgets
│   └── home_screen.dart
└── widgets/                     # Reusable UI components
    ├── custom_app_bar.dart
    ├── custom_bottom_nav_bar.dart
    ├── custom_tab_bar.dart
    ├── esports_tab.dart
    ├── game_mode_card.dart
    ├── match_card.dart
    └── team_mode_selector.dart
```

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK**: Version 3.7.2 or higher
- **Dart SDK**: Version 3.7.2 or higher (comes with Flutter)
- **Git**: For version control
- **Android Studio** (for Android development) or **Xcode** (for iOS development)
- **VS Code** or **Android Studio** (recommended IDEs)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd match_ui
   ```

2. **Check Flutter installation**
   ```bash
   flutter doctor
   ```
   Ensure all checkmarks are green. Fix any issues before proceeding.

3. **Install dependencies**
   ```bash
   flutter pub get
   ```
   This will download all required packages specified in `pubspec.yaml`.

4. **Verify assets**
   Ensure all assets are in place:
   ```
   assets/
   ├── icons/          # Navigation and UI icons
   │   ├── home_icon.png
   │   ├── search_icon.png
   │   ├── leadership_icon.png
   │   ├── group_icon.png
   │   ├── profile2.png
   │   ├── arrow.png
   │   ├── solo.png
   │   ├── duo.png
   │   └── squad.png
   └── images/         # Game mode and match images
       ├── arena.png
       ├── zenith.png
       ├── champion.png
       ├── target.png
       ├── vector (1).png
       ├── gwcs.png
       ├── indigus.png
       └── image35.png
   ```

### Running the App

1. **Connect a device or start an emulator**
   - For Android: Start an Android emulator or connect a physical device via USB
   - For iOS: Start iOS Simulator (Mac only)
   - For Web: No device needed

2. **List available devices**
   ```bash
   flutter devices
   ```

3. **Run the app**
   ```bash
   # Run on default device
   flutter run

   # Run on specific device
   flutter run -d <device-id>

   # Run in release mode for better performance
   flutter run --release
   ```

### Platform-Specific Setup

#### Android
1. Ensure Android Studio is installed
2. Install Android SDK (API level 21 or higher)
3. Create an Android Virtual Device (AVD) or connect a physical device

#### iOS (Mac only)
1. Install Xcode from the App Store
2. Run: `sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer`
3. Run: `sudo xcodebuild -runFirstLaunch`
4. Open iOS Simulator or connect a physical iPhone

#### Web
```bash
flutter run -d chrome
```

### Hot Reload
While the app is running, you can make changes and see them instantly:
- Press `r` in the terminal for hot reload
- Press `R` for hot restart
- Press `q` to quit

## 📦 Dependencies

This project uses the following packages:

### Core Dependencies
- **provider** (^6.0.0): State management solution for reactive app state
- **google_fonts** (^6.2.1): Custom typography (JetBrains Mono, Poppins)

### Development Dependencies
- **flutter_lints** (^5.0.0): Recommended linting rules for Flutter projects
- **cupertino_icons** (^1.0.8): iOS-style icons

All dependencies are automatically installed when you run `flutter pub get`.

## 🎨 Key Technologies

### State Management
- **Provider Pattern**: Centralized state management for:
  - Match data and registration
  - Game mode selection
  - App-wide state

### Responsive Design
- **ResponsiveUtils**: Custom utility class for adaptive sizing
- **Screen Breakpoints**: 
  - Mobile: < 600px
  - Tablet: 600-900px
  - Desktop: > 900px
- **Orientation Support**: Automatic adaptation for landscape/portrait
- **Max Content Width**: 1200px cap for large screens

### Typography
- **JetBrains Mono**: Headers, labels, game mode titles
- **Poppins**: Body text, match details, UI elements

### Color Scheme
- Solid black background (0xFF000000)
- Dark card surfaces (0xFF252525)
- Red accent (0xFFFF4444)
- Professional dark theme throughout

## 🛠️ Troubleshooting

### Common Issues

**1. "flutter: command not found"**
   - Add Flutter to your PATH
   - Run: `export PATH="$PATH:[PATH_TO_FLUTTER_DIRECTORY]/flutter/bin"`

**2. "Gradle build failed" (Android)**
   - Clean build: `flutter clean && flutter pub get`
   - Check Android SDK installation
   - Ensure Java JDK is installed

**3. "CocoaPods not installed" (iOS)**
   - Install CocoaPods: `sudo gem install cocoapods`
   - Run: `cd ios && pod install`

**4. Assets not loading**
   - Verify assets exist in correct folders
   - Check `pubspec.yaml` asset declarations
   - Run: `flutter clean && flutter pub get`

**5. Hot reload not working**
   - Try hot restart (press `R`)
   - If persists, stop and restart the app

### Getting Help
- Check Flutter documentation: https://docs.flutter.dev
- Visit Flutter community: https://flutter.dev/community
- Check issues on GitHub repository

## 📱 Testing on Devices

### Test on Different Screen Sizes
```bash
# Small phone (Pixel 3a)
flutter run -d <device-id>

# Tablet (iPad)
flutter run -d <device-id>

# Web browser
flutter run -d chrome
```

### Test Orientation Changes
- Rotate device/emulator while app is running
- Images and layouts adapt automatically

### Test Performance
```bash
# Profile mode for performance testing
flutter run --profile

# Release mode for production-like performance
flutter run --release
```

## 🏗️ Building for Production

### Android APK
```bash
# Build release APK
flutter build apk --release

# Build app bundle (recommended for Play Store)
flutter build appbundle --release
```
Output: `build/app/outputs/flutter-apk/app-release.apk`

### iOS IPA (Mac only)
```bash
# Build for iOS
flutter build ios --release

# Then archive in Xcode
open ios/Runner.xcworkspace
```

### Web
```bash
# Build web version
flutter build web --release
```
Output: `build/web/`

## 📄 Code Quality & Architecture

### Architecture Highlights
- **Separation of Concerns**: Models, views, providers clearly separated
- **Reusable Widgets**: Modular component design
- **Const Constructors**: Optimized widget rebuilds
- **Clean Code**: Follows Dart style guide

### Design Patterns
- **Provider Pattern**: Reactive state management
- **Widget Composition**: Small, focused widgets
- **Responsive Utils**: Centralized responsive logic

### Code Analysis
```bash
# Run static analysis
flutter analyze

# Check formatting
dart format lib/ --set-exit-if-changed
```

## 📚 Additional Documentation

- **[RESPONSIVE_DESIGN.md](RESPONSIVE_DESIGN.md)**: Detailed responsive design documentation
- **[ARCHITECTURE.md](ARCHITECTURE.md)**: Project architecture overview
- **[BEST_PRACTICES.md](BEST_PRACTICES.md)**: Coding standards and guidelines

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👏 Acknowledgments

- Flutter team for the amazing framework
- Provider package maintainers
- Google Fonts for typography
- Design inspiration from modern esports platforms

---

## 📞 Support

For questions or issues:
1. Check the [troubleshooting section](#-troubleshooting)
2. Review [additional documentation](#-additional-documentation)
3. Open an issue on GitHub
4. Contact the development team

**Happy Coding! 🚀**

## Future Enhancements

- [ ] Real API integration
- [ ] Image loading from network
- [ ] User authentication
- [ ] Push notifications
- [ ] Persistent storage with local database
- [ ] Advanced filtering and search
- [ ] User profiles and statistics
- [ ] Real-time match updates

## Troubleshooting

### Build Issues

1. **Gradle errors on Android**:
   ```bash
   flutter clean
   flutter pub get
   cd android && ./gradlew clean && cd ..
   flutter run
   ```

2. **CocoaPods errors on iOS**:
   ```bash
   flutter clean
   flutter pub get
   cd ios && pod repo update && pod install && cd ..
   flutter run
   ```

3. **Analyzer errors**:
   ```bash
   flutter analyze
   dart fix --apply
   ```

## Contributing

Contributions are welcome! Please follow these guidelines:
1. Fork the repository
2. Create a feature branch
3. Commit changes with clear messages
4. Push to your fork
5. Submit a pull request with description

## License

This project is licensed under the MIT License - see LICENSE file for details.

## Contact

For questions or feedback, please open an issue on GitHub or contact the development team.

## Acknowledgments

- Flutter and Dart communities for excellent documentation
- Design inspiration from modern esports platforms
- Contributors and supporters of this project

## Additonal note 

The Figma design uses Suisse Int’l Mono, which is a paid/commercial font.
Since the font file is not distributed with the assignment, I used JetBrains Mono as a free substitute from Google Fonts.
This maintains the monospaced look while keeping the project legal and functional.


---

**Last Updated**: November 26, 2025
**Flutter Version**: ^3.7.2
**Dart Version**: ^3.7.2

