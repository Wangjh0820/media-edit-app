class AppConstants {
  static const String appName = 'MediaEdit';
  static const String appVersion = '1.0.0';
  
  static const int maxImageSize = 50 * 1024 * 1024;
  static const int maxVideoSize = 500 * 1024 * 1024;
  
  static const List<String> supportedImageFormats = [
    'jpg', 'jpeg', 'png', 'webp', 'heic', 'heif', 'gif'
  ];
  
  static const List<String> supportedVideoFormats = [
    'mp4', 'mov', 'avi', 'mkv', 'webm'
  ];
  
  static const Map<String, dynamic> defaultImageFilters = {
    'brightness': 0.0,
    'contrast': 0.0,
    'saturation': 0.0,
    'hue': 0.0,
    'blur': 0.0,
    'sharpen': 0.0,
  };
  
  static const List<Map<String, String>> presetFilters = [
    {'id': 'original', 'name': '原图'},
    {'id': 'vivid', 'name': '鲜艳'},
    {'id': 'warm', 'name': '暖色'},
    {'id': 'cool', 'name': '冷色'},
    {'id': 'vintage', 'name': '复古'},
    {'id': 'bw', 'name': '黑白'},
    {'id': 'sepia', 'name': '怀旧'},
    {'id': 'dramatic', 'name': '戏剧'},
  ];
  
  static const List<Map<String, String>> aiStyles = [
    {'id': 'anime', 'name': '动漫风'},
    {'id': 'oil_painting', 'name': '油画风'},
    {'id': 'sketch', 'name': '素描风'},
    {'id': 'watercolor', 'name': '水彩风'},
    {'id': 'cyberpunk', 'name': '赛博朋克'},
    {'id': 'fantasy', 'name': '奇幻风'},
  ];
  
  static const List<double> playbackSpeeds = [0.25, 0.5, 0.75, 1.0, 1.25, 1.5, 2.0, 4.0];
  
  static const List<Map<String, String>> exportQualities = [
    {'id': '720p', 'name': '720P', 'description': '高清'},
    {'id': '1080p', 'name': '1080P', 'description': '全高清'},
    {'id': '4k', 'name': '4K', 'description': '超高清'},
  ];
}
