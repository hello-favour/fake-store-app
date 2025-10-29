import 'package:injectable/injectable.dart';
import '../datasources/remote/api_service.dart';
import '../datasources/local/user_local_data_source.dart';
import '../models/user_model.dart';

@lazySingleton
class UserRepository {
  final ApiService _apiService;
  final UserLocalDataSource _localDataSource;

  UserRepository(this._apiService, this._localDataSource);

  Future<UserModel> getUser(int id) async {
    try {
      final cachedUser = _localDataSource.getUser();
      if (cachedUser != null && cachedUser.id == id) {
        return cachedUser;
      }

      final user = await _apiService.getUserById(id);
      await _localDataSource.saveUser(user);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> refreshUser(int id) async {
    try {
      final user = await _apiService.getUserById(id);
      await _localDataSource.saveUser(user);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  UserModel? getCachedUser() {
    return _localDataSource.getUser();
  }

  int? getSavedUserId() {
    return _localDataSource.getUserId();
  }

  Future<void> clearUser() async {
    await _localDataSource.clearUser();
  }
}
