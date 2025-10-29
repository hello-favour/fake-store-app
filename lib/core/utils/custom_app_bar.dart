import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:fake_store/core/theme/app_colors.dart';
import 'logout_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? subtitle;
  final bool showBackButton;

  const CustomAppBar({
    super.key,
    this.title,
    this.subtitle,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.colorWhite,
      surfaceTintColor: AppColors.colorWhite,
      automaticallyImplyLeading: showBackButton,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Text(
              title!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          if (subtitle != null) subtitle!,
        ],
      ),
      actions: const [LogoutButton(), Gap(16)],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 8);
}
