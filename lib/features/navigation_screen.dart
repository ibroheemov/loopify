import 'package:betterloop/features/dashboard/dashboard_screen.dart';
import 'package:betterloop/features/dashboard/widgets/custom_bottom_bar.dart';
import 'package:betterloop/routes/route_names.dart';
import 'package:flutter/material.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;

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
    Container(),
    Container(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: CustomBottomBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
