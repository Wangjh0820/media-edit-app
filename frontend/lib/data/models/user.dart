import 'dart:convert';

class User {
  final int id;
  final String username;
  final String email;
  final String? avatar;
  final String? nickname;
  final bool vip;
  final int storageUsed;
  final int storageLimit;

  User({
    required this.id,
    required this.username,
    required this.email,
    this.avatar,
    this.nickname,
    this.vip = false,
    this.storageUsed = 0,
    this.storageLimit = 1073741824,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      avatar: json['avatar'],
      nickname: json['nickname'],
      vip: json['vip'] ?? false,
      storageUsed: json['storageUsed'] ?? 0,
      storageLimit: json['storageLimit'] ?? 1073741824,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'avatar': avatar,
      'nickname': nickname,
      'vip': vip,
      'storageUsed': storageUsed,
      'storageLimit': storageLimit,
    };
  }

  String get displayName => nickname ?? username;

  double get storagePercentage => storageUsed / storageLimit;
}

class AuthResponse {
  final String token;
  final String tokenType;
  final User user;

  AuthResponse({
    required this.token,
    required this.tokenType,
    required this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'],
      tokenType: json['tokenType'] ?? 'Bearer',
      user: User.fromJson(json),
    );
  }
}

class MediaFile {
  final int id;
  final int userId;
  final String fileName;
  final String originalName;
  final String filePath;
  final String fileType;
  final int fileSize;
  final String? thumbnailPath;
  final int? duration;
  final int? width;
  final int? height;
  final DateTime createdAt;

  MediaFile({
    required this.id,
    required this.userId,
    required this.fileName,
    required this.originalName,
    required this.filePath,
    required this.fileType,
    required this.fileSize,
    this.thumbnailPath,
    this.duration,
    this.width,
    this.height,
    required this.createdAt,
  });

  factory MediaFile.fromJson(Map<String, dynamic> json) {
    return MediaFile(
      id: json['id'],
      userId: json['userId'],
      fileName: json['fileName'],
      originalName: json['originalName'],
      filePath: json['filePath'],
      fileType: json['fileType'],
      fileSize: json['fileSize'],
      thumbnailPath: json['thumbnailPath'],
      duration: json['duration'],
      width: json['width'],
      height: json['height'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  bool get isImage => fileType == 'image';
  bool get isVideo => fileType == 'video';

  String get fileSizeFormatted {
    if (fileSize < 1024) return '$fileSize B';
    if (fileSize < 1024 * 1024) return '${(fileSize / 1024).toStringAsFixed(1)} KB';
    if (fileSize < 1024 * 1024 * 1024) {
      return '${(fileSize / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(fileSize / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}

class EditProject {
  final int id;
  final int userId;
  final String name;
  final String? description;
  final String projectType;
  final String? projectData;
  final String? thumbnailPath;
  final String? outputPath;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  EditProject({
    required this.id,
    required this.userId,
    required this.name,
    this.description,
    required this.projectType,
    this.projectData,
    this.thumbnailPath,
    this.outputPath,
    this.isCompleted = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EditProject.fromJson(Map<String, dynamic> json) {
    return EditProject(
      id: json['id'],
      userId: json['userId'],
      name: json['name'],
      description: json['description'],
      projectType: json['projectType'],
      projectData: json['projectData'],
      thumbnailPath: json['thumbnailPath'],
      outputPath: json['outputPath'],
      isCompleted: json['isCompleted'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;

  ApiResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json, T Function(dynamic)? fromJsonT) {
    return ApiResponse(
      success: json['success'],
      message: json['message'],
      data: fromJsonT != null && json['data'] != null ? fromJsonT(json['data']) : json['data'],
    );
  }
}
