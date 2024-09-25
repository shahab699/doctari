import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get bodyLargeBluegray300 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.blueGray300,
        fontSize: 18.fSize,
        fontWeight: FontWeight.w400,
      );
  static get bodyLargeBluegray500 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.blueGray500.withOpacity(0.9),
        fontWeight: FontWeight.w400,
      );
  static get bodyLargeGray500 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.gray500,
        fontWeight: FontWeight.w400,
      );
  static get bodyLargeGray50001 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.gray50001,
        fontWeight: FontWeight.w400,
      );
  static get bodyLargeInterGray50001 =>
      theme.textTheme.bodyLarge!.inter.copyWith(
        color: appTheme.gray50001,
        fontWeight: FontWeight.w400,
      );
  static get bodyLargeOnErrorContainer => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
        fontWeight: FontWeight.w400,
      );
  static get bodyLargeRegular => theme.textTheme.bodyLarge!.copyWith(
        fontWeight: FontWeight.w400,
      );
  static get bodyLargeRubik => theme.textTheme.bodyLarge!.rubik;
  static get bodyLargeRubikOnErrorContainer =>
      theme.textTheme.bodyLarge!.rubik.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
        fontWeight: FontWeight.w400,
      );
  static get bodyLargeRubikOnErrorContainerRegular =>
      theme.textTheme.bodyLarge!.rubik.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
        fontSize: 18.fSize,
        fontWeight: FontWeight.w400,
      );
  static get bodyLargee5677294 => theme.textTheme.bodyLarge!.copyWith(
        color: Color(0XE5677294),
        fontWeight: FontWeight.w400,
      );
  static get bodyLargeff333333 => theme.textTheme.bodyLarge!.copyWith(
        color: Color(0XFF333333),
        fontWeight: FontWeight.w400,
      );
  static get bodyMedium14 => theme.textTheme.bodyMedium!.copyWith(
        fontSize: 14.fSize,
      );
  static get bodyMediumBlack900 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.black900,
        fontSize: 14.fSize,
      );
  static get bodyMediumBluegray300 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.blueGray300,
        fontSize: 14.fSize,
      );
  static get bodyMediumBluegray500 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.blueGray500.withOpacity(0.8),
        fontSize: 14.fSize,
        fontWeight: FontWeight.w300,
      );
  static get bodyMediumBluegray50014 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.blueGray500.withOpacity(0.9),
        fontSize: 14.fSize,
      );
  static get bodyMediumBluegray50014_1 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.blueGray500,
        fontSize: 14.fSize,
      );
  static get bodyMediumBluegray50015 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.blueGray500,
        fontSize: 15.fSize,
      );
  static get bodyMediumBluegray500Light => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.blueGray500,
        fontSize: 14.fSize,
        fontWeight: FontWeight.w300,
      );
  static get bodyMediumBluegray700 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.blueGray700,
        fontSize: 14.fSize,
      );
  static get bodyMediumGray600 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray600,
        fontSize: 14.fSize,
      );
  static get bodyMediumInterBluegray700 =>
      theme.textTheme.bodyMedium!.inter.copyWith(
        color: appTheme.blueGray700,
        fontSize: 14.fSize,
      );
  static get bodyMediumInterGray600 =>
      theme.textTheme.bodyMedium!.inter.copyWith(
        color: appTheme.gray600,
        fontSize: 14.fSize,
      );
  static get bodyMediumInterOnPrimaryContainer =>
      theme.textTheme.bodyMedium!.inter.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
        fontSize: 14.fSize,
      );
  static get bodyMediumLight => theme.textTheme.bodyMedium!.copyWith(
        fontSize: 14.fSize,
        fontWeight: FontWeight.w300,
      );
  static get bodyMediumOnErrorContainer => theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
        fontSize: 14.fSize,
      );
  static get bodyMediumff000000 => theme.textTheme.bodyMedium!.copyWith(
        color: Color(0XFF000000),
        fontSize: 14.fSize,
      );
  static get bodyMediumff004687 => theme.textTheme.bodyMedium!.copyWith(
        color: Color(0XFF004687),
        fontSize: 14.fSize,
      );
  static get bodySmallBluegray400 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.blueGray400,
        fontWeight: FontWeight.w400,
      );
  static get bodySmallGray600 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray600,
        fontWeight: FontWeight.w400,
      );
  static get bodySmallInterGray600 => theme.textTheme.bodySmall!.inter.copyWith(
        color: appTheme.gray600,
        fontWeight: FontWeight.w400,
      );
  static get bodySmallOnErrorContainer => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
        fontWeight: FontWeight.w400,
      );
  static get bodySmallSecondaryContainer => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.secondaryContainer,
        fontWeight: FontWeight.w400,
      );
  // Headline text style
  static get headlineLargeIndigo90001 =>
      theme.textTheme.headlineLarge!.copyWith(
        color: appTheme.indigo90001,
        fontSize: 30.fSize,
      );
  static get headlineLargeff0ebe7f => theme.textTheme.headlineLarge!.copyWith(
        color: Color(0XFF0EBE7F),
      );
  static get headlineLargeff1a1a1a => theme.textTheme.headlineLarge!.copyWith(
        color: Color(0XFF1A1A1A),
      );
  static get headlineMediumBlack900 => theme.textTheme.headlineMedium!.copyWith(
        color: appTheme.black900,
        fontSize: 26.fSize,
      );
  static get headlineMediumPrimary => theme.textTheme.headlineMedium!.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 26.fSize,
      );
  static get headlineSmallBlack900 => theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.black900,
        fontSize: 24.fSize,
      );
  static get headlineSmallIndigo90001 =>
      theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.indigo90001,
        fontSize: 24.fSize,
      );
  static get headlineSmallff000000 => theme.textTheme.headlineSmall!.copyWith(
        color: Color(0XFF000000),
        fontSize: 24.fSize,
      );
  static get headlineSmallff203772 => theme.textTheme.headlineSmall!.copyWith(
        color: Color(0XFF203772),
        fontSize: 24.fSize,
      );
  // Label text style
  static get labelLargeBluegray300 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.blueGray300,
      );
  static get labelLargeBluegray700 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.blueGray700,
        fontWeight: FontWeight.w700,
      );
  static get labelLargeGray600 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.gray600,
        fontWeight: FontWeight.w700,
      );
  static get labelLargeGray600_1 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.gray600,
      );
  static get labelLargeRubik => theme.textTheme.labelLarge!.rubik.copyWith(
        fontWeight: FontWeight.w500,
      );
  // Title text style
  static get titleLargeBlack900 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.black900,
      );
  static get titleLargeBluegray800 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.blueGray800,
      );
  static get titleLargeBluegray90001 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.blueGray90001,
      );
  static get titleLargeBluegray90002 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.blueGray90002,
      );
  static get titleLargeGray5001 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.gray5001,
        fontWeight: FontWeight.w300,
      );
  static get titleLargeInterBluegray800 =>
      theme.textTheme.titleLarge!.inter.copyWith(
        color: appTheme.blueGray800,
        fontWeight: FontWeight.w600,
      );
  static get titleLargeInterBluegray90002 =>
      theme.textTheme.titleLarge!.inter.copyWith(
        color: appTheme.blueGray90002,
        fontWeight: FontWeight.w600,
      );
  static get titleLargeInterOnErrorContainer =>
      theme.textTheme.titleLarge!.inter.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
        fontWeight: FontWeight.w600,
      );
  static get titleLargeOnErrorContainer => theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
        fontSize: 23.fSize,
      );
  static get titleLargeOnErrorContainerSemiBold =>
      theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
        fontWeight: FontWeight.w600,
      );
  static get titleLargeOnErrorContainer_1 =>
      theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
      );
  static get titleMediumBlack900 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w600,
      );
  static get titleMediumBlack90018 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
        fontSize: 18.fSize,
      );
  static get titleMediumBlack900SemiBold =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
        fontSize: 18.fSize,
        fontWeight: FontWeight.w600,
      );
  static get titleMediumBluegray500 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.blueGray500,
      );
  static get titleMediumBluegray500SemiBold =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.blueGray500,
        fontSize: 18.fSize,
        fontWeight: FontWeight.w600,
      );
  static get titleMediumBluegray800 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.blueGray800,
      );
  static get titleMediumBluegray90002 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.blueGray90002,
      );
  static get titleMediumBluegray90005 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.blueGray90005,
        fontSize: 18.fSize,
      );
  static get titleMediumBluegray9000518 =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.blueGray90005,
        fontSize: 16.fSize,
      );
  static get titleMediumGray600 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray600,
        fontWeight: FontWeight.w600,
      );
  static get titleMediumInterOnErrorContainer =>
      theme.textTheme.titleMedium!.inter.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
        fontWeight: FontWeight.w500,
      );
  static get titleMediumOnErrorContainer =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
        fontSize: 18.fSize,
      );
  static get titleMediumOnErrorContainer18 =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
        fontSize: 18.fSize,
      );
  static get titleMediumOnErrorContainerSemiBold =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
        fontSize: 18.fSize,
        fontWeight: FontWeight.w600,
      );
  static get titleMediumOnErrorContainerSemiBold18 =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
        fontSize: 18.fSize,
        fontWeight: FontWeight.w600,
      );
  static get titleMediumOnErrorContainerSemiBold_1 =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
        fontWeight: FontWeight.w600,
      );
  static get titleMediumOnErrorContainer_1 =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
      );
  static get titleMediumOnErrorContainer_2 =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
      );
  static get titleMediumOnPrimaryContainer =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
      );
  static get titleMediumOnSecondaryContainer =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onSecondaryContainer,
        fontSize: 18.fSize,
      );
  static get titleMediumPrimary => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 18.fSize,
      );
  static get titleMediumPrimaryContainer =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primaryContainer,
        fontSize: 18.fSize,
        fontWeight: FontWeight.w600,
      );
  static get titleMediumPrimary_1 => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get titleMediumPrimary_2 => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get titleMediumRubikBluegray90005 =>
      theme.textTheme.titleMedium!.rubik.copyWith(
        color: appTheme.blueGray90005,
        fontSize: 18.fSize,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumRubikBluegray90005Medium =>
      theme.textTheme.titleMedium!.rubik.copyWith(
        color: appTheme.blueGray90005,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumRubikOnErrorContainer =>
      theme.textTheme.titleMedium!.rubik.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
        fontSize: 18.fSize,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumTeal300 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.teal300,
        fontSize: 18.fSize,
      );
  static get titleMediumff0ebe7f => theme.textTheme.titleMedium!.copyWith(
        color: Color(0XFF0EBE7F),
        fontWeight: FontWeight.w600,
      );
  static get titleMediumff333333 => theme.textTheme.titleMedium!.copyWith(
        color: Color(0XFF333333),
        fontWeight: FontWeight.w500,
      );
  static get titleSmallBluegray700 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray700,
        fontWeight: FontWeight.w600,
      );
  static get titleSmallBluegray700_1 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray700,
      );
  static get titleSmallBluegray900 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray900,
      );
  static get titleSmallBluegray90002 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray90002,
      );
  static get titleSmallBluegray90003 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray90003,
      );
  static get titleSmallInterBluegray700 =>
      theme.textTheme.titleSmall!.inter.copyWith(
        color: appTheme.blueGray700,
        fontWeight: FontWeight.w600,
      );
  static get titleSmallInterOnErrorContainer =>
      theme.textTheme.titleSmall!.inter.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
        fontWeight: FontWeight.w600,
      );
  static get titleSmallMedium => theme.textTheme.titleSmall!.copyWith(
        fontWeight: FontWeight.w500,
      );
  static get titleSmallOnErrorContainer => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
      );
  static get titleSmallOnErrorContainerExtraBold =>
      theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
        fontWeight: FontWeight.w800,
      );
  static get titleSmallOnErrorContainerSemiBold =>
      theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
        fontWeight: FontWeight.w600,
      );
  static get titleSmallPrimary => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get titleSmallPrimarySemiBold => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w600,
      );
  static get titleSmallff0066ff => theme.textTheme.titleSmall!.copyWith(
        color: Color(0XFF0066FF),
      );
  static get titleSmallff0d921a => theme.textTheme.titleSmall!.copyWith(
        color: Color(0XFF0D921A),
      );
  static get titleSmallff4b5563 => theme.textTheme.titleSmall!.copyWith(
        color: Color(0XFF4B5563),
        fontWeight: FontWeight.w600,
      );
}

extension on TextStyle {
  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }

  TextStyle get rubik {
    return copyWith(
      fontFamily: 'Rubik',
    );
  }

  TextStyle get nunito {
    return copyWith(
      fontFamily: 'Nunito',
    );
  }
}
