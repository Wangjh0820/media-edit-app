import 'package:flutter/material.dart';
import 'package:media_edit_app/presentation/screens/main_screen.dart';
import 'package:media_edit_app/presentation/pages/auth/login_page.dart';
import 'package:media_edit_app/presentation/pages/editor/image_editor_screen.dart';
import 'package:media_edit_app/presentation/pages/editor/video_editor_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/editor':
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case '/editor/image':
        final args = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => ImageEditorScreen(imagePath: args),
        );
      case '/editor/video':
        final args = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => VideoEditorScreen(videoPath: args),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
