import '../services/api_service.dart';
import '../services/storage_service.dart';
import '../models/user.dart';

class AuthRepository {
  final ApiService _apiService;
  final StorageService _storageService;

  AuthRepository({
    required ApiService apiService,
    required StorageService storageService,
  })  : _apiService = apiService,
        _storageService = storageService;

  Future<AuthResponse> login(String username, String password) async {
    final response = await _apiService.login(username, password);
    await _storageService.saveToken(response.token);
    _apiService.setAuthToken(response.token);
    return response;
  }

  Future<AuthResponse> register(
    String username,
    String email,
    String password, {
    String? nickname,
  }) async {
    final response = await _apiService.register(
      username,
      email,
      password,
      nickname: nickname,
    );
    await _storageService.saveToken(response.token);
    _apiService.setAuthToken(response.token);
    return response;
  }

  Future<User?> getCurrentUser() async {
    try {
      final token = await _storageService.getToken();
      if (token == null) return null;
      
      _apiService.setAuthToken(token);
      return await _apiService.getCurrentUser();
    } catch (e) {
      return null;
    }
  }

  Future<bool> isAuthenticated() async {
    final token = await _storageService.getToken();
    return token != null;
  }

  Future<void> logout() async {
    await _storageService.deleteToken();
    _apiService.clearAuthToken();
  }
}
