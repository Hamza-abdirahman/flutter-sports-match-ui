import 'package:flutter/material.dart';

/// Responsive utility class for handling different screen sizes
class ResponsiveUtils {
  // Prevent instantiation
  ResponsiveUtils._();

  /// Get screen width
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Get screen height
  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// Check if device is in landscape mode
  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  /// Check if device is in portrait mode
  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  /// Check if device is mobile (width < 600)
  static bool isMobile(BuildContext context) {
    return screenWidth(context) < 600;
  }

  /// Check if device is tablet (600 <= width < 900)
  static bool isTablet(BuildContext context) {
    final width = screenWidth(context);
    return width >= 600 && width < 900;
  }

  /// Check if device is desktop (width >= 900)
  static bool isDesktop(BuildContext context) {
    return screenWidth(context) >= 900;
  }

  /// Get responsive font size
  static double fontSize(BuildContext context, double baseSize) {
    final width = screenWidth(context);
    if (width < 360) {
      return baseSize * 0.9; // Small phones
    } else if (width < 600) {
      return baseSize; // Normal phones
    } else if (width < 900) {
      return baseSize * 1.1; // Tablets
    } else {
      return baseSize * 1.2; // Desktop
    }
  }

  /// Get responsive padding
  static double padding(BuildContext context, double basePadding) {
    final width = screenWidth(context);
    if (width < 360) {
      return basePadding * 0.8; // Small phones
    } else if (width < 600) {
      return basePadding; // Normal phones
    } else if (width < 900) {
      return basePadding * 1.2; // Tablets
    } else {
      return basePadding * 1.5; // Desktop
    }
  }

  /// Get responsive icon size
  static double iconSize(BuildContext context, double baseSize) {
    final width = screenWidth(context);
    if (width < 360) {
      return baseSize * 0.9;
    } else if (width < 600) {
      return baseSize;
    } else if (width < 900) {
      return baseSize * 1.15;
    } else {
      return baseSize * 1.3;
    }
  }

  /// Get responsive card height
  static double cardHeight(BuildContext context, double baseHeight) {
    final width = screenWidth(context);
    if (width < 360) {
      return baseHeight * 0.9;
    } else if (width < 600) {
      return baseHeight;
    } else if (width < 900) {
      return baseHeight * 1.1;
    } else {
      return baseHeight * 1.15;
    }
  }

  /// Get number of columns for grid based on screen size
  static int getGridColumns(BuildContext context) {
    final width = screenWidth(context);
    if (width < 600) {
      return 1; // Mobile: 1 column
    } else if (width < 900) {
      return 2; // Tablet: 2 columns
    } else {
      return 3; // Desktop: 3 columns
    }
  }

  /// Get responsive spacing
  static double spacing(BuildContext context, double baseSpacing) {
    final width = screenWidth(context);
    if (width < 360) {
      return baseSpacing * 0.75;
    } else if (width < 600) {
      return baseSpacing;
    } else if (width < 900) {
      return baseSpacing * 1.25;
    } else {
      return baseSpacing * 1.5;
    }
  }

  /// Get max content width (useful for larger screens)
  static double getMaxContentWidth(BuildContext context) {
    final width = screenWidth(context);
    if (width > 1200) {
      return 1200; // Cap content width on very large screens
    }
    return width;
  }

  /// Get responsive border radius
  static double borderRadius(BuildContext context, double baseRadius) {
    final width = screenWidth(context);
    if (width < 360) {
      return baseRadius * 0.9;
    } else if (width < 600) {
      return baseRadius;
    } else {
      return baseRadius * 1.1;
    }
  }

  /// Get responsive image height (considers orientation)
  static double imageHeight(BuildContext context, double baseHeight) {
    final width = screenWidth(context);
    final height = screenHeight(context);
    final isLandscapeMode = isLandscape(context);

    // In landscape mode, use a percentage of screen height for better scaling
    if (isLandscapeMode) {
      // Use 25-35% of screen height depending on device size
      if (width < 600) {
        return height * 0.3; // 30% of height for small phones in landscape
      } else if (width < 900) {
        return height * 0.35; // 35% of height for tablets in landscape
      } else {
        return height * 0.3; // 30% of height for desktop
      }
    }

    // In portrait mode, use width-based scaling
    if (width < 360) {
      return baseHeight * 0.9;
    } else if (width < 600) {
      return baseHeight;
    } else if (width < 900) {
      return baseHeight * 1.1;
    } else {
      return baseHeight * 1.15;
    }
  }
}
