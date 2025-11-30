import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../models/match.dart';
import '../utils/responsive_utils.dart';

/// Custom match card widget displaying match details
class MatchCard extends StatefulWidget {
  final Match match;
  final VoidCallback? onTap;
  final VoidCallback? onRegisterTap;

  const MatchCard({
    super.key,
    required this.match,
    this.onTap,
    this.onRegisterTap,
  });

  @override
  State<MatchCard> createState() => _MatchCardState();
}

class _MatchCardState extends State<MatchCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Check if this is card 1
    if (widget.match.id == '1') {
      return _buildCard1();
    }
    return _buildDefaultCard();
  }

  // Card 1 - shorter with no prize pool
  Widget _buildCard1() {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          constraints: const BoxConstraints(maxHeight: 200),
          child: GestureDetector(
            onTap: widget.onTap,

            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  ResponsiveUtils.borderRadius(context, 20),
                ),
              ),
              color: const Color.fromARGB(200, 208, 10, 10),
              elevation: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildMatchDateSection(),
                    _buildImageSection(),
                    _buildDetailsSection(includePrizePool: false),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Default card for other matches
  Widget _buildDefaultCard() {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          constraints: const BoxConstraints(maxHeight: 500),
          child: GestureDetector(
            onTap: widget.onTap,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(120),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              color: AppColors.darkCardBg,
              elevation: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMatchDateSection(),
                  _buildImageSection(),
                  _buildDetailsSection(includePrizePool: true),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Match Date Section
  Widget _buildMatchDateSection() {
    return Container(
      color: AppColors.darkBackground,
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium,
        vertical: AppDimensions.paddingSmall,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Match Date - ',
                  style: GoogleFonts.jetBrainsMono(
                    color: AppColors.textPrimary,
                    fontSize: ResponsiveUtils.fontSize(context, 12),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: _getMatchDate(),
                  style: GoogleFonts.jetBrainsMono(
                    color: AppColors.textPrimary.withOpacity(0.6),
                    fontSize: ResponsiveUtils.fontSize(context, 12),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: ResponsiveUtils.iconSize(context, 32),
            height: ResponsiveUtils.iconSize(context, 32),
            decoration: BoxDecoration(
              color: AppColors.textTertiary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(
                ResponsiveUtils.borderRadius(
                  context,
                  AppDimensions.radiusSmall,
                ),
              ),
            ),
            child: Center(
              child: Text(
                '?',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: ResponsiveUtils.fontSize(context, 16),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Image Section
  Widget _buildImageSection() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(0),
        topRight: Radius.circular(0),
      ),
      child: Container(
        height: ResponsiveUtils.imageHeight(context, 160),
        width: double.infinity,
        color: AppColors.darkSurface,
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: _buildMatchImage(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Details Section
  Widget _buildDetailsSection({required bool includePrizePool}) {
    return Padding(
      padding: EdgeInsets.only(
        left: 0,
        right: 0,
        top: 0,
        bottom: includePrizePool ? 5 : 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Battle Royal - Entry Fees Row
          SizedBox(
            height: ResponsiveUtils.cardHeight(
              context,
              includePrizePool ? 90 : 90,
            ),
            child: Stack(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 33, 33, 33),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(0),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'BATTLE ROYAL',
                              style: GoogleFonts.poppins(
                                color: AppColors.textPrimary,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                height: 6.93 / 12,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.match.gameType,
                              style: GoogleFonts.poppins(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                height: 6.93 / 12,
                                letterSpacing: 0,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 28, 28, 28),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(0),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'ENTRY FEES',
                              style: GoogleFonts.poppins(
                                color: AppColors.textPrimary,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                height: 6.93 / 12,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${widget.match.entryFees.currency} ${widget.match.entryFees.amount.toStringAsFixed(0)}/player',
                              style: GoogleFonts.poppins(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                height: 6.93 / 12,
                                letterSpacing: 0,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.darkSurface,
                      shape: BoxShape.circle,
                    ),
                    child: Center(child: _buildCircleImage()),
                  ),
                ),
              ],
            ),
          ),
          if (includePrizePool) ...[
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PRIZE POOL :',
                        style: GoogleFonts.poppins(
                          color: AppColors.textPrimary,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          height: 15.35 / 12,
                          letterSpacing: 0,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            '${widget.match.prizePool.currency}${widget.match.prizePool.amount.toStringAsFixed(0)}',
                            style: GoogleFonts.poppins(
                              color: AppColors.textPrimary,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              height: 7.3 / 12,
                              letterSpacing: 0,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              color: AppColors.accentRed,
                              shape: BoxShape.rectangle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '500 ELO',
                            style: GoogleFonts.poppins(
                              color: AppColors.textPrimary,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              height: 7.3 / 12,
                              letterSpacing: 0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '${widget.match.prizePool.totalSquads}/',
                              style: GoogleFonts.poppins(
                                color: AppColors.textPrimary,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                height: 6.93 / 12,
                                letterSpacing: 0,
                              ),
                            ),
                            TextSpan(
                              text: '25',
                              style: GoogleFonts.poppins(
                                color: AppColors.accentRed,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                height: 6.93 / 12,
                                letterSpacing: 0,
                              ),
                            ),
                            TextSpan(
                              text: ' SQUADS',
                              style: GoogleFonts.poppins(
                                color: AppColors.textPrimary,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                height: 6.93 / 12,
                                letterSpacing: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'KNOCKOUT',
                        style: GoogleFonts.poppins(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          height: 6.93 / 12,
                          letterSpacing: 0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMatchImage() {
    // Return different image based on match ID or title
    switch (widget.match.id) {
      case '1':
        // GWCS Season 1
        return Image.asset(
          'assets/images/gwcs.png',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _imagePlaceholder();
          },
        );
      case '2':
        // Indigos Series
        return Image.asset(
          'assets/images/indigus.png',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _imagePlaceholder();
          },
        );
      case '3':
        // Championship 3030
        return Image.asset(
          'assets/images/image35.png',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _imagePlaceholder();
          },
        );
      default:
        return _imagePlaceholder();
    }
  }

  Widget _imagePlaceholder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.image_outlined, size: 48, color: AppColors.textTertiary),
          SizedBox(height: 8),
          Text(
            'Match Image',
            style: TextStyle(
              color: AppColors.textTertiary,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  String _getMatchDate() {
    // Return different dates based on match ID
    switch (widget.match.id) {
      case '1':
        return 'Sun Oct 05 | 2:30pm';
      case '2':
        return 'Sun Oct 06 | 2:30pm';
      case '3':
        return 'Sun Oct 07 | 2:30pm';
      default:
        return 'Sun Oct 05 | 2:30pm';
    }
  }

  Widget _buildCircleImage() {
    // Return different circle image based on match ID
    switch (widget.match.id) {
      case '1':
        // GWCS Season 1 circle image
        return Image.asset(
          'assets/images/gwcs_circle.png',
          width: 44,
          height: 44,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Icon(
              Icons.image_outlined,
              size: 24,
              color: AppColors.textTertiary,
            );
          },
        );
      case '2':
        // Indigos Series circle image
        return Image.asset(
          'assets/images/other_circle.png',
          width: 44,
          height: 44,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Icon(
              Icons.image_outlined,
              size: 24,
              color: AppColors.textTertiary,
            );
          },
        );
      case '3':
        // Championship 3030 circle image
        return Image.asset(
          'assets/images/other_circle.png',
          width: 44,
          height: 44,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Icon(
              Icons.image_outlined,
              size: 24,
              color: AppColors.textTertiary,
            );
          },
        );
      default:
        return Icon(
          Icons.image_outlined,
          size: 24,
          color: AppColors.textTertiary,
        );
    }
  }
}
