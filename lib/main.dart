import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mushroom_friends/screens/map_screen/domain/markers_model.dart';
import 'package:mushroom_friends/screens/map_screen/domain/polylines_model.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:mushroom_friends/routes.dart';
import 'package:mushroom_friends/theme.dart';
import 'package:mushroom_friends/screens/settings_screen/data/data_base_service.dart';
import 'package:mushroom_friends/screens/settings_screen/data/friend_list_factory.dart';
import 'package:mushroom_friends/screens/settings_screen/data/local_data_source.dart';
import 'package:mushroom_friends/screens/map_screen/data/data_base_service.dart';
import 'package:mushroom_friends/screens/map_screen/ui/map_screen_model.dart';
import 'package:mushroom_friends/generated/l10n.dart';
import 'package:mushroom_friends/screens/map_screen/data/position_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  await Permission.locationWhenInUse.request();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MapScreenModel>(
          create: (context) => MapScreenModel(
            MapFireStoreService(),
            LocalDataSourceSharedPref(),
            FriendListFactory(
              SettingsFireStoreService(),
            ),
            PositionService(),
            MarkersModel(),
            PolylinesModel(),
          ),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        debugShowCheckedModeBanner: false,
        title: 'Mushroom Friends',
        theme: theme,
        initialRoute: initialRoute,
        routes: routes,
      ),
    );
  }
}
