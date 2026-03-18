import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/theme/app_theme.dart';
import 'core/config/app_config.dart';
import 'data/services/api_service.dart';
import 'data/services/storage_service.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/media_repository.dart';
import 'presentation/bloc/auth/auth_bloc.dart';
import 'presentation/bloc/media/media_bloc.dart';
import 'presentation/screens/main_screen.dart';
import 'presentation/pages/auth/login_page.dart';
import 'presentation/pages/auth/register_page.dart';
import 'presentation/pages/editor/image_editor_screen.dart';
import 'presentation/pages/editor/video_editor_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  
  final storageService = StorageService();
  await storageService.init();
  
  runApp(MediaEditApp(storageService: storageService));
}

class MediaEditApp extends StatelessWidget {
  final StorageService storageService;
  
  const MediaEditApp({super.key, required this.storageService});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<StorageService>.value(value: storageService),
        RepositoryProvider<ApiService>(
          create: (_) => ApiService(AppConfig.baseUrl),
        ),
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(
            apiService: context.read<ApiService>(),
            storageService: context.read<StorageService>(),
          ),
        ),
        RepositoryProvider<MediaRepository>(
          create: (context) => MediaRepository(
            apiService: context.read<ApiService>(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            )..add(AuthCheckRequested()),
          ),
          BlocProvider<MediaBloc>(
            create: (context) => MediaBloc(
              mediaRepository: context.read<MediaRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          title: AppConfig.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('zh', 'CN'),
            Locale('en', 'US'),
          ],
          onGenerateRoute: _generateRoute,
          initialRoute: '/',
        ),
      ),
    );
  }

  static Route<dynamic> _generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthAuthenticated) {
                return const MainScreen();
              } else if (state is AuthUnauthenticated) {
                return const LoginPage();
              }
              return const SplashScreen();
            },
          ),
        );
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => const MainScreen());
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
            appBar: AppBar(title: const Text('错误')),
            body: Center(
              child: Text('未找到路由: ${settings.name}'),
            ),
          ),
        );
    }
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.video_library_rounded,
                size: 80,
                color: Colors.white,
              ),
              SizedBox(height: 20),
              Text(
                'MediaEdit',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '专业媒体编辑工具',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
