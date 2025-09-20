# 🏋️ Fitolnix - Modern Fitness & Wellness App

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Supabase](https://img.shields.io/badge/Supabase-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white)
![GetX](https://img.shields.io/badge/GetX-9C27B0?style=for-the-badge)

*A comprehensive fitness application with professional UI, advanced animations, and complete wellness tracking features*

[Live Demo](#) • [Documentation](#features) • [Report Bug](https://github.com/saadnadeem27/fitolnix/issues) • [Request Feature](https://github.com/saadnadeem27/fitolnix/issues)

</div>

---

## 📱 Overview

**Fitolnix** is a modern, feature-rich fitness application built with Flutter and powered by Supabase. It combines beautiful UI design with comprehensive functionality to help users achieve their health and fitness goals through workout tracking, nutrition monitoring, and progress analytics.

### 🎯 Key Highlights

- **Professional Design**: Glassmorphism UI with smooth animations
- **Complete Fitness Suite**: Workout management, nutrition tracking, progress analytics
- **Modern Architecture**: Clean code with GetX state management
- **Backend Integration**: Supabase for real-time data and authentication
- **Cross-Platform**: iOS, Android, and Web support

---

## ✨ Features

### � Authentication & Onboarding
- **Splash Screen**: Animated logo with gradient backgrounds
- **Onboarding Flow**: Interactive welcome screens with goal selection
- **User Authentication**: Secure login/signup with Supabase Auth
- **Profile Setup**: Comprehensive user profile with fitness goals

### 🏠 Dashboard & Home
- **Glassmorphism Cards**: Modern frosted glass effect design
- **Daily Overview**: Calories, workouts, and progress summaries
- **Quick Actions**: Fast access to key features
- **Motivational Content**: Daily quotes and fitness tips
- **Progress Widgets**: Visual progress indicators and charts

### �💪 Workout Management
- **Workout Library**: 50+ categorized workouts (Strength, Cardio, HIIT, Yoga)
- **Exercise Details**: Instructions, sets, reps, and duration
- **Built-in Timer**: Professional timer with exercise transitions
- **Progress Tracking**: Workout history and performance analytics
- **Favorites System**: Save and organize preferred workouts
- **Difficulty Levels**: Beginner, Intermediate, Advanced classifications

### 🍎 Nutrition Tracking
- **Food Database**: 400+ food items with complete nutritional data
- **Macro Tracking**: Proteins, carbohydrates, fats, and calories
- **Water Intake**: Daily hydration monitoring with goals
- **Meal Planning**: Breakfast, lunch, dinner, and snack categorization
- **Progress Visualization**: Charts and indicators for nutritional goals
- **Smart Suggestions**: Meal recommendations based on preferences

### 📊 Progress Analytics
- **Weight Tracking**: Goal setting with visual progress charts
- **Workout Statistics**: Performance metrics and improvement tracking
- **Achievement System**: Unlockable badges and milestones
- **Streak Monitoring**: Consistency tracking for motivation
- **Data Visualization**: Interactive charts with FL Chart integration

### 👤 Profile & Settings
- **User Management**: Complete profile customization
- **Goal Setting**: Fitness objectives and target tracking
- **Preferences**: Theme, notifications, and app settings
- **Premium Features**: Advanced analytics and exclusive content
- **Data Export**: Progress reports and statistics

---

## 🛠️ Tech Stack

### Frontend
- **Flutter 3.6+**: Cross-platform mobile framework
- **Dart**: Programming language
- **GetX 4.6.6**: State management, routing, and dependency injection

### Backend & Database
- **Supabase**: Backend-as-a-Service
  - PostgreSQL database
  - Real-time subscriptions
  - Authentication
  - Row-level security

### UI & Design
- **Google Fonts**: Professional typography
- **Custom Animations**: Smooth transitions and effects
- **Glassmorphism**: Modern frosted glass design
- **FL Chart**: Interactive data visualization
- **Lottie**: Vector animations

### Key Dependencies
```yaml
dependencies:
  get: ^4.6.6                          # State management
  supabase_flutter: ^2.5.6            # Backend integration
  fl_chart: ^0.68.0                   # Charts and graphs
  flutter_staggered_animations: ^1.1.1 # Smooth animations
  percent_indicator: ^4.2.3            # Progress indicators
  glassmorphism: ^3.0.0               # Glass effect UI
  google_fonts: ^6.2.1                # Typography
  get_storage: ^2.1.1                 # Local storage
```

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.6.0)
- Dart SDK
- Android Studio / VS Code
- Supabase account

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/saadnadeem27/fitolnix.git
   cd fitolnix
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Setup Supabase**
   - Create a new project at [supabase.com](https://supabase.com)
   - Copy your project URL and anon key
   - Update the environment variables:
   ```env
   SUPABASE_URL=your_supabase_project_url
   SUPABASE_ANON_KEY=your_supabase_anon_key
   ```

4. **Database Setup**
   ```sql
   -- Create tables (see database_schema.sql for complete setup)
   CREATE TABLE users (
     id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
     email TEXT UNIQUE NOT NULL,
     name TEXT NOT NULL,
     created_at TIMESTAMP DEFAULT NOW()
   );
   
   CREATE TABLE workouts (
     id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
     title TEXT NOT NULL,
     category TEXT NOT NULL,
     difficulty TEXT NOT NULL,
     duration INTEGER NOT NULL
   );
   ```

5. **Run the application**
   ```bash
   flutter run
   ```

### Environment Configuration

Create a `.env` file in the root directory:
```env
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_ANON_KEY=your-anon-key-here
```

---

## 📱 App Architecture

### Project Structure
```
lib/
├── app/
│   ├── data/
│   │   ├── models/              # Data models (User, Workout, Nutrition)
│   │   └── services/            # API and storage services
│   ├── modules/
│   │   ├── auth/               # Authentication (login, signup, onboarding)
│   │   ├── home/               # Dashboard and main navigation
│   │   ├── workout/            # Workout management and tracking
│   │   ├── nutrition/          # Nutrition tracking and meal planning
│   │   ├── progress/           # Analytics and progress tracking
│   │   └── profile/            # User profile and settings
│   ├── utils/
│   │   ├── theme.dart          # App theming and colors
│   │   ├── constants.dart      # App constants
│   │   └── string_extensions.dart # Utility extensions
│   └── widgets/
│       └── custom_widgets.dart # Reusable UI components
└── main.dart                   # Application entry point
```

### State Management Pattern
- **GetX Controllers**: Reactive state management
- **Dependency Injection**: Lazy loading with Get.put()
- **Route Management**: Declarative navigation
- **Storage**: Local persistence with GetStorage

### Design Patterns
- **MVC Architecture**: Model-View-Controller separation
- **Repository Pattern**: Data access abstraction
- **Singleton Pattern**: Service instances
- **Observer Pattern**: Reactive programming with GetX

---

## 🎨 Design System

### Color Palette
```dart
// Primary Colors
primary: Color(0xFF6366F1)      // Indigo
secondary: Color(0xFF06D6A0)    // Mint Green
accent: Color(0xFFFF6B6B)       // Coral Red

// Background
background: Color(0xFF0F0F23)   // Dark Navy
surface: Color(0xFF16213E)      // Dark Blue

// Text
textPrimary: Color(0xFFFFFFFF)  // White
textSecondary: Color(0xFFB0B3B8) // Light Gray
```

### Typography
- **Font Family**: Inter (Google Fonts)
- **Heading Sizes**: 32px, 28px, 24px
- **Body Sizes**: 16px, 14px, 12px
- **Font Weights**: 400, 500, 600, 700, 800

### UI Components
- **Glass Cards**: Frosted glass effect with blur
- **Gradient Buttons**: Multi-color gradient backgrounds
- **Progress Indicators**: Circular and linear progress bars
- **Custom Icons**: Fitness-themed iconography

---

## 📊 Database Schema

### Users Table
```sql
CREATE TABLE users (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  email TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL,
  age INTEGER,
  height DECIMAL,
  weight DECIMAL,
  gender TEXT,
  fitness_goal TEXT,
  profile_image TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);
```

### Workouts Table
```sql
CREATE TABLE workouts (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  category TEXT NOT NULL,
  difficulty TEXT NOT NULL,
  duration INTEGER NOT NULL,
  calories_burned INTEGER,
  image_url TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);
```

### User Progress Table
```sql
CREATE TABLE user_progress (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  user_id UUID REFERENCES users(id),
  workout_id UUID REFERENCES workouts(id),
  completed_at TIMESTAMP DEFAULT NOW(),
  duration INTEGER,
  calories_burned INTEGER
);
```

---

## 🔧 Development

### Code Quality
- **Linting**: Flutter recommended lints
- **Formatting**: Dart formatter integration
- **Documentation**: Comprehensive code comments
- **Testing**: Unit and widget tests

### Performance Optimizations
- **Lazy Loading**: Controllers loaded on demand
- **Image Caching**: Efficient image management
- **Memory Management**: Proper disposal of resources
- **Animation Optimization**: 60fps smooth animations

### Build Configuration
```bash
# Development build
flutter run --debug

# Release build
flutter build apk --release
flutter build ios --release

# Web build
flutter build web --release
```

---

## 🌟 Features Showcase

### Glassmorphism Design
- Frosted glass effect cards
- Subtle shadows and borders
- Gradient backgrounds
- Modern aesthetic appeal

### Smooth Animations
- Staggered list animations
- Page transitions
- Loading animations
- Micro-interactions

### Comprehensive Data
- 50+ workout routines
- 400+ food database items
- Progress tracking metrics
- Achievement system

---

## 🚀 Deployment

### Mobile App Stores
```bash
# Android Play Store
flutter build appbundle --release

# iOS App Store
flutter build ios --release
```

### Web Deployment
```bash
# Build for web
flutter build web --release

# Deploy to Firebase Hosting
firebase deploy --only hosting
```

---

## 🤝 Contributing

We welcome contributions! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Guidelines
- Follow Flutter/Dart style guide
- Write meaningful commit messages
- Add tests for new features
- Update documentation as needed

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🏆 Achievements

- ✅ Modern UI/UX Design
- ✅ Complete Fitness Suite
- ✅ Real-time Backend Integration
- ✅ Cross-platform Compatibility
- ✅ Professional Code Quality
- ✅ Comprehensive Documentation

---

## 📞 Contact & Support

- **Developer**: [Saad Nadeem](https://github.com/saadnadeem27)
- **Email**: [Contact Email]
- **LinkedIn**: [LinkedIn Profile]
- **Portfolio**: [Portfolio Website]

### Support
- 📖 [Documentation](README.md)
- 🐛 [Report Issues](https://github.com/saadnadeem27/fitolnix/issues)
- 💡 [Feature Requests](https://github.com/saadnadeem27/fitolnix/issues)
- 💬 [Discussions](https://github.com/saadnadeem27/fitolnix/discussions)

---

<div align="center">

**Made with ❤️ using Flutter & Supabase**

*Star ⭐ this repository if you found it helpful!*

</div>

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
