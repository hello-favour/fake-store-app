part of 'wishlist_bloc.dart';

abstract class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

class LoadWishlist extends WishlistEvent {}

class RemoveFromWishlist extends WishlistEvent {
  final int productId;

  const RemoveFromWishlist(this.productId);

  @override
  List<Object> get props => [productId];
}

class AddToCartFromWishlist extends WishlistEvent {
  final ProductModel product;

  const AddToCartFromWishlist(this.product);

  @override
  List<Object> get props => [product];
}
