import 'package:breathez/app/data/app_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
    PhoneAuthProvider(),
    GoogleProvider(clientId: '104531095374-hseddbd6v2c86vt9fiq2bl1jid3860oe.apps.googleusercontent.com'),
  ]);

  ///
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Breathez",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      color: AppColors.primaryColor,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        primaryColor: AppColors.primaryColor,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            // textStyle: WidgetStateProperty.all(AppStyles.mediumBoldStyle(color: Colors.white)),
            backgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) {
                return AppColors.secondaryColor;
              }
              return AppColors.primaryColor;
            }),
            maximumSize: WidgetStateProperty.all(const Size(double.infinity, 60)),
            minimumSize: WidgetStateProperty.all(const Size(double.infinity, 50)),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            foregroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) {
                return AppColors.primaryColor;
              }
              return AppColors.white;
            }),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          alignLabelWithHint: true,

          // filled: true,
          // floatingLabelBehavior: FloatingLabelBehavior.auto,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.primaryColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.primaryColor)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 1.0),
        ),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    ),
  );
}
