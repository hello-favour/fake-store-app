import 'package:fake_store/app.dart';
import 'package:flutter/material.dart';
import 'core/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}
