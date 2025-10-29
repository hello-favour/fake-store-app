import 'package:fake_store/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

void showToastAlert(String message, {bool isSuccess = true}) {
  showToastWidget(
    Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isSuccess ? AppColors.colorYellow : AppColors.colorDelete,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.colorBlack.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSuccess ? Icons.check_circle : Icons.error,
            color: isSuccess ? AppColors.colorBlack : AppColors.colorWhite,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: isSuccess ? AppColors.colorBlack : AppColors.colorWhite,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    ),
    duration: const Duration(seconds: 4),
    position: ToastPosition.top,
  );
}
