import 'package:flutter/cupertino.dart';

class SpinnerView extends StatelessWidget {
  const SpinnerView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CupertinoActivityIndicator(radius: 20));
  }
}
