import 'package:fake_store/data/repositories/wish_list_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../data/models/product_model.dart';
import '../../../data/repositories/cart_repository.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

@injectable
class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final WishlistRepository _wishlistRepository;
  final CartRepository _cartRepository;

  WishlistBloc(this._wishlistRepository, this._cartRepository)
    : super(WishlistInitial()) {
    on<LoadWishlist>(_onLoadWishlist);
    on<RemoveFromWishlist>(_onRemoveFromWishlist);
    on<AddToCartFromWishlist>(_onAddToCartFromWishlist);
  }

  Future<void> _onLoadWishlist(
    LoadWishlist event,
    Emitter<WishlistState> emit,
  ) async {
    emit(WishlistLoading());
    try {
      final products = await _wishlistRepository.getWishlist();
      emit(WishlistLoaded(products: products));
    } catch (e) {
      emit(WishlistError(message: e.toString()));
    }
  }

  Future<void> _onRemoveFromWishlist(
    RemoveFromWishlist event,
    Emitter<WishlistState> emit,
  ) async {
    if (state is WishlistLoaded) {
      await _wishlistRepository.removeFromWishlist(event.productId);
      final products = await _wishlistRepository.getWishlist();
      emit(WishlistLoaded(products: products));
    }
  }

  Future<void> _onAddToCartFromWishlist(
    AddToCartFromWishlist event,
    Emitter<WishlistState> emit,
  ) async {
    _cartRepository.addToCart(event.product);
  }
}
