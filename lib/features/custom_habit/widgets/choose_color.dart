import 'package:betterloop/features/custom_habit/providers/habit_color_provider.dart';
import 'package:betterloop/theme/spacing.dart';
import 'package:betterloop/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appColors = [
  "1B8FFF",
  "10C580",
  "F8BD33",
  "933DFF",
  "FE7450",
  "F63466",
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
    selectedColor = appColors.first;
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
            crossAxisSpacing: AppSpacing.smMd,
            shrinkWrap: true,
            crossAxisCount: 6,
            children: [
              ...appColors.map(
                (color) {
                  Color parsedColor = parseColor(color);

                  final isSelected = selectedColor == color;
                  return GestureDetector(
                    onTap: () => _onTapColor(color),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: parsedColor,
                      ),
                      padding: EdgeInsets.all(AppSpacing.smMd),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.3),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapColor(String color) {
    setState(() {
      ref.read(habitColorProvider.notifier).state = color;
      selectedColor = color;
    });
  }

  static Color parseColor(String colorString) {
    colorString = colorString.replaceAll('#', '');
    int colorValue = int.parse(colorString, radix: 16);
    return Color(colorValue).withValues(alpha: 1.0);
  }
}
