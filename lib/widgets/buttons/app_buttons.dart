import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final IconData? icon;
  final bool isRounded;
  final bool isSmall;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isRounded = false,
    this.isSmall = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      // width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        icon: icon != null ? Icon(icon) : const SizedBox.shrink(),
        style: ElevatedButton.styleFrom(
          backgroundColor: color.primary,
          foregroundColor: color.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(isRounded ? 100 : 18),
          ),
        ),
        label: isLoading
            ? const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              )
            : Text(label,
                style: isSmall
                    ? textTheme.titleMedium
                    : textTheme.titleLarge?.copyWith(color: Colors.white)),
        onPressed: isLoading ? null : onPressed,
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const SecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      // width: double.infinity,
      height: 52,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: color.primary,
          side: BorderSide(color: color.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Text(label, style: textTheme.titleMedium),
      ),
    );
  }
}

class TextButtonLink extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const TextButtonLink({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(color: color.primary),
      ),
    );
  }
}
