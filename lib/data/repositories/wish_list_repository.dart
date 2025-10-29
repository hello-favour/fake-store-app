import 'package:injectable/injectable.dart';
import '../datasources/local/local_storage_service.dart';
import '../models/product_model.dart';

@lazySingleton
class WishlistRepository {
  final LocalStorageService _localStorageService;

  WishlistRepository(this._localStorageService);

  Future<List<ProductModel>> getWishlist() async {
    return await _localStorageService.getWishlist();
  }

  Future<void> addToWishlist(ProductModel product) async {
    await _localStorageService.addToWishlist(product);
  }

  Future<void> removeFromWishlist(int productId) async {
    await _localStorageService.removeFromWishlist(productId);
  }

  Future<bool> isInWishlist(int productId) async {
    return await _localStorageService.isInWishlist(productId);
  }
}
