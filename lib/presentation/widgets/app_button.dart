import 'package:flutter/material.dart';
import 'package:fake_store/core/theme/app_colors.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final double height;
  final double borderRadius;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.height = 56,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary
              ? AppColors.colorYellow
              : AppColors.colorWhite,
          foregroundColor: isPrimary
              ? AppColors.colorBlack
              : AppColors.colorGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: isPrimary
                ? BorderSide.none
                : const BorderSide(color: AppColors.colorGrey),
          ),
          textStyle: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
