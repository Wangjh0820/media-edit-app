class AppConfig {
  static const String appName = 'MediaEdit';
  static const String version = '1.0.0';
  
  static const String baseUrl = 'http://localhost:8080/api';
  
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 60000;
  
  static const int maxFileSize = 500 * 1024 * 1024;
  static const int maxImageSize = 50 * 1024 * 1024;
  static const int maxVideoSize = 500 * 1024 * 1024;
  
  static const List<String> supportedImageFormats = [
    'jpg', 'jpeg', 'png', 'webp', 'heic', 'heif'
  ];
  
  static const List<String> supportedVideoFormats = [
    'mp4', 'mov', 'avi', 'mkv', 'webm'
  ];
  
  static const Map<String, dynamic> defaultEditSettings = {
    'brightness': 0.0,
    'contrast': 0.0,
    'saturation': 0.0,
    'hue': 0.0,
    'blur': 0.0,
    'sharpen': 0.0,
  };
  
  static const List<Map<String, dynamic>> presetFilters = [
    {'name': 'original', 'label': '原图'},
    {'name': 'vivid', 'label': '鲜艳'},
    {'name': 'warm', 'label': '暖色'},
    {'name': 'cool', 'label': '冷色'},
    {'name': 'vintage', 'label': '复古'},
    {'name': 'bw', 'label': '黑白'},
    {'name': 'sepia', 'label': '怀旧'},
    {'name': 'dramatic', 'label': '戏剧'},
  ];
}
