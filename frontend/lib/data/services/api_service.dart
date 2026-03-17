import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../models/user.dart';

class ApiService {
  final Dio _dio;
  final String baseUrl;

  ApiService(this.baseUrl) : _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 60),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  )) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        debugPrint('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
        return handler.next(response);
      },
      onError: (error, handler) {
        debugPrint('ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.path}');
        return handler.next(error);
      },
    ));
  }

  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void clearAuthToken() {
    _dio.options.headers.remove('Authorization');
  }

  Future<AuthResponse> login(String username, String password) async {
    final response = await _dio.post('/auth/login', data: {
      'username': username,
      'password': password,
    });
    
    final apiResponse = ApiResponse.fromJson(
      response.data,
      (json) => AuthResponse.fromJson(json),
    );
    
    if (!apiResponse.success) {
      throw Exception(apiResponse.message);
    }
    
    return apiResponse.data!;
  }

  Future<AuthResponse> register(String username, String email, String password, {String? nickname}) async {
    final response = await _dio.post('/auth/register', data: {
      'username': username,
      'email': email,
      'password': password,
      'nickname': nickname,
    });
    
    final apiResponse = ApiResponse.fromJson(
      response.data,
      (json) => AuthResponse.fromJson(json),
    );
    
    if (!apiResponse.success) {
      throw Exception(apiResponse.message);
    }
    
    return apiResponse.data!;
  }

  Future<User> getCurrentUser() async {
    final response = await _dio.get('/auth/me');
    
    final apiResponse = ApiResponse.fromJson(
      response.data,
      (json) => User.fromJson(json),
    );
    
    if (!apiResponse.success) {
      throw Exception(apiResponse.message);
    }
    
    return apiResponse.data!;
  }

  Future<List<MediaFile>> getMediaFiles({int page = 0, int size = 20}) async {
    final response = await _dio.get('/files/list', queryParameters: {
      'page': page,
      'size': size,
    });
    
    final apiResponse = response.data;
    
    if (!apiResponse['success']) {
      throw Exception(apiResponse['message']);
    }
    
    final List<dynamic> content = apiResponse['data']['content'];
    return content.map((json) => MediaFile.fromJson(json)).toList();
  }

  Future<MediaFile> uploadFile(String filePath, String fileType, {Function(int, int)? onProgress}) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath),
      'type': fileType,
    });
    
    final response = await _dio.post(
      '/files/upload',
      data: formData,
      onSendProgress: onProgress,
    );
    
    final apiResponse = ApiResponse.fromJson(
      response.data,
      (json) => MediaFile.fromJson(json),
    );
    
    if (!apiResponse.success) {
      throw Exception(apiResponse.message);
    }
    
    return apiResponse.data!;
  }

  Future<void> deleteFile(int fileId) async {
    final response = await _dio.delete('/files/$fileId');
    
    final apiResponse = ApiResponse.fromJson(response.data, null);
    
    if (!apiResponse.success) {
      throw Exception(apiResponse.message);
    }
  }

  Future<String> enhanceImage(String imageBase64, {String? prompt}) async {
    final response = await _dio.post('/ai/enhance', data: {
      'image': imageBase64,
      'prompt': prompt,
    });
    
    return response.data['data'];
  }

  Future<String> analyzePose(String imageBase64) async {
    final response = await _dio.post('/ai/pose-analysis', data: {
      'image': imageBase64,
    });
    
    return response.data['data'];
  }

  Future<String> getEditSuggestions(String description) async {
    final response = await _dio.post('/ai/edit-suggestions', data: {
      'description': description,
    });
    
    return response.data['data'];
  }

  Future<String> faceDetect(String imageBase64) async {
    final response = await _dio.post('/ai/face-detect', data: {
      'image': imageBase64,
    });
    
    return response.data['data'];
  }

  Future<String> styleTransfer(String imageBase64, String style) async {
    final response = await _dio.post('/ai/style-transfer', data: {
      'image': imageBase64,
      'style': style,
    });
    
    return response.data['data'];
  }
}
