// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'providers/store_provider.dart';
import 'providers/auth_provider.dart';
import 'screens/splash_screen.dart';
// import 'services/notification_service.dart'; // disabled until mobile device
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase must be initialised before anything else
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  // NotificationService disabled for now — re-enable when running on Android
  // await NotificationService.instance.init();

  runApp(const PurseonalityApp());
}

class PurseonalityApp extends StatelessWidget {
  const PurseonalityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => StoreProvider()),
      ],
      child: MaterialApp(
        title: 'Purseonality',
        debugShowCheckedModeBanner: false,
        theme: buildTheme(),
        // navigatorKey removed — NotificationService is disabled
        home: const SplashScreen(),
      ),
    );
  }
}
