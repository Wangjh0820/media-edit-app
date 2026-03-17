import 'dart:convert';
import 'dart:typed_data';

class FileUtils {
  static String getExtension(String fileName) {
    final parts = fileName.split('.');
    return parts.length > 1 ? parts.last.toLowerCase() : '';
  }

  static String getFileNameWithoutExtension(String fileName) {
    final parts = fileName.split('.');
    return parts.length > 1 ? parts.sublist(0, parts.length - 1).join('.') : fileName;
  }

  static bool isImage(String fileName) {
    final ext = getExtension(fileName);
    return ['jpg', 'jpeg', 'png', 'webp', 'heic', 'heif', 'gif'].contains(ext);
  }

  static bool isVideo(String fileName) {
    final ext = getExtension(fileName);
    return ['mp4', 'mov', 'avi', 'mkv', 'webm'].contains(ext);
  }

  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  static String formatDuration(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  static String imageToBase64(Uint8List imageBytes) {
    return base64Encode(imageBytes);
  }

  static Uint8List base64ToImage(String base64String) {
    return base64Decode(base64String);
  }
}
