# 🏋️ Fitolnix - Modern Fitness & Wellness App

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Supabase](https://img.shields.io/badge/Supabase-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white)
![GetX](https://img.shields.io/badge/GetX-9C27B0?style=for-the-badge)

*A comprehensive fitness application with professional UI, advanced animations, and complete wellness tracking features*

[Live Demo](#) • [Documentation](#features) • [Report Bug](https://github.com/saadnadeem27/fitolnix/issues)

</div>

---

## 📱 Overview

**Fitolnix** is a modern, feature-rich fitness application built with Flutter and powered by Supabase. It combines beautiful glassmorphism UI design with comprehensive functionality to help users achieve their health and fitness goals through workout tracking, nutrition monitoring, and progress analytics.

**Key Highlights**: Professional Design • Complete Fitness Suite • Modern Architecture • Backend Integration • Cross-Platform

---

## ✨ Features

### 🔐 Authentication & Onboarding
- Animated splash screen with gradient backgrounds
- Interactive onboarding flow with goal selection
- Secure authentication with Supabase Auth
- Comprehensive profile setup

### 🏠 Dashboard
- Glassmorphism cards with frosted glass effects
- Daily calories, workouts, and progress overview
- Quick action buttons for key features
- Motivational content and fitness tips

### 💪 Workout Management
- 50+ categorized workouts (Strength, Cardio, HIIT, Yoga, Mobility)
- Detailed exercise instructions with sets, reps, and duration
- Built-in timer with exercise transitions and rest periods
- Favorites system and difficulty levels (Beginner, Intermediate, Advanced)
- Progress tracking and workout history

### 🍎 Nutrition Tracking
- 400+ food database with complete nutritional data
- Macro tracking (Proteins, Carbs, Fats, Calories)
- Water intake monitoring with daily goals
- Meal categorization (Breakfast, Lunch, Dinner, Snacks)
- Smart meal suggestions and planning

### 📊 Progress Analytics
- Weight and body measurement tracking
- Interactive charts with FL Chart integration
- Achievement system with unlockable badges
- Workout streak monitoring and performance metrics
- Goal setting and progress visualization

### 👤 Profile & Settings
- Complete user profile management
- Fitness goal configuration and target setting
- App preferences (theme, notifications, units)
- Premium features and subscription management

---

## 🛠️ Tech Stack

**Frontend**: Flutter 3.6+ • Dart • GetX (State Management)  
**Backend**: Supabase (PostgreSQL, Auth, Real-time)  
**UI/Design**: Google Fonts • Glassmorphism • FL Chart • Lottie Animations  
**Storage**: GetStorage (Local) • Supabase (Cloud)

### Key Dependencies
```yaml
get: ^4.6.6                          # State management & routing
supabase_flutter: ^2.5.6            # Backend integration
fl_chart: ^0.68.0                   # Interactive charts
flutter_staggered_animations: ^1.1.1 # Smooth animations
glassmorphism: ^3.0.0               # Modern UI effects
google_fonts: ^6.2.1                # Professional typography
```

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.6.0)
- Supabase account
- Android Studio / VS Code

### Installation

1. **Clone & Setup**
   ```bash
   git clone https://github.com/saadnadeem27/fitolnix.git
   cd fitolnix
   flutter pub get
   ```

2. **Supabase Configuration**
   - Create project at [supabase.com](https://supabase.com)
   - Update `.env` file:
   ```env
   SUPABASE_URL=your_supabase_project_url
   SUPABASE_ANON_KEY=your_supabase_anon_key
   ```

3. **Database Setup**
   ```bash
   # Run the provided schema
   psql -h your-host -d your-db -f database_schema.sql
   ```

4. **Run Application**
   ```bash
   flutter run
   ```

---

## 📁 Project Architecture

```
lib/
├── app/
│   ├── data/
│   │   ├── models/              # User, Workout, Nutrition models
│   │   └── services/            # Supabase config & storage
│   ├── modules/
│   │   ├── auth/               # Authentication & onboarding
│   │   ├── home/               # Dashboard & navigation
│   │   ├── workout/            # Workout management & timer
│   │   ├── nutrition/          # Food tracking & meal planning
│   │   ├── progress/           # Analytics & achievements
│   │   └── profile/            # Settings & user management
│   ├── utils/                  # Theme, constants, extensions
│   └── widgets/                # Reusable UI components
└── main.dart                   # App entry point
```

**Architecture Pattern**: MVC with GetX • Repository Pattern • Dependency Injection

---

## 🎨 Design System

### Color Palette
```dart
Primary: #6366F1 (Indigo)    Secondary: #06D6A0 (Mint)
Accent: #FF6B6B (Coral)      Background: #0F0F23 (Dark Navy)
Surface: #16213E (Dark Blue) Text: #FFFFFF (White)
```

### Design Features
- **Glassmorphism**: Frosted glass cards with subtle blur effects
- **Gradients**: Multi-color backgrounds and button styling
- **Typography**: Inter font family with optimized weights
- **Animations**: Staggered lists, smooth transitions, micro-interactions

---

## 🗄️ Database Schema

### Core Tables
- **users**: Profile, goals, preferences
- **workouts**: Exercise library with categories
- **user_workouts**: Completed sessions & progress
- **nutrition**: Food database & meal tracking
- **achievements**: Badge system & milestones

**Security**: Row Level Security (RLS) • User-scoped data access • Secure authentication

---

## 🚀 Deployment

### Mobile
```bash
flutter build apk --release          # Android
flutter build ios --release          # iOS
```

### Web
```bash
flutter build web --release
firebase deploy --only hosting
```

---

## 🤝 Contributing

1. Fork repository
2. Create feature branch (`feature/amazing-feature`)
3. Commit changes
4. Submit pull request

**Guidelines**: Flutter style guide • Meaningful commits • Test coverage • Documentation updates

---

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details.

---

## 📞 Contact

**Developer**: [Saad Nadeem](https://github.com/saadnadeem27)  
**Support**: [Issues](https://github.com/saadnadeem27/fitolnix/issues) • [Discussions](https://github.com/saadnadeem27/fitolnix/discussions)

---

<div align="center">

**Made with ❤️ using Flutter & Supabase**

*Star ⭐ this repository if you found it helpful!*

</div>