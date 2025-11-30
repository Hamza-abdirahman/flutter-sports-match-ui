import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

/// Custom tab bar widget with animation
class CustomTabBar extends StatefulWidget {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;

  const CustomTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.tabs.length,
      initialIndex: widget.selectedIndex,
      vsync: this,
    );
    _tabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) {
      widget.onTabChanged(_tabController.index);
    }
  }

  @override
  void didUpdateWidget(CustomTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _tabController.animateTo(widget.selectedIndex);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.darkBackground,
      child: Stack(
        children: [
          // Reddish splash/glow behind selected tab
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            left:
                widget.selectedIndex == 0
                    ? 0
                    : 96, // Adjust position based on tab
            top: 0,
            bottom: 0,
            child: Container(
              width: 80, // Width of the splash
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.0,
                  colors: [
                    AppColors.accentRed.withOpacity(0.3), // Center glow
                    AppColors.accentRed.withOpacity(0.15),
                    Colors.transparent, // Fade to transparent
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabs: widget.tabs.map((tab) => Tab(text: tab)).toList(),
              labelColor: AppColors.textPrimary,
              unselectedLabelColor: AppColors.textPrimary,
              indicatorColor: AppColors.accentRed,
              indicatorSize: TabBarIndicatorSize.label,
              dividerColor: AppColors.borderColor,
              labelStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              unselectedLabelStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
              labelPadding: const EdgeInsets.symmetric(horizontal: 16),
              tabAlignment: TabAlignment.start,
            ),
          ),

          // White separator at center between tabs
          Positioned(
            left: 80,
            top: 12,
            bottom: 12,
            child: Container(height: 24, width: 1, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
