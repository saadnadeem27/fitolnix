# Fitolnix - Ultimate Fitness App 💪

A comprehensive Flutter fitness application with professional UI, animations, and complete fitness tracking features.

## ✨ Features

### 🎯 **Core Functionality**
- **Splash Screen**: Beautiful animated splash screen with app logo and loading animation
- **Authentication**: Complete onboarding, login, and signup flows
- **Dashboard**: Professional glassmorphism design with quick stats
- **Workout Management**: Comprehensive workout library with timer functionality
- **Progress Tracking**: Interactive charts and achievement system
- **Nutrition Tracking**: Complete food database with macro tracking and meal planning
- **Profile Management**: User settings, goals, and premium features

### 🎨 **Design Features**
- **Glassmorphism**: Modern frosted glass effect cards
- **Gradients**: Beautiful color gradients throughout the app
- **Animations**: Smooth page transitions and staggered animations
- **Dark Theme**: Consistent dark theme with purple/blue accents
- **Professional Typography**: Google Fonts integration

### 🏗️ **Technical Architecture**
- **GetX**: Complete state management, routing, and dependency injection
- **Responsive Design**: Optimized for different screen sizes
- **Local Storage**: Persistent data with GetStorage
- **Charts & Analytics**: Progress visualization with FL Chart
- **Custom Widgets**: Reusable UI components

## 🚀 **Getting Started**

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code
- Android device or emulator

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/saadnadeem27/fitolnix.git
   cd fitolnix
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## 📱 **App Flow**

1. **Splash Screen** → Beautiful animated introduction
2. **Onboarding** → Feature overview and goal selection
3. **Authentication** → Login/signup with validation
4. **Dashboard** → Overview of stats and quick navigation
5. **Workouts** → Browse, start, and track workouts
6. **Progress** → View charts, achievements, and body measurements
7. **Nutrition** → Log meals, track macros, and monitor water intake
8. **Profile** → Manage settings, goals, and premium features

## 🎯 **Key Components**

### Workout System
- Multiple workout categories (Strength, Cardio, HIIT, Flexibility)
- Built-in timer with sound effects
- Exercise instructions and animations
- Progress tracking for each workout

### Nutrition Tracking
- Comprehensive food database (400+ items)
- Macro tracking (Proteins, Carbs, Fats, Calories)
- Water intake monitoring
- Meal categorization and suggestions
- Visual progress indicators

### Progress Analytics
- Weight tracking with goal setting
- Workout streak monitoring
- Achievement system with unlockable badges
- Interactive charts and statistics

## 🛠️ **Dependencies**

```yaml
dependencies:
  flutter:
    sdk: flutter
  get: ^4.6.6
  google_fonts: ^6.1.0
  flutter_staggered_animations: ^1.1.1
  fl_chart: ^0.65.0
  percent_indicator: ^4.2.3
  get_storage: ^2.1.1
  glassmorphism: ^3.0.0
  animated_text_kit: ^4.2.2
  lottie: ^2.7.0
```

## 🎨 **Design System**

### Color Palette
- **Primary**: Purple (#6366F1)
- **Secondary**: Teal (#06D6A0)
- **Accent**: Coral (#FF6B6B)
- **Background**: Dark navy (#0F0F23)
- **Surface**: Elevated dark (#16213E)

### Typography
- **Headers**: Bold, 24-32px
- **Body**: Regular, 14-16px
- **Captions**: Light, 12px
- **Font Family**: Google Fonts (System default)

## 🔧 **Project Structure**

```
lib/
├── app/
│   ├── data/
│   │   └── models/           # Data models
│   ├── modules/
│   │   ├── auth/            # Authentication pages
│   │   ├── home/            # Dashboard
│   │   ├── workout/         # Workout management
│   │   ├── progress/        # Progress tracking
│   │   ├── nutrition/       # Nutrition tracking
│   │   └── profile/         # User profile
│   ├── routes/              # App routing
│   ├── utils/               # Utilities and themes
│   └── widgets/             # Custom widgets
└── main.dart                # App entry point
```

## 🎯 **Features in Detail**

### Authentication System
- Animated onboarding with feature highlights
- Form validation with error handling
- Goal selection (Weight Loss, Muscle Gain, etc.)
- Persistent login sessions

### Dashboard
- Daily stats overview
- Quick navigation cards
- Recent activity summary
- Motivational quotes and tips

### Workout Management
- Categorized workout library
- Detailed exercise instructions
- Built-in timer with rest periods
- Progress tracking and history

### Nutrition Tracking
- Extensive food database
- Barcode scanning (future feature)
- Macro and calorie tracking
- Water intake monitoring
- Meal planning and suggestions

### Progress Analytics
- Weight and body measurement tracking
- Workout performance analytics
- Achievement and badge system
- Goal setting and progress visualization

## 📈 **Performance Features**

- **Fast Loading**: Optimized assets and lazy loading
- **Smooth Animations**: 60fps animations with proper curves
- **Memory Efficient**: Efficient state management with GetX
- **Responsive**: Adaptive design for all screen sizes

## 🔮 **Future Enhancements**

- [ ] Workout video integration
- [ ] Social features and community
- [ ] AI-powered meal recommendations
- [ ] Wearable device integration
- [ ] Offline mode support
- [ ] Multi-language support

## 🐛 **Known Issues**

- Minor overflow warnings in debug mode (non-critical)
- Some animations may need fine-tuning on slower devices

## 🤝 **Contributing**

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 **License**

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👏 **Acknowledgments**

- Flutter team for the amazing framework
- GetX community for state management solutions
- Design inspiration from modern fitness apps
- Contributors and testers

---

**Made with ❤️ using Flutter and GetX**

For support or questions, please open an issue or contact the development team.
