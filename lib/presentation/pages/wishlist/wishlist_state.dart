part of 'wishlist_bloc.dart';

abstract class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object> get props => [];
}

class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final List<ProductModel> products;

  const WishlistLoaded({required this.products});

  @override
  List<Object> get props => [products];
}

class WishlistError extends WishlistState {
  final String message;

  const WishlistError({required this.message});

  @override
  List<Object> get props => [message];
}
