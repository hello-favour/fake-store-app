import 'package:dio/dio.dart';
import 'package:fake_store/data/models/login_response.dart';
import 'package:fake_store/data/models/product_model.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../../../core/constants/api_constants.dart';

@lazySingleton
class ApiService {
  late final Dio _dio;

  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
      ),
    );
  }

  Future<LoginResponse> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.login,
        data: {'username': username, 'password': password},
      );
      return LoginResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await _dio.get(ApiConstants.products);
      return (response.data as List)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<ProductModel> getProductById(int id) async {
    try {
      final response = await _dio.get(ApiConstants.productDetail(id));
      return ProductModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
