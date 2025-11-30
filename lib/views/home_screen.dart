import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_strings.dart';
import '../providers/game_mode_provider.dart';
import '../widgets/custom_tab_bar.dart';
import '../widgets/esports_tab.dart';
import '../utils/responsive_utils.dart';

/// Home screen showing esports matches and game modes
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTabIndex = 0;
  int _selectedGameModeId = 0; // Track selected game mode

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            // App bar with left and right placeholders
            SliverAppBar(
              backgroundColor: AppColors.darkSurface,
              elevation: 0,
              floating: true,
              snap: true,
              toolbarHeight: ResponsiveUtils.cardHeight(context, 70),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left: Image placeholder
                  Container(
                    width: ResponsiveUtils.cardHeight(context, 120),
                    height: ResponsiveUtils.cardHeight(context, 40),
                    decoration: BoxDecoration(
                      color: AppColors.darkCardBg,
                      borderRadius: BorderRadius.circular(
                        ResponsiveUtils.borderRadius(
                          context,
                          AppDimensions.radiusSmall,
                        ),
                      ),
                    ),
                    child: Image.asset(
                      'assets/images/elo.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image_outlined,
                                size: ResponsiveUtils.iconSize(context, 20),
                                color: AppColors.textTertiary,
                              ),
                              Text(
                                'ELO',
                                style: TextStyle(
                                  color: AppColors.textTertiary,
                                  fontSize: ResponsiveUtils.fontSize(
                                    context,
                                    8,
                                  ),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  // Right: Selectable placeholder
                  Container(
                    width: ResponsiveUtils.cardHeight(context, 120),
                    height: ResponsiveUtils.cardHeight(context, 45),
                    decoration: BoxDecoration(
                      color: AppColors.darkCardBg,
                      borderRadius: BorderRadius.circular(
                        ResponsiveUtils.borderRadius(
                          context,
                          AppDimensions.radiusSmall,
                        ),
                      ),
                      border: Border.all(color: AppColors.accentRed, width: 1),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Coming Soon')),
                          );
                        },
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/battlegrounds5.png',
                                fit: BoxFit.contain,
                                color: AppColors.textTertiary,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    Icons.image_outlined,
                                    size: 20,
                                    color: AppColors.textTertiary,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Game modes section
            SliverToBoxAdapter(child: _buildHeaderGameModes(context)),
            // Tab bar - only show for first game mode (Arena)
            if (_selectedGameModeId == 0)
              SliverPersistentHeader(
                delegate: _TabBarDelegate(
                  selectedIndex: _selectedTabIndex,
                  onTabChanged: (index) {
                    setState(() {
                      _selectedTabIndex = index;
                    });
                  },
                ),
                pinned: true,
              ),
          ];
        },
        body: _buildBodyContent(),
      ),
    );
  }

  Widget _buildBodyContent() {
    // If first game mode (Arena) is selected, show the Esports/Registered tabs
    if (_selectedGameModeId == 0) {
      return _selectedTabIndex == 0
          ? const EsportsTab()
          : const _RegisteredMatchesTab();
    }
    // Otherwise show empty screen for other game modes
    return _buildEmptyGameModeScreen();
  }

  Widget _buildEmptyGameModeScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.construction_outlined,
            size: 64,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: 16),
          const Text(
            'Coming Soon',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'This game mode is not available yet',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderGameModes(BuildContext context) {
    final gameModeProvider = context.watch<GameModeProvider>();
    return Container(
      color: AppColors.darkSurface,
      padding: EdgeInsets.all(
        ResponsiveUtils.padding(context, AppDimensions.paddingMedium),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SizedBox(
                  height: ResponsiveUtils.cardHeight(context, 125),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: gameModeProvider.gameModes.length,
                    itemBuilder: (context, index) {
                      final gameMode = gameModeProvider.gameModes[index];
                      final isSelected = _selectedGameModeId == index;
                      return Padding(
                        padding: EdgeInsets.only(
                          right: ResponsiveUtils.padding(
                            context,
                            AppDimensions.paddingMedium,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Image placeholder
                            Container(
                              width: ResponsiveUtils.iconSize(context, 70),
                              height: ResponsiveUtils.iconSize(context, 70),
                              decoration: BoxDecoration(
                                color: AppColors.darkCardBg,
                                borderRadius: BorderRadius.circular(
                                  ResponsiveUtils.borderRadius(context, 20.0),
                                ),
                                border: Border.all(
                                  color:
                                      isSelected
                                          ? const Color.fromARGB(
                                            255,
                                            255,
                                            255,
                                            255,
                                          )
                                          : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selectedGameModeId = index;
                                      _selectedTabIndex = 0; // Reset tab index
                                    });
                                    gameModeProvider.selectGameMode(
                                      gameMode.id,
                                    );
                                  },
                                  child: Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16.0),
                                      child: _buildHeaderGameModeImage(index),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: ResponsiveUtils.spacing(context, 8),
                            ),
                            SizedBox(
                              width: ResponsiveUtils.iconSize(context, 75),
                              height: ResponsiveUtils.cardHeight(context, 40),
                              child: Text(
                                gameMode.name,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.jetBrainsMono(
                                  // fontFamily: 'JetBrains Mono',
                                  color: AppColors.textPrimary,
                                  fontSize: ResponsiveUtils.fontSize(
                                    context,
                                    10.5,
                                  ),
                                  fontWeight: FontWeight.w400,
                                  height: 1.5,
                                  letterSpacing: -0.26,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              // Kebab menu on the right
              Padding(
                padding: EdgeInsets.only(
                  top: ResponsiveUtils.spacing(context, 5.0),
                  bottom: ResponsiveUtils.spacing(context, 60),
                ),
                child: GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Game modes menu tapped')),
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: ResponsiveUtils.iconSize(context, 6),
                        height: ResponsiveUtils.iconSize(context, 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                      SizedBox(height: ResponsiveUtils.spacing(context, 6)),
                      Container(
                        width: ResponsiveUtils.iconSize(context, 6),
                        height: ResponsiveUtils.iconSize(context, 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                      SizedBox(height: ResponsiveUtils.spacing(context, 6)),
                      Container(
                        width: ResponsiveUtils.iconSize(context, 6),
                        height: ResponsiveUtils.iconSize(context, 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderGameModeImage(int index) {
    switch (index) {
      case 0:
        // Arena image
        return Image.asset(
          'assets/images/arena.png',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _imagePlaceholder();
          },
        );
      case 1:
        // Zenith League image
        return Image.asset(
          'assets/images/zenith.png',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _imagePlaceholder();
          },
        );
      case 2:
        // Championship image
        return Image.asset(
          'assets/images/champion.png',
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.image_outlined, size: 32, color: AppColors.textTertiary),
        SizedBox(height: 2),
        Text(
          'Image',
          style: TextStyle(
            color: AppColors.textTertiary,
            fontSize: 8,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

/// Registered matches tab content
class _RegisteredMatchesTab extends StatelessWidget {
  const _RegisteredMatchesTab();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      child: SizedBox.expand(),
    );
  }
}

/// Custom tab bar delegate for persistent header
class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;

  _TabBarDelegate({required this.selectedIndex, required this.onTabChanged});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: AppColors.darkBackground,
      child: CustomTabBar(
        tabs: const [AppStrings.esports, AppStrings.registeredMatches],
        selectedIndex: selectedIndex,
        onTabChanged: onTabChanged,
      ),
    );
  }

  @override
  double get maxExtent => 48;

  @override
  double get minExtent => 48;

  @override
  bool shouldRebuild(_TabBarDelegate oldDelegate) {
    return selectedIndex != oldDelegate.selectedIndex;
  }
}
