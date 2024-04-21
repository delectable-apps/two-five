import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'sample_feature/sample_item_details_view.dart';
import 'sample_feature/sample_item_list_view.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';
import '../src/providers/auth_provider.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    final providers = [EmailAuthProvider()];

    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
            restorationScopeId: 'app',
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''), // English, no country code
            ],
            onGenerateTitle: (BuildContext context) =>
                AppLocalizations.of(context)!.appTitle,
            theme: ThemeData(),
            darkTheme: ThemeData.dark(),
            themeMode: settingsController.themeMode,
            routes: {
              SettingsView.routeName: (context) =>
                  SettingsView(controller: settingsController),
              SampleItemDetailsView.routeName: (context) =>
                  const SampleItemDetailsView(),
              SampleItemListView.routeName: (context) =>
                  const SampleItemListView(),
              '/sign-in': (context) {
                return SignInScreen(
                  providers: providers,
                  actions: [
                    AuthStateChangeAction<SignedIn>((context, state) {
                      Navigator.pushReplacementNamed(
                          context, SampleItemListView.routeName);
                    }),
                  ],
                );
              },
            },
            home: StreamBuilder<User?>(
              stream: Provider.of<TwoFiveAuthProvider>(context)
                  .auth
                  .authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const SampleItemListView();
                }
                return SignInScreen(
                  providers: providers,
                  actions: [
                    AuthStateChangeAction<SignedIn>((context, state) {
                      Navigator.pushReplacementNamed(
                          context, SampleItemListView.routeName);
                    }),
                  ],
                );
              },
            ));
      },
    );
  }
}
