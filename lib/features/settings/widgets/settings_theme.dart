import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:apexhabit/presentation/bloc/theme_cubit.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsTheme extends StatefulWidget {
  const SettingsTheme({super.key});

  @override
  State<SettingsTheme> createState() => _SettingsThemeState();
}

class _SettingsThemeState extends State<SettingsTheme> {
  bool darkMode = true;

  @override
  void initState() {
    // final themeMode = context.read<ThemeCubit>().state;
    // darkMode = themeMode == ThemeMode.dark;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.dark_mode,
                size: 30,
              ),
              SizedBox(width: 20),
              Text(
                "Dark mode",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          CupertinoSwitch(
            value: darkMode,
            onChanged: (_) {
              // final themeCubit = context.read<ThemeCubit>();
              // themeCubit.setTheme();
              setState(() {
                darkMode = !darkMode;
              });
            },
          ),
        ],
      ),
    );
  }
}
