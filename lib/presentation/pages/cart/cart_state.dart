part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoaded extends CartState {
  final List<CartItemModel> items;
  final double total;

  const CartLoaded({required this.items, required this.total});

  @override
  List<Object> get props => [items, total];
}
