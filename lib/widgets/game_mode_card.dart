import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../models/game_mode.dart';

/// Custom game mode card widget
class GameModeCard extends StatefulWidget {
  final GameMode gameMode;
  final bool isSelected;
  final VoidCallback? onTap;

  const GameModeCard({
    super.key,
    required this.gameMode,
    this.isSelected = false,
    this.onTap,
  });

  @override
  State<GameModeCard> createState() => _GameModeCardState();
}

class _GameModeCardState extends State<GameModeCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    if (widget.isSelected) {
      _animationController.forward();
    }
  }

  @override
  void didUpdateWidget(GameModeCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected != oldWidget.isSelected) {
      if (widget.isSelected) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          width: AppDimensions.gameCardWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
            color: widget.isSelected ? AppColors.primary : AppColors.darkCardBg,
            border: Border.all(
              color:
                  widget.isSelected
                      ? AppColors.primaryLight
                      : AppColors.borderColor,
              width: 2,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.gameMode.icon,
                    style: const TextStyle(fontSize: 40),
                  ),
                  const SizedBox(height: AppDimensions.paddingSmall),
                  Text(
                    widget.gameMode.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color:
                          widget.isSelected
                              ? AppColors.textPrimary
                              : AppColors.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingXSmall),
                  Text(
                    widget.gameMode.playersLabel,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              // Kebab menu positioned to the right of the icon
              Positioned(
                top: 20,
                right: 20,
                child: Icon(
                  Icons.more_vert,
                  color: AppColors.textSecondary,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
