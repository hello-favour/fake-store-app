import 'package:fake_store/data/models/cart_item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../data/repositories/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

@injectable
class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository _cartRepository;

  CartBloc(this._cartRepository) : super(CartInitial()) {
    on<LoadCart>(_onLoadCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateQuantity>(_onUpdateQuantity);
    on<ClearCart>(_onClearCart);
  }

  void _onLoadCart(LoadCart event, Emitter<CartState> emit) {
    final items = _cartRepository.getCartItems();
    final total = _cartRepository.getTotal();
    emit(CartLoaded(items: items, total: total));
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    _cartRepository.removeFromCart(event.productId);
    final items = _cartRepository.getCartItems();
    final total = _cartRepository.getTotal();
    emit(CartLoaded(items: items, total: total));
  }

  void _onUpdateQuantity(UpdateQuantity event, Emitter<CartState> emit) {
    _cartRepository.updateQuantity(event.productId, event.quantity);
    final items = _cartRepository.getCartItems();
    final total = _cartRepository.getTotal();
    emit(CartLoaded(items: items, total: total));
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    _cartRepository.clearCart();
    emit(const CartLoaded(items: [], total: 0));
  }
}
