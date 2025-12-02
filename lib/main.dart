import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kmasc/screens/splash_screen.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await clearAppCache();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color(0xFFFFE4E1),
    statusBarIconBrightness: Brightness.dark, 
  ));

  runApp(const MyApp());
}

Future<void> clearAppCache() async {
  try {
    final tempDir = await getTemporaryDirectory();
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
      debugPrint('Đã xóa cache');
    }
  } catch (e) {
    debugPrint('Lỗi khi xóa cache: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}