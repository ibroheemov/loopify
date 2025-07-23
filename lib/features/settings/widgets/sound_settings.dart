import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SoundSettings extends StatefulWidget {
  const SoundSettings({super.key});

  @override
  State<SoundSettings> createState() => _SoundSettingsState();
}

class _SoundSettingsState extends State<SoundSettings> {
  bool darkMode = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Center(
                child: Icon(
                  Icons.volume_up,
                  size: 30,
                ),
              ),
              SizedBox(width: 20),
              Text(
                "Sound",
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
