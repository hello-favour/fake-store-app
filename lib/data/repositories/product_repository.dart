import 'package:injectable/injectable.dart';
import '../datasources/remote/api_service.dart';
import '../models/product_model.dart';

@lazySingleton
class ProductRepository {
  final ApiService _apiService;

  ProductRepository(this._apiService);

  Future<List<ProductModel>> getProducts() async {
    try {
      return await _apiService.getProducts();
    } catch (e) {
      rethrow;
    }
  }

  Future<ProductModel> getProductById(int id) async {
    try {
      return await _apiService.getProductById(id);
    } catch (e) {
      rethrow;
    }
  }
}
