import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mococo_mobile/src/binding/init_binding.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mococo_mobile/src/app.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MOCOCO',
      theme: ThemeData(
        canvasColor: Colors.transparent,
        primaryColor: const Color(0xffF6747E),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xffF6747E),
            surfaceTint: Colors.transparent,
            background: Colors.white),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko', 'KR'),
      ],
      initialBinding: InitBinding(),
      home: const App(),
    );
  }
}