import 'package:betterloop/features/custom_habit/providers/habit_color_provider.dart';
import 'package:betterloop/providers/pro_user_provider.dart';
import 'package:betterloop/routes/route_names.dart';
import 'package:betterloop/theme/spacing.dart';
import 'package:betterloop/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppColor {
  final String value;
  final bool isPremium;

  AppColor({required this.value, this.isPremium = false});
}

final app_colors = [
  AppColor(value: "1B8FFF"),
  AppColor(value: "10C580"),
  AppColor(value: "F8BD33"),
  AppColor(value: "933DFF", isPremium: true),
  AppColor(value: "FE7450", isPremium: true),
  AppColor(value: "F63466", isPremium: true),
];

class ChooseColor extends ConsumerStatefulWidget {
  const ChooseColor({super.key});

  @override
  ConsumerState<ChooseColor> createState() => _ChooseColorState();
}

class _ChooseColorState extends ConsumerState<ChooseColor> {
  late String selectedColor;

  @override
  void initState() {
    selectedColor = app_colors.first.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: SizedBox(
        width: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: GridView.count(
            childAspectRatio: 1.2,
            padding: const EdgeInsets.all(0),
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: AppSpacing.sm_md,
            shrinkWrap: true,
            crossAxisCount: 6,
            children: [
              ...app_colors.map(
                (color) {
                  Color parsedColor = parseColor(color.value);

                  final isSelected = selectedColor == color.value;
                  return Consumer(builder: (context, ref, _) {
                    final isProAsync = ref.watch(isProUserProvider);
                    final isPro = isProAsync.hasValue && isProAsync.value!;
                    // final isPro = true;

                    return GestureDetector(
                      onTap: () => _onTapColor(color, isPro),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // borderRadius: BorderRadius.circular(12),
                          color: parsedColor,
                        ),
                        padding: EdgeInsets.all(AppSpacing.sm_md),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSelected
                                ? Colors.white
                                : Colors.white.withOpacity(0.3),
                          ),
                        ),
                      ),
                    );
                  });
                },
              ).toList(),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapColor(AppColor color, bool isPro) async {
    setState(() {
      ref.read(habitColorProvider.notifier).state = color.value;
      selectedColor = color.value;
    });
    await Future.delayed(Duration(milliseconds: 500));
    if (color.isPremium && !isPro) {
      setState(() {
        selectedColor = app_colors.first.value;
        ref.read(habitColorProvider.notifier).state = selectedColor;
      });
      Navigator.pushNamed(context, RouteNames.paywall);
    }
  }

  static Color parseColor(String colorString) {
    colorString = colorString.replaceAll('#', '');
    int colorValue = int.parse(colorString, radix: 16);
    return Color(colorValue).withOpacity(1.0);
  }
}
