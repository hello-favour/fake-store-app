import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/product_model.dart';

@lazySingleton
class LocalStorageService {
  static const String _wishlistKey = 'wishlist';
  static const String _tokenKey = 'auth_token';

  final SharedPreferences _prefs;

  LocalStorageService(this._prefs);

  Future<List<ProductModel>> getWishlist() async {
    try {
      final wishlistJson = _prefs.getString(_wishlistKey);
      if (wishlistJson == null) return [];

      final List<dynamic> decoded = json.decode(wishlistJson);
      return decoded.map((item) => ProductModel.fromJson(item)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<bool> saveWishlist(List<ProductModel> products) async {
    try {
      final encoded = json.encode(products.map((p) => p.toJson()).toList());
      return await _prefs.setString(_wishlistKey, encoded);
    } catch (e) {
      return false;
    }
  }

  Future<bool> addToWishlist(ProductModel product) async {
    final wishlist = await getWishlist();
    if (!wishlist.any((p) => p.id == product.id)) {
      wishlist.add(product);
      return await saveWishlist(wishlist);
    }
    return true;
  }

  Future<bool> removeFromWishlist(int productId) async {
    final wishlist = await getWishlist();
    wishlist.removeWhere((p) => p.id == productId);
    return await saveWishlist(wishlist);
  }

  Future<bool> isInWishlist(int productId) async {
    final wishlist = await getWishlist();
    return wishlist.any((p) => p.id == productId);
  }

  Future<bool> saveToken(String token) async {
    return await _prefs.setString(_tokenKey, token);
  }

  String? getToken() {
    return _prefs.getString(_tokenKey);
  }

  Future<bool> clearToken() async {
    return await _prefs.remove(_tokenKey);
  }
}
