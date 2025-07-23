import 'package:flutter/material.dart';

class _ControlledExpansionTile extends StatelessWidget {
  final Widget title;
  final List<Widget> children;
  final bool isExpanded;
  final VoidCallback onTap;

  const _ControlledExpansionTile({
    required this.title,
    required this.children,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: title,
          trailing: Icon(
            isExpanded ? Icons.expand_less : Icons.expand_more,
          ),
          onTap: onTap,
        ),
        if (isExpanded) ...children,
      ],
    );
  }
}
