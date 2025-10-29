part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCart extends CartEvent {}

class RemoveFromCart extends CartEvent {
  final int productId;

  const RemoveFromCart(this.productId);

  @override
  List<Object> get props => [productId];
}

class UpdateQuantity extends CartEvent {
  final int productId;
  final int quantity;

  const UpdateQuantity({required this.productId, required this.quantity});

  @override
  List<Object> get props => [productId, quantity];
}

class ClearCart extends CartEvent {}
