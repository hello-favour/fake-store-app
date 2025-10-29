import 'package:fake_store/data/models/cart_item_model.dart';
import 'package:injectable/injectable.dart';
import '../models/product_model.dart';

@lazySingleton
class CartRepository {
  final List<CartItemModel> _cartItems = [];

  List<CartItemModel> getCartItems() {
    return List.unmodifiable(_cartItems);
  }

  void addToCart(ProductModel product) {
    final existingIndex = _cartItems.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingIndex != -1) {
      _cartItems[existingIndex] = _cartItems[existingIndex].copyWith(
        quantity: _cartItems[existingIndex].quantity + 1,
      );
    } else {
      _cartItems.add(CartItemModel(product: product, quantity: 1));
    }
  }

  void removeFromCart(int productId) {
    _cartItems.removeWhere((item) => item.product.id == productId);
  }

  void updateQuantity(int productId, int quantity) {
    final index = _cartItems.indexWhere((item) => item.product.id == productId);
    if (index != -1) {
      if (quantity <= 0) {
        removeFromCart(productId);
      } else {
        _cartItems[index] = _cartItems[index].copyWith(quantity: quantity);
      }
    }
  }

  void clearCart() {
    _cartItems.clear();
  }

  double getTotal() {
    return _cartItems.fold(0, (sum, item) => sum + item.totalPrice);
  }

  int getItemCount() {
    return _cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  bool isInCart(int productId) {
    return _cartItems.any((item) => item.product.id == productId);
  }
}
