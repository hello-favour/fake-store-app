import 'package:fake_store/presentation/pages/login/auth_bloc.dart';
import 'package:fake_store/presentation/pages/products/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fake_store/app.dart';
import 'package:fake_store/core/di/injection.dart';
import 'package:fake_store/presentation/pages/user/user_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(create: (context) => getIt<UserBloc>()),
        BlocProvider<AuthBloc>(create: (context) => getIt<AuthBloc>()),
        BlocProvider<ProductBloc>(create: (context) => getIt<ProductBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}
