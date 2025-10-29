import 'package:injectable/injectable.dart';
import '../datasources/remote/api_service.dart';
import '../models/user_model.dart';

@lazySingleton
class UserRepository {
  final ApiService _apiService;

  UserRepository(this._apiService);

  Future<UserModel> getUserById(int id) async {
    try {
      return await _apiService.getUserById(id);
    } catch (e) {
      rethrow;
    }
  }
}
