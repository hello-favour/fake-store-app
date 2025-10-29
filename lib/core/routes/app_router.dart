import 'package:fake_store/data/repositories/auth_repository.dart';
import 'package:fake_store/presentation/pages/cart/cart_bloc.dart';
import 'package:fake_store/presentation/pages/cart/cart_page.dart';
import 'package:fake_store/presentation/pages/login/auth_bloc.dart';
import 'package:fake_store/presentation/pages/login/get_started_page.dart';
import 'package:fake_store/presentation/pages/login/login_page.dart';
import 'package:fake_store/presentation/pages/products/product_bloc.dart';
import 'package:fake_store/presentation/pages/products/product_detail_page.dart';
import 'package:fake_store/presentation/pages/products/product_page.dart';
import 'package:fake_store/presentation/pages/user/user_bloc.dart';
import 'package:fake_store/presentation/pages/wishlist/wishlist_bloc.dart';
import 'package:fake_store/presentation/pages/wishlist/wishlist_page.dart';
import 'package:fake_store/presentation/widgets/main_scaffold.dart';
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

    ShellRoute(
      builder: (context, state, child) {
        int currentIndex = 0;
        final location = state.matchedLocation;

        if (location.startsWith('/wishlist')) {
          currentIndex = 1;
        } else if (location.startsWith('/cart')) {
          currentIndex = 2;
        } else if (location.startsWith('/products')) {
          currentIndex = 0;
        }

        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt<UserBloc>()),
            BlocProvider(create: (context) => getIt<ProductBloc>()),
            BlocProvider(create: (context) => getIt<CartBloc>()),
            BlocProvider(create: (context) => getIt<WishlistBloc>()),
          ],
          child: MainScaffold(currentIndex: currentIndex, child: child),
        );
      },
      routes: [
        GoRoute(
          path: '/products',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: ProductPage()),
        ),
        GoRoute(
          path: '/wishlist',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: WishlistPage()),
        ),
        GoRoute(
          path: '/cart',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: CartPage()),
        ),
      ],
    ),
    GoRoute(
      path: '/product-detail/:id',
      builder: (context, state) {
        final productId = int.parse(state.pathParameters['id']!);
        return BlocProvider(
          create: (context) => getIt<ProductBloc>(),
          child: ProductDetailPage(productId: productId.toString()),
        );
      },
    ),
  ],
);
