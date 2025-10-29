part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class LoadProducts extends ProductEvent {}

class LoadProductDetail extends ProductEvent {
  final int productId;

  const LoadProductDetail(this.productId);

  @override
  List<Object> get props => [productId];
}

class AddToCart extends ProductEvent {
  final ProductModel product;

  const AddToCart(this.product);

  @override
  List<Object> get props => [product];
}

class ToggleWishlist extends ProductEvent {
  final ProductModel product;

  const ToggleWishlist(this.product);

  @override
  List<Object> get props => [product];
}
