import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../providers/match_provider.dart';
import '../providers/game_mode_provider.dart';
import '../widgets/match_card.dart';
import '../widgets/team_mode_selector.dart';
import '../utils/responsive_utils.dart';

/// Esports tab content showing game modes and matches
class EsportsTab extends StatelessWidget {
  const EsportsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final matchProvider = context.watch<MatchProvider>();
    final gameModeProvider = context.watch<GameModeProvider>();

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: ResponsiveUtils.getMaxContentWidth(context),
              ),
              child: Padding(
                padding: EdgeInsets.all(
                  ResponsiveUtils.padding(context, AppDimensions.paddingMedium),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: ResponsiveUtils.spacing(context, 20)),
                    // Game modes section (Sniper and Assault)
                    _buildGameModesRow(context, gameModeProvider),
                    SizedBox(height: ResponsiveUtils.spacing(context, 16)),

                    // Team mode selector (SOLO, DUO, SQUAD)
                    const TeamModeSelector(),
                    SizedBox(height: ResponsiveUtils.spacing(context, 30)),

                    // Match date
                    const SizedBox(height: 0),
                    // Matches grid
                    _buildMatchesGrid(context, matchProvider),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGameModesRow(
    BuildContext context,
    GameModeProvider gameModeProvider,
  ) {
    // Show first two game modes (Sniper and Assault)
    final gameModes = gameModeProvider.gameModes.take(2).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Game Modes',
          style: GoogleFonts.jetBrainsMono(
            color: AppColors.textPrimary,
            fontSize: ResponsiveUtils.fontSize(context, 15.47),
            fontWeight: FontWeight.w400,
            height: 1.5,
            letterSpacing: 0,
          ),
        ),
        SizedBox(
          height: ResponsiveUtils.spacing(context, AppDimensions.paddingMedium),
        ),
        Row(
          children: [
            // Horizontal lines icon (=)
            Padding(
              padding: EdgeInsets.only(
                right: ResponsiveUtils.spacing(context, 10.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: ResponsiveUtils.iconSize(context, 10),
                    height: 2,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: ResponsiveUtils.iconSize(context, 10),
                    height: 2,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            // Game mode cards
            Expanded(
              child: Row(
                children: List.generate(gameModes.length, (index) {
                  final gameMode = gameModes[index];
                  // First card gets flex 3, second card gets flex 2 (making first bigger but not too big)
                  final flexValue = index == 0 ? 3 : 2;

                  return Expanded(
                    flex: flexValue,
                    child: Padding(
                      padding: EdgeInsets.only(
                        right:
                            index < gameModes.length - 1
                                ? AppDimensions.paddingMedium
                                : 0,
                      ),
                      child: Container(
                        height: ResponsiveUtils.cardHeight(context, 60),
                        decoration: BoxDecoration(
                          color: AppColors.darkCardBg,
                          borderRadius: BorderRadius.circular(
                            ResponsiveUtils.borderRadius(
                              context,
                              AppDimensions.radiusSmall,
                            ),
                          ),
                          border: Border.all(
                            color: Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 1.0,
                            vertical: 8.0,
                          ),
                          child: Row(
                            children: [
                              // Icon placeholder
                              Container(
                                width: ResponsiveUtils.iconSize(context, 50),
                                height: ResponsiveUtils.iconSize(context, 50),
                                decoration: BoxDecoration(
                                  color: AppColors.darkSurface,
                                  borderRadius: BorderRadius.circular(
                                    ResponsiveUtils.borderRadius(
                                      context,
                                      AppDimensions.radiusSmall,
                                    ),
                                  ),
                                ),
                                child: Center(
                                  child: _buildGameModeIcon(context, index),
                                ),
                              ),
                              SizedBox(
                                width: ResponsiveUtils.spacing(context, 10),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          gameMode.name,
                                          style: TextStyle(
                                            color: AppColors.textPrimary,
                                            fontSize: ResponsiveUtils.fontSize(
                                              context,
                                              10,
                                            ),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(
                                          width: ResponsiveUtils.spacing(
                                            context,
                                            4,
                                          ),
                                        ),
                                        Image.asset(
                                          'assets/icons/arrow.png',
                                          width: ResponsiveUtils.iconSize(
                                            context,
                                            13,
                                          ),
                                          height: ResponsiveUtils.iconSize(
                                            context,
                                            13,
                                          ),
                                          color: const Color.fromARGB(
                                            255,
                                            29,
                                            253,
                                            37,
                                          ),
                                        ),
                                        const Spacer(),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      gameMode.playersLabel,
                                      style: TextStyle(
                                        color: AppColors.textSecondary,
                                        fontSize: ResponsiveUtils.fontSize(
                                          context,
                                          10,
                                        ),
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGameModeIcon(BuildContext context, int index) {
    final iconSize = ResponsiveUtils.iconSize(context, 24);
    switch (index) {
      case 0:
        // Sniper icon
        return Image.asset(
          'assets/images/target.png',
          width: iconSize,
          height: iconSize,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(
              Icons.image_outlined,
              size: 32,
              color: AppColors.textTertiary,
            );
          },
        );
      case 1:
        // Assault icon
        return Image.asset(
          'assets/images/vector (1).png',
          width: iconSize,
          height: iconSize,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(
              Icons.image_outlined,
              size: 32,
              color: AppColors.textTertiary,
            );
          },
        );
      default:
        return const Icon(
          Icons.image_outlined,
          size: 20,
          color: AppColors.textSecondary,
        );
    }
  }

  Widget _buildMatchesGrid(BuildContext context, MatchProvider matchProvider) {
    final matches = matchProvider.matches;

    if (matches.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppDimensions.paddingXLarge,
          ),
          child: Text(
            'No matches available',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      );
    }

    return Column(
      children: List.generate(matches.length, (index) {
        final match = matches[index];

        // Define heights based on card type
        double cardHeight;
        if (match.id == '1') {
          cardHeight = ResponsiveUtils.cardHeight(
            context,
            315,
          ); // Card 1: shorter (no prize pool)
        } else {
          cardHeight = ResponsiveUtils.cardHeight(
            context,
            380,
          ); // Cards 2 & 3: taller (with prize pool)
        }

        return Padding(
          padding: EdgeInsets.only(
            bottom: ResponsiveUtils.spacing(context, 40),
          ),
          child: SizedBox(
            height: cardHeight,
            child: MatchCard(
              match: match,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${match.title} selected')),
                );
              },
              onRegisterTap: () {
                matchProvider.registerMatch(match.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Registered for ${match.title}')),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
