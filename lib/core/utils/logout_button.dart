import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fake_store/core/theme/app_colors.dart';
import 'package:fake_store/gen/assets.gen.dart';
import 'package:fake_store/core/di/injection.dart';
import 'package:fake_store/presentation/pages/login/auth_bloc.dart';
import 'package:go_router/go_router.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        backgroundColor: AppColors.colorWhite,
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              getIt<AuthBloc>().add(LogoutRequested());
              context.go('/');
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: AppColors.colorYellow,
            shape: BoxShape.circle,
          ),
          child: GestureDetector(
            onTap: () => _handleLogout(context),
            child: SvgPicture.asset(
              Assets.svg.logout,
              width: 16,
              height: 16,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
        Text(
          'Log out',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
        ),
      ],
    );
  }
}
