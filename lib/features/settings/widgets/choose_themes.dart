import 'package:betterloop/constants/general_icons.dart';
import 'package:betterloop/features/settings/providers/theme_provider.dart';
import 'package:betterloop/theme/colors.dart';
import 'package:betterloop/theme/spacing.dart';
import 'package:betterloop/utils/extensions.dart';
import 'package:betterloop/utils/theme_extension.dart';
import 'package:betterloop/widgets/app_card.dart';
import 'package:betterloop/widgets/app_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChooseThemes extends ConsumerWidget {
  const ChooseThemes({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final currentTheme = ref.watch(themeProvider);

    return AppContainer(
      child: Column(
        children: [
          ...AppThemeMode.values.map(
            (e) => AppCard(
                onTap: () {
                  ref.read(themeProvider.notifier).setMode(e);
                },
                margin: EdgeInsets.only(bottom: AppSpacing.smMd),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(e.name.capitalize(), style: textTheme.titleMedium),
                    Icon(
                      currentTheme.name == e.name
                          ? GeneralIcons.checkCircleBold
                          : GeneralIcons.circleOutline,
                      size: 30,
                      color: currentTheme.name == e.name
                          ? colorScheme.primary
                          : AppColors.of(context).surfaceSecondary,
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
