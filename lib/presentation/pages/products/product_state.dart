part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductModel> products;
  final Set<int> wishlistProductIds;

  const ProductLoaded({
    required this.products,
    this.wishlistProductIds = const {},
  });

  ProductLoaded copyWith({
    List<ProductModel>? products,
    Set<int>? wishlistProductIds,
  }) {
    return ProductLoaded(
      products: products ?? this.products,
      wishlistProductIds: wishlistProductIds ?? this.wishlistProductIds,
    );
  }

  @override
  List<Object> get props => [products, wishlistProductIds];
}

class ProductDetailLoading extends ProductState {}

class ProductDetailLoaded extends ProductState {
  final ProductModel product;
  final bool isInWishlist;
  final bool isInCart;

  const ProductDetailLoaded({
    required this.product,
    required this.isInWishlist,
    required this.isInCart,
  });

  ProductDetailLoaded copyWith({
    ProductModel? product,
    bool? isInWishlist,
    bool? isInCart,
  }) {
    return ProductDetailLoaded(
      product: product ?? this.product,
      isInWishlist: isInWishlist ?? this.isInWishlist,
      isInCart: isInCart ?? this.isInCart,
    );
  }

  @override
  List<Object> get props => [product, isInWishlist, isInCart];
}

class ProductError extends ProductState {
  final String message;

  const ProductError({required this.message});

  @override
  List<Object> get props => [message];
}
