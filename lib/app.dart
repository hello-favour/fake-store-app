import 'package:fake_store/core/routes/app_router.dart';
import 'package:fake_store/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp.router(
        useInheritedMediaQuery: true,
        debugShowCheckedModeBanner: false,
        title: 'Fake Store',
        theme: AppTheme.lightTheme,
        routerConfig: appRouter,
      ),
    );
  }
}
