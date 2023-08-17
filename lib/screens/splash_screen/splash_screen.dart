import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:mushroom_friends/generated/l10n.dart';
import 'package:mushroom_friends/screens/auth_screen/ui/auth_screen.dart';
import 'package:mushroom_friends/screens/map_screen/ui/map_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authUserID = FirebaseAuth.instance.currentUser?.uid;
    return SafeArea(
      child: Stack(
        children: [
          Image.asset(
            'assets/images/splashWallpaper.webp',
            fit: BoxFit.fill,
            height: MediaQuery.of(context).size.height,
          ),
          AnimatedSplashScreen(
            splashIconSize: 160,
            duration: 2500,
            splashTransition: SplashTransition.sizeTransition,
            backgroundColor: const Color.fromRGBO(70, 86, 86, 0.8),
            splash: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset(
                'assets/images/splashItem.webp',
                fit: BoxFit.fill,
              ),
            ),
            nextScreen:
                authUserID != null ? const MapScreen() : const AuthScreen(),
          ),
          Positioned(
            width: MediaQuery.of(context).size.width,
            bottom: MediaQuery.of(context).size.height / 3,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                S.of(context).splashTitle,
                style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    decoration: TextDecoration.none),
              ),
            ),
          ),
          Positioned(
            right: MediaQuery.of(context).size.height / 15,
            bottom: MediaQuery.of(context).size.height / 20,
            child: const Text(
              'Created by COSHA',
              style: TextStyle(
                  color: Colors.white30,
                  fontSize: 7,
                  decoration: TextDecoration.none),
            ),
          ),
        ],
        // child:
      ),
    );
  }
}
