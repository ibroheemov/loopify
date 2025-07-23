import 'package:betterloop/features/custom_habit/providers/habit_color_provider.dart';
import 'package:betterloop/theme/spacing.dart';
import 'package:betterloop/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final colorss = [
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
    selectedColor = colorss[0];
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
              ...colorss.map(
                (color) {
                  Color parsedColor = parseColor(color);

                  final isSelected = selectedColor == color;
                  return GestureDetector(
                    onTap: () => _onTapColor(color),
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
                },
              ).toList(),
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
    return Color(colorValue).withOpacity(1.0);
  }
}
