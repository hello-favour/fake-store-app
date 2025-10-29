import 'package:fake_store/data/repositories/auth_repository.dart';
import 'package:fake_store/presentation/pages/cart/cart_bloc.dart';
import 'package:fake_store/presentation/pages/cart/cart_page.dart';
import 'package:fake_store/presentation/pages/login/auth_bloc.dart';
import 'package:fake_store/presentation/pages/login/get_started_page.dart';
import 'package:fake_store/presentation/pages/login/login_page.dart';
import 'package:fake_store/presentation/pages/products/product_bloc.dart';
import 'package:fake_store/presentation/pages/products/product_detail_page.dart';
import 'package:fake_store/presentation/pages/products/product_page.dart';
import 'package:fake_store/presentation/pages/wishlist/wishlist_bloc.dart';
import 'package:fake_store/presentation/pages/wishlist/wishlist_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../di/injection.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  redirect: (context, state) {
    final authRepo = getIt<AuthRepository>();
    final isLoggedIn = authRepo.isLoggedIn();
    final isOnGetStarted = state.matchedLocation == '/';
    final isOnLogin = state.matchedLocation == '/login';

    // If logged in and trying to access get started or login, redirect to products
    if (isLoggedIn && (isOnGetStarted || isOnLogin)) {
      return '/products';
    }

    if (!isLoggedIn && !isOnGetStarted && !isOnLogin) {
      return '/';
    }

    return null;
  },
  routes: [
    GoRoute(path: '/', builder: (context, state) => const GetStartedPage()),
    GoRoute(
      path: '/login',
      builder: (context, state) => BlocProvider(
        create: (context) => getIt<AuthBloc>(),
        child: const LoginPage(),
      ),
    ),
    GoRoute(
      path: '/products',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt<ProductBloc>()),
          BlocProvider(create: (context) => getIt<CartBloc>()),
        ],
        child: const ProductPage(),
      ),
    ),
    GoRoute(
      path: '/product-detail/:id',
      builder: (context, state) {
        final productId = state.pathParameters['id']!;
        return BlocProvider(
          create: (context) => getIt<ProductBloc>(),
          child: ProductDetailPage(productId: productId),
        );
      },
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) => BlocProvider(
        create: (context) => getIt<CartBloc>(),
        child: const CartPage(),
      ),
    ),
    GoRoute(
      path: '/wishlist',
      builder: (context, state) => BlocProvider(
        create: (context) => getIt<WishlistBloc>(),
        child: const WishlistPage(),
      ),
    ),
  ],
);
