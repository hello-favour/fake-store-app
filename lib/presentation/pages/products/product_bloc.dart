import 'package:fake_store/data/repositories/wish_list_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../data/models/product_model.dart';
import '../../../data/repositories/product_repository.dart';
import '../../../data/repositories/cart_repository.dart';
part 'product_event.dart';
part 'product_state.dart';

@injectable
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;
  final CartRepository _cartRepository;
  final WishlistRepository _wishlistRepository;

  ProductBloc(
    this._productRepository,
    this._cartRepository,
    this._wishlistRepository,
  ) : super(ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<LoadProductDetail>(_onLoadProductDetail);
    on<AddToCart>(_onAddToCart);
    on<ToggleWishlist>(_onToggleWishlist);
  }

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final products = await _productRepository.getProducts();
      final wishlistIds = <int>{};

      for (var product in products) {
        if (await _wishlistRepository.isInWishlist(product.id)) {
          wishlistIds.add(product.id);
        }
      }

      emit(ProductLoaded(products: products, wishlistProductIds: wishlistIds));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  Future<void> _onLoadProductDetail(
    LoadProductDetail event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductDetailLoading());
    try {
      final product = await _productRepository.getProductById(event.productId);
      final isInWishlist = await _wishlistRepository.isInWishlist(product.id);
      final isInCart = _cartRepository.isInCart(product.id);

      emit(
        ProductDetailLoaded(
          product: product,
          isInWishlist: isInWishlist,
          isInCart: isInCart,
        ),
      );
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  Future<void> _onAddToCart(AddToCart event, Emitter<ProductState> emit) async {
    _cartRepository.addToCart(event.product);

    if (state is ProductDetailLoaded) {
      final currentState = state as ProductDetailLoaded;
      emit(currentState.copyWith(isInCart: true));
    }
  }

  Future<void> _onToggleWishlist(
    ToggleWishlist event,
    Emitter<ProductState> emit,
  ) async {
    final isInWishlist = await _wishlistRepository.isInWishlist(
      event.product.id,
    );

    if (isInWishlist) {
      await _wishlistRepository.removeFromWishlist(event.product.id);
    } else {
      await _wishlistRepository.addToWishlist(event.product);
    }

    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      final updatedWishlist = Set<int>.from(currentState.wishlistProductIds);

      if (isInWishlist) {
        updatedWishlist.remove(event.product.id);
      } else {
        updatedWishlist.add(event.product.id);
      }

      emit(currentState.copyWith(wishlistProductIds: updatedWishlist));
    } else if (state is ProductDetailLoaded) {
      final currentState = state as ProductDetailLoaded;
      emit(currentState.copyWith(isInWishlist: !isInWishlist));
    }
  }
}
