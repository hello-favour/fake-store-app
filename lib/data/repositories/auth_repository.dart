import 'package:injectable/injectable.dart';
import '../datasources/remote/api_service.dart';
import '../datasources/local/local_storage_service.dart';

@lazySingleton
class AuthRepository {
  final ApiService _apiService;
  final LocalStorageService _localStorageService;

  AuthRepository(this._apiService, this._localStorageService);

  Future<String> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _apiService.login(
        username: username,
        password: password,
      );
      await _localStorageService.saveToken(response.token);
      return response.token;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    await _localStorageService.clearToken();
  }

  bool isLoggedIn() {
    return _localStorageService.getToken() != null;
  }

  String? getToken() {
    return _localStorageService.getToken();
  }
}
