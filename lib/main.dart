import 'package:flutter/material.dart';
import 'package:workforcehub/screens/splash_screen.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "MyEmployee",
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
          useMaterial3: true
      ),
      home: const SplashScreen(),
    );
  }
}
