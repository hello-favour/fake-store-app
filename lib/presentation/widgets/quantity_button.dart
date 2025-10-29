import 'package:flutter/material.dart';

class QuantityButton extends StatelessWidget {
  final IconData? icon;
  final VoidCallback? onPressed;
  final Widget? child;

  const QuantityButton({super.key, this.icon, this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 35,
      padding: const EdgeInsets.all(4),
      constraints: const BoxConstraints(),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(4),
      ),
      alignment: Alignment.center,
      child: Center(
        child: GestureDetector(
          onTap: onPressed,
          behavior: HitTestBehavior.opaque,
          child: child ?? Icon(icon ?? Icons.add, size: 16),
        ),
      ),
    );
  }
}
