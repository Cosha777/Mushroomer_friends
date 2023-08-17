import 'package:mushroom_friends/screens/auth_screen/ui/auth_screen.dart';
import 'package:mushroom_friends/screens/map_screen/ui/map_screen.dart';
import 'package:mushroom_friends/screens/settings_screen/ui/settings_screen.dart';
import 'package:mushroom_friends/screens/splash_screen/splash_screen.dart';

final routes = {
  '/splashScreen': (context) => const SplashScreen(),
  '/authScreen': (context) => const AuthScreen(),
  '/mapScreen': (context) => const MapScreen(),
  '/settingsScreen': (context) => const SettingsScreen(),
};

const initialRoute = '/splashScreen';
