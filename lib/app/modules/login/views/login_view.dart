import 'package:breathez/app/modules/home/controllers/home_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../home/views/home_view.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return AuthGate();
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasData) {
          Get.put(HomeController());
          return const HomeView();
        }
        return SignInScreen(
          headerMaxExtent: 220,
          headerBuilder: (context, constraints, shrinkOffset) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/transparent_icon.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
