// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../data/datasources/local/local_storage_service.dart' as _i373;
import '../../data/datasources/local/user_local_data_source.dart' as _i460;
import '../../data/datasources/remote/api_service.dart' as _i906;
import '../../data/repositories/auth_repository.dart' as _i481;
import '../../data/repositories/cart_repository.dart' as _i865;
import '../../data/repositories/product_repository.dart' as _i358;
import '../../data/repositories/user_repository.dart' as _i517;
import '../../data/repositories/wish_list_repository.dart' as _i1037;
import '../../presentation/pages/cart/cart_bloc.dart' as _i230;
import '../../presentation/pages/login/auth_bloc.dart' as _i2;
import '../../presentation/pages/products/product_bloc.dart' as _i886;
import '../../presentation/pages/user/user_bloc.dart' as _i726;
import '../../presentation/pages/wishlist/wishlist_bloc.dart' as _i183;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i906.ApiService>(() => _i906.ApiService());
    gh.lazySingleton<_i865.CartRepository>(() => _i865.CartRepository());
    gh.lazySingleton<_i373.LocalStorageService>(
      () => _i373.LocalStorageService(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i460.UserLocalDataSource>(
      () => _i460.UserLocalDataSource(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i1037.WishlistRepository>(
      () => _i1037.WishlistRepository(gh<_i373.LocalStorageService>()),
    );
    gh.factory<_i230.CartBloc>(
      () => _i230.CartBloc(gh<_i865.CartRepository>()),
    );
    gh.lazySingleton<_i358.ProductRepository>(
      () => _i358.ProductRepository(gh<_i906.ApiService>()),
    );
    gh.lazySingleton<_i481.AuthRepository>(
      () => _i481.AuthRepository(
        gh<_i906.ApiService>(),
        gh<_i373.LocalStorageService>(),
      ),
    );
    gh.factory<_i183.WishlistBloc>(
      () => _i183.WishlistBloc(
        gh<_i1037.WishlistRepository>(),
        gh<_i865.CartRepository>(),
      ),
    );
    gh.lazySingleton<_i517.UserRepository>(
      () => _i517.UserRepository(
        gh<_i906.ApiService>(),
        gh<_i460.UserLocalDataSource>(),
      ),
    );
    gh.factory<_i2.AuthBloc>(
      () =>
          _i2.AuthBloc(gh<_i481.AuthRepository>(), gh<_i517.UserRepository>()),
    );
    gh.factory<_i886.ProductBloc>(
      () => _i886.ProductBloc(
        gh<_i358.ProductRepository>(),
        gh<_i865.CartRepository>(),
        gh<_i1037.WishlistRepository>(),
      ),
    );
    gh.factory<_i726.UserBloc>(
      () => _i726.UserBloc(gh<_i517.UserRepository>()),
    );
    return this;
  }
}
