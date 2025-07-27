import 'package:betterloop/constants/general_icons.dart';
import 'package:betterloop/routes/route_names.dart';
import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({
    super.key,
    required this.onItemTapped,
    required this.selectedIndex,
  });
  final void Function(int) onItemTapped;
  final int selectedIndex;

  static final List<IconData> icons = [
    GeneralIcons.betterloop,
    Icons.bubble_chart_outlined,
    Icons.menu_book_outlined,
    GeneralIcons.settings_outline,
  ];

  static final List<String> labels = [
    "Habits",
    "Challenges",
    "Statistics",
    "Settings",
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        BottomAppBar(
            height: 65,
            elevation: 10,
            color: Theme.of(context).colorScheme.surface,
            child: Container()),
        Positioned(
          child: Container(
            height: 60,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(),
            child: OverflowBox(
              maxHeight: 90,
              child: SizedBox(
                height: 90,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(5, (index) {
                    if (index == 2) {
                      return IconButton.filled(
                        onPressed: () {
                          Navigator.pushNamed(context, RouteNames.customHabit);
                        },
                        icon: Icon(Icons.add, size: 30),
                      ); // space for FAB
                    }

                    return Container(
                      width: 70,
                      height: 90,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Material(
                        child: InkWell(
                          onTap: () =>
                              onItemTapped(index > 1 ? index - 1 : index),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                icons[index > 1 ? index - 1 : index],
                                color: selectedIndex ==
                                        (index > 1 ? index - 1 : index)
                                    ? colorScheme.primary
                                    : Colors.grey,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                labels[index > 1 ? index - 1 : index],
                                style: TextStyle(
                                  color: selectedIndex ==
                                          (index > 1 ? index - 1 : index)
                                      ? colorScheme.primary
                                      : Colors.grey,
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
