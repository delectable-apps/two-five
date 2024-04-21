import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'src/app.dart';
import 'src/providers/auth_provider.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => TwoFiveAuthProvider(app)),
      ],
      child: MyApp(settingsController: settingsController),
    ),
  );
}
