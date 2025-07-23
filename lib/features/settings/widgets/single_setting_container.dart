import 'package:betterloop/widgets/app_card.dart';
import 'package:flutter/material.dart';

class SingleSettingContainer extends StatelessWidget {
  const SingleSettingContainer({
    super.key,
    required this.icondata,
    required this.title,
    this.rightContent,
    this.onTap,
  });

  final IconData icondata;
  final String title;
  final Widget? rightContent;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppCard(
      boxShadow: false,
      borderRadius: false,
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Center(
                child: Icon(icondata, size: 30),
              ),
              SizedBox(width: 20),
              Text(
                title,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          rightContent ?? Container(),
        ],
      ),
    );
  }
}
