import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../controllers/profile_controller.dart';
import '../../../widgets/custom_widgets.dart';
import '../../../utils/theme.dart';

class ProfileView extends StatelessWidget {
  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: AppColors.backgroundGradient,
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              _buildAppBar(),
              SliverToBoxAdapter(
                child: AnimationLimiter(
                  child: Column(
                    children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 375),
                      childAnimationBuilder: (widget) => SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(child: widget),
                      ),
                      children: [
                        _buildProfileCard(),
                        _buildStatsCards(),
                        _buildAchievements(),
                        _buildQuickSettings(),
                        _buildMenuSection(),
                        const SizedBox(height: 100), // Bottom padding
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
      pinned: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: AppColors.primaryGradient,
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => _showSettingsDialog(),
          icon: const Icon(
            Icons.settings,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileCard() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Obx(() => GlassCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: AppColors.primaryGradient,
                        ),
                        border: Border.all(color: AppColors.primary, width: 3),
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () => _showEditProfileDialog(),
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary,
                            border: Border.all(
                                color: AppColors.background, width: 2),
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  profileController.userName.value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  profileController.userEmail.value,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  profileController.memberSince.value,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textTertiary,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.surface.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    profileController.userBio.value,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                if (profileController.isPremium.value) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: AppColors.premiumGradient),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.star, size: 16, color: Colors.white),
                        SizedBox(width: 4),
                        Text(
                          'Premium Member',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          )),
    );
  }

  Widget _buildStatsCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Obx(() => Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Workouts',
                  profileController.totalWorkouts.value.toString(),
                  Icons.fitness_center,
                  AppColors.primaryGradient,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'Hours',
                  profileController.totalHours.value.toString(),
                  Icons.schedule,
                  AppColors.accentGradient,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'Calories',
                  '${(profileController.totalCaloriesBurned.value / 1000).toStringAsFixed(1)}k',
                  Icons.local_fire_department,
                  AppColors.secondaryGradient,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'Streak',
                  '${profileController.streakDays.value}d',
                  Icons.auto_awesome,
                  AppColors.premiumGradient,
                ),
              ),
            ],
          )),
    );
  }

  Widget _buildStatCard(
      String label, String value, IconData icon, List<Color> gradient) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: gradient),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievements() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Achievements',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Obx(() => SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: profileController.achievements.length,
                  itemBuilder: (context, index) {
                    final achievement = profileController.achievements[index];
                    return Container(
                      width: 100,
                      margin: const EdgeInsets.only(right: 12),
                      child: _buildAchievementCard(achievement),
                    );
                  },
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildAchievementCard(Map<String, dynamic> achievement) {
    return GlassCard(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: achievement['achieved']
                  ? achievement['color']
                  : AppColors.surface.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              achievement['icon'],
              color: achievement['achieved']
                  ? Colors.white
                  : AppColors.textTertiary,
              size: 20,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            achievement['title'],
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: achievement['achieved']
                  ? AppColors.textPrimary
                  : AppColors.textTertiary,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (achievement['achieved'])
            const Icon(
              Icons.check_circle,
              color: AppColors.success,
              size: 12,
            ),
        ],
      ),
    );
  }

  Widget _buildQuickSettings() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GlassCard(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quick Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            Obx(() => _buildSwitchTile(
                  'Dark Mode',
                  'Switch between light and dark themes',
                  Icons.dark_mode,
                  profileController.isDarkMode.value,
                  (value) => profileController.toggleDarkMode(),
                )),
            Obx(() => _buildSwitchTile(
                  'Notifications',
                  'Receive workout and nutrition reminders',
                  Icons.notifications,
                  profileController.notificationsEnabled.value,
                  (value) => profileController.toggleNotifications(),
                )),
            Obx(() => _buildSwitchTile(
                  'Sound Effects',
                  'Play sounds during workouts',
                  Icons.volume_up,
                  profileController.soundEnabled.value,
                  (value) => profileController.toggleSound(),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile(String title, String subtitle, IconData icon,
      bool value, Function(bool) onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
            activeTrackColor: AppColors.primary.withOpacity(0.3),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildMenuCard('Personal Info', 'Edit your personal information',
              Icons.person, () => _showEditProfileDialog()),
          _buildMenuCard('Goals & Targets', 'Set your fitness goals',
              Icons.flag, () => _showGoalsDialog()),
          _buildMenuCard(
              'Workout Preferences',
              'Customize your workout experience',
              Icons.fitness_center,
              () => _showWorkoutPreferencesDialog()),
          _buildMenuCard('Nutrition Settings', 'Configure nutrition tracking',
              Icons.restaurant, () => _showNutritionSettingsDialog()),
          if (!profileController.isPremium.value)
            _buildMenuCard('Upgrade to Premium', 'Unlock all features',
                Icons.star, () => _showPremiumDialog(),
                isPremium: true),
          _buildMenuCard('Privacy & Security', 'Manage your privacy settings',
              Icons.security, () => _showPrivacyDialog()),
          _buildMenuCard('Help & Support', 'Get help and support', Icons.help,
              () => _showHelpDialog()),
          _buildMenuCard('About Fitolnix', 'App information and credits',
              Icons.info, () => _showAboutDialog()),
          _buildMenuCard('Sign Out', 'Sign out of your account', Icons.logout,
              () => profileController.logout(),
              isDestructive: true),
        ],
      ),
    );
  }

  Widget _buildMenuCard(
      String title, String subtitle, IconData icon, VoidCallback onTap,
      {bool isPremium = false, bool isDestructive = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: onTap,
        child: GlassCard(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: isPremium
                      ? const LinearGradient(colors: AppColors.premiumGradient)
                      : isDestructive
                          ? LinearGradient(colors: [
                              AppColors.accent,
                              AppColors.accent.withOpacity(0.7)
                            ])
                          : LinearGradient(colors: [
                              AppColors.primary.withOpacity(0.1),
                              AppColors.primary.withOpacity(0.1)
                            ]),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon,
                    color: isPremium || isDestructive
                        ? Colors.white
                        : AppColors.primary,
                    size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isDestructive
                                ? AppColors.accent
                                : AppColors.textPrimary,
                          ),
                        ),
                        if (isPremium) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  colors: AppColors.premiumGradient),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'PRO',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: AppColors.textTertiary,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditProfileDialog() {
    final nameController =
        TextEditingController(text: profileController.userName.value);
    final emailController =
        TextEditingController(text: profileController.userEmail.value);
    final phoneController =
        TextEditingController(text: profileController.userPhone.value);
    final locationController =
        TextEditingController(text: profileController.userLocation.value);
    final bioController =
        TextEditingController(text: profileController.userBio.value);

    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          height: MediaQuery.of(Get.context!).size.height * 0.8,
          child: GlassCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Edit Profile',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon:
                          const Icon(Icons.close, color: AppColors.textPrimary),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: nameController,
                          label: 'Full Name',
                          prefixIcon: const Icon(Icons.person),
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          controller: emailController,
                          label: 'Email Address',
                          prefixIcon: const Icon(Icons.email),
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          controller: phoneController,
                          label: 'Phone Number',
                          prefixIcon: const Icon(Icons.phone),
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          controller: locationController,
                          label: 'Location',
                          prefixIcon: const Icon(Icons.location_on),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: bioController,
                          maxLines: 3,
                          style: const TextStyle(color: AppColors.textPrimary),
                          decoration: InputDecoration(
                            labelText: 'Bio',
                            prefixIcon: const Icon(Icons.edit,
                                color: AppColors.primary),
                            labelStyle:
                                const TextStyle(color: AppColors.textSecondary),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  color: AppColors.surface, width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  color: AppColors.primary, width: 2),
                            ),
                            filled: true,
                            fillColor: AppColors.surface.withOpacity(0.3),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GradientButton(
                  text: 'Save Changes',
                  onPressed: () {
                    profileController.updateUserInfo(
                      name: nameController.text,
                      email: emailController.text,
                      phone: phoneController.text,
                      location: locationController.text,
                      bio: bioController.text,
                    );
                    Get.back();
                    Get.snackbar(
                      'Success',
                      'Profile updated successfully',
                      backgroundColor: AppColors.success,
                      colorText: Colors.white,
                    );
                  },
                  icon: Icons.save,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSettingsDialog() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          height: MediaQuery.of(Get.context!).size.height * 0.8,
          child: GlassCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon:
                          const Icon(Icons.close, color: AppColors.textPrimary),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Notifications',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Obx(() => _buildSwitchTile(
                              'Workout Reminders',
                              'Get notified about scheduled workouts',
                              Icons.fitness_center,
                              profileController.workoutReminders.value,
                              (value) =>
                                  profileController.toggleWorkoutReminders(),
                            )),
                        Obx(() => _buildSwitchTile(
                              'Nutrition Reminders',
                              'Get reminded to log your meals',
                              Icons.restaurant,
                              profileController.nutritionReminders.value,
                              (value) =>
                                  profileController.toggleNutritionReminders(),
                            )),
                        Obx(() => _buildSwitchTile(
                              'Progress Updates',
                              'Receive weekly progress summaries',
                              Icons.trending_up,
                              profileController.progressUpdates.value,
                              (value) =>
                                  profileController.toggleProgressUpdates(),
                            )),
                        const SizedBox(height: 20),
                        const Text(
                          'App Preferences',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Obx(() => _buildSwitchTile(
                              'Vibration',
                              'Use haptic feedback',
                              Icons.vibration,
                              profileController.vibrationEnabled.value,
                              (value) => profileController.toggleVibration(),
                            )),
                        const SizedBox(height: 16),
                        _buildDropdownTile(
                          'Language',
                          'Select your preferred language',
                          Icons.language,
                          profileController.selectedLanguage.value,
                          ['English', 'Spanish', 'French', 'German', 'Italian'],
                          (value) => profileController.updateLanguage(value!),
                        ),
                        _buildDropdownTile(
                          'Units',
                          'Choose measurement units',
                          Icons.straighten,
                          profileController.selectedUnit.value,
                          ['Metric', 'Imperial'],
                          (value) => profileController.updateUnit(value!),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownTile(String title, String subtitle, IconData icon,
      String value, List<String> options, Function(String?) onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          DropdownButton<String>(
            value: value,
            onChanged: onChanged,
            items: options.map((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(
                  option,
                  style: const TextStyle(color: AppColors.textPrimary),
                ),
              );
            }).toList(),
            dropdownColor: AppColors.surface,
            underline: Container(),
          ),
        ],
      ),
    );
  }

  void _showGoalsDialog() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          height: MediaQuery.of(Get.context!).size.height * 0.7,
          child: GlassCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Goals & Targets',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon:
                          const Icon(Icons.close, color: AppColors.textPrimary),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Obx(() => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Weight Progress',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.surface.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Current: ${profileController.currentWeight.value}kg',
                                      style: const TextStyle(
                                          color: AppColors.textPrimary),
                                    ),
                                    Text(
                                      'Target: ${profileController.targetWeight.value}kg',
                                      style: const TextStyle(
                                          color: AppColors.textPrimary),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                LinearPercentIndicator(
                                  lineHeight: 8,
                                  percent: profileController.weightProgress
                                      .clamp(0.0, 1.0),
                                  backgroundColor: AppColors.surface,
                                  progressColor: AppColors.primary,
                                  barRadius: const Radius.circular(4),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Weekly Workout Goal',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Slider(
                            value:
                                profileController.weeklyGoal.value.toDouble(),
                            min: 1,
                            max: 7,
                            divisions: 6,
                            activeColor: AppColors.primary,
                            onChanged: (value) => profileController.updateGoals(
                                weekly: value.toInt()),
                            label:
                                '${profileController.weeklyGoal.value} workouts/week',
                          ),
                          Text(
                            '${profileController.weeklyGoal.value} workouts per week',
                            style:
                                const TextStyle(color: AppColors.textSecondary),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Daily Calorie Target',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Slider(
                            value: profileController.targetCalories.value,
                            min: 1200,
                            max: 4000,
                            divisions: 28,
                            activeColor: AppColors.primary,
                            onChanged: (value) =>
                                profileController.updateGoals(calories: value),
                            label:
                                '${profileController.targetCalories.value.toInt()} calories',
                          ),
                          Text(
                            '${profileController.targetCalories.value.toInt()} calories per day',
                            style:
                                const TextStyle(color: AppColors.textSecondary),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )),
                ),
                GradientButton(
                  text: 'Save Goals',
                  onPressed: () {
                    Get.back();
                    Get.snackbar(
                      'Success',
                      'Goals updated successfully',
                      backgroundColor: AppColors.success,
                      colorText: Colors.white,
                    );
                  },
                  icon: Icons.save,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showPremiumDialog() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          height: MediaQuery.of(Get.context!).size.height * 0.8,
          child: GlassCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: AppColors.premiumGradient),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.star, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Fitolnix Premium',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon:
                          const Icon(Icons.close, color: AppColors.textPrimary),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: profileController.premiumFeatures.length,
                    itemBuilder: (context, index) {
                      final feature = profileController.premiumFeatures[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.surface.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                    colors: AppColors.premiumGradient),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(feature['icon'],
                                  color: Colors.white, size: 20),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    feature['title'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  Text(
                                    feature['description'],
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.check_circle,
                              color: AppColors.success,
                              size: 20,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient:
                        const LinearGradient(colors: AppColors.premiumGradient),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Special Offer!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '\$19.99',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.7),
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            '\$9.99/month',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '50% off for first 3 months',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                GradientButton(
                  text: 'Upgrade Now',
                  onPressed: () {
                    profileController.upgradeToPremium();
                    Get.back();
                  },
                  icon: Icons.star,
                  gradient: AppColors.premiumGradient,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showWorkoutPreferencesDialog() {
    Get.snackbar(
      'Coming Soon',
      'Workout preferences will be available in the next update',
      backgroundColor: AppColors.primary,
      colorText: Colors.white,
    );
  }

  void _showNutritionSettingsDialog() {
    Get.snackbar(
      'Coming Soon',
      'Nutrition settings will be available in the next update',
      backgroundColor: AppColors.primary,
      colorText: Colors.white,
    );
  }

  void _showPrivacyDialog() {
    Get.snackbar(
      'Coming Soon',
      'Privacy settings will be available in the next update',
      backgroundColor: AppColors.primary,
      colorText: Colors.white,
    );
  }

  void _showHelpDialog() {
    Get.snackbar(
      'Coming Soon',
      'Help & support will be available in the next update',
      backgroundColor: AppColors.primary,
      colorText: Colors.white,
    );
  }

  void _showAboutDialog() {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1E1E2E),
        title: const Text(
          'About Fitolnix',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Fitolnix v1.0.0\n\nYour ultimate fitness companion designed to help you achieve your health and wellness goals.\n\nBuilt with Flutter & GetX',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
