import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:testapp/core/services/preference/preference.dart';

import 'core/services/localization/localization.dart';
import 'core/services/theme/theme_provider.dart';
import 'core/utils/provider_setup.dart';
import 'ui/routes/route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preference.init();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print(e.toString());
  }

  runApp(MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

// This widget is the root of your application.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppLanguageModel>(
        create: (_) => AppLanguageModel(),
        child: Consumer<AppLanguageModel>(builder: (context, model, child) {
          return ChangeNotifierProvider<ThemeProvider>(
              create: (_) => ThemeProvider(),
              child: Consumer<ThemeProvider>(builder: (context, theme, child) {
                return OverlaySupport(
                  child: MultiProvider(
                    providers: providers,
                    child: MaterialApp(
                      navigatorKey: navigatorKey,
                      home: Routes.homePage,
                      debugShowCheckedModeBanner: false,
                      theme: theme.isDark ? theme.dark : theme.light,
                      locale: model.appLocal,
                      supportedLocales: [
                        const Locale('en'),
                        const Locale('ar')
                      ],
                      localizationsDelegates: [
                        AppLocalizations.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                      ],
                    ),
                  ),
                );
              }));
        }));
  }
}
