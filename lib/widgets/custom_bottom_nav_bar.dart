import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../utils/responsive_utils.dart';

/// Custom bottom navigation bar
class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final navItems = [
      {
        'label': 'esports',
        'iconPath': 'assets/icons/home_icon.png',
        'fallbackIcon': Icons.sports_esports,
      },
      {
        'label': 'search',
        'iconPath': 'assets/icons/search_icon.png',
        'fallbackIcon': Icons.search,
      },
      {
        'label': 'leaderboard',
        'iconPath': 'assets/icons/leadership_icon.png',
        'fallbackIcon': Icons.leaderboard,
      },
      {
        'label': 'group',
        'iconPath': 'assets/icons/group_icon.png',
        'fallbackIcon': Icons.group,
      },
      {
        'label': 'profile',
        'iconPath': 'assets/icons/profile2.png',
        'fallbackIcon': Icons.person,
      },
    ];

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.darkSurface,
        border: Border(top: BorderSide(color: AppColors.borderColor, width: 1)),
      ),
      child: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.darkSurface,
        selectedItemColor: AppColors.textPrimary,
        unselectedItemColor: const Color.fromARGB(255, 113, 109, 109),
        selectedLabelStyle: TextStyle(
          fontSize: ResponsiveUtils.fontSize(context, 12),
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: ResponsiveUtils.fontSize(context, 12),
        ),
        elevation: 0,
        items: [
          for (int i = 0; i < navItems.length; i++)
            BottomNavigationBarItem(
              icon: _buildNavIcon(
                context,
                navItems[i]['iconPath'] as String,
                navItems[i]['fallbackIcon'] as IconData,
                i == selectedIndex,
                isProfile: i == 4, // Profile is the 5th item (index 4)
              ),
              label: navItems[i]['label'] as String,
            ),
        ],
      ),
    );
  }

  Widget _buildNavIcon(
    BuildContext context,
    String iconPath,
    IconData fallbackIcon,
    bool isSelected, {
    bool isProfile = false,
  }) {
    final baseIconSize = isProfile ? 35.0 : AppDimensions.navBarIconSize;
    final iconSize = ResponsiveUtils.iconSize(context, baseIconSize);

    return Image.asset(
      iconPath,
      width: iconSize,
      height: iconSize,
      color:
          isProfile
              ? null // No color tint for profile image
              : (isSelected
                  ? AppColors
                      .accentRed // Red when selected
                  : Colors.grey), // Gray when not selected
      errorBuilder: (context, error, stackTrace) {
        // Fallback to Material icon if image fails to load
        return Icon(
          fallbackIcon,
          size: iconSize,
          color: isSelected ? AppColors.accentRed : Colors.grey,
        );
      },
    );
  }
}
