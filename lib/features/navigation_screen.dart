import 'package:betterloop/features/challenges/challenges_screen.dart';
import 'package:betterloop/features/dashboard/dashboard_screen.dart';
import 'package:betterloop/features/dashboard/widgets/custom_bottom_bar.dart';
import 'package:betterloop/routes/route_names.dart';
import 'package:betterloop/widgets/buttons/app_buttons.dart';
import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key, this.fromOnboarding = false});
  final bool fromOnboarding;

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;
  bool updateAvailable = false;

  @override
  void initState() {
    checkForUpdate();
    super.initState();
  }

  void checkForUpdate() async {
    try {
      final info = await InAppUpdate.checkForUpdate();

      setState(() {
        updateAvailable =
            info.updateAvailability == UpdateAvailability.updateAvailable;
      });
    } catch (e) {
      print("Update check failed: $e");
    }
  }

  void _startUpdate() async {
    try {
      final info = await InAppUpdate.checkForUpdate();

      if (info.updateAvailability == UpdateAvailability.updateAvailable) {
        //  Immediate update
        InAppUpdate.performImmediateUpdate();
      }
    } catch (e) {
      print("Update check failed: $e");
    }
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 2:
        Navigator.pushNamed(context, RouteNames.statistics);
        return;
      case 3:
        Navigator.pushNamed(context, RouteNames.settings);
        return;
      default:
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  final pages = [
    DashboardScreen(),
    ChallengesScreen(),
    Container(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: updateAvailable
          ? PrimaryButton(
              isRounded: true,
              label: "Update available",
              isSmall: true,
              onPressed: _startUpdate,
            )
          : null,
      body: pages[_selectedIndex],
      bottomNavigationBar: CustomBottomBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
