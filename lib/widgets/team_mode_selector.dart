import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../utils/responsive_utils.dart';

/// Team mode selector widget for SOLO, DUO, and SQUAD modes
class TeamModeSelector extends StatelessWidget {
  const TeamModeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.padding(context, 16),
      ),
      child: Row(
        children: [
          _buildModeButton(context, 'SOLO', 'assets/icons/solo.png'),
          SizedBox(width: ResponsiveUtils.spacing(context, 12)),
          _buildModeButton(context, 'DUO', 'assets/icons/duo.png'),
          SizedBox(width: ResponsiveUtils.spacing(context, 12)),
          _buildModeButton(context, 'SQUAD', 'assets/icons/squad.png'),
        ],
      ),
    );
  }

  Widget _buildModeButton(BuildContext context, String label, String iconPath) {
    return Expanded(
      child: Container(
        height: ResponsiveUtils.cardHeight(context, 50),
        decoration: BoxDecoration(
          color: AppColors.darkCardBg,
          borderRadius: BorderRadius.circular(
            ResponsiveUtils.borderRadius(context, 12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: GoogleFonts.jetBrainsMono(
                color: AppColors.textPrimary,
                fontSize: ResponsiveUtils.fontSize(context, 15),
                fontWeight: FontWeight.w400,
                height: 6.93 / 10,
                letterSpacing: 0,
              ),
            ),
            SizedBox(width: ResponsiveUtils.spacing(context, 8)),
            Image.asset(
              iconPath,
              width: ResponsiveUtils.iconSize(context, 20),
              height: ResponsiveUtils.iconSize(context, 20),
              color: AppColors.textPrimary,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.person_outline,
                  color: AppColors.textPrimary,
                  size: ResponsiveUtils.iconSize(context, 20),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
