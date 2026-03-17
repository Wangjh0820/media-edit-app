import '../services/api_service.dart';
import '../models/user.dart';

class MediaRepository {
  final ApiService _apiService;

  MediaRepository({required ApiService apiService}) : _apiService = apiService;

  Future<List<MediaFile>> getMediaFiles({int page = 0, int size = 20}) async {
    return await _apiService.getMediaFiles(page: page, size: size);
  }

  Future<MediaFile> uploadFile(
    String filePath,
    String fileType, {
    Function(int, int)? onProgress,
  }) async {
    return await _apiService.uploadFile(
      filePath,
      fileType,
      onProgress: onProgress,
    );
  }

  Future<void> deleteFile(int fileId) async {
    await _apiService.deleteFile(fileId);
  }

  Future<String> enhanceImage(String imageBase64, {String? prompt}) async {
    return await _apiService.enhanceImage(imageBase64, prompt: prompt);
  }

  Future<String> analyzePose(String imageBase64) async {
    return await _apiService.analyzePose(imageBase64);
  }

  Future<String> getEditSuggestions(String description) async {
    return await _apiService.getEditSuggestions(description);
  }

  Future<String> faceDetect(String imageBase64) async {
    return await _apiService.faceDetect(imageBase64);
  }

  Future<String> styleTransfer(String imageBase64, String style) async {
    return await _apiService.styleTransfer(imageBase64, style);
  }
}
