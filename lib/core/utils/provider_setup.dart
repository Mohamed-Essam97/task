// provider_setup.dart
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:testapp/core/services/api/api.dart';
import 'package:testapp/core/services/api/fake_api.dart';
import 'package:testapp/core/services/api/http_api.dart';
import 'package:testapp/core/services/auth/authentication_service.dart';
import 'package:testapp/core/services/localization/localization.dart';
import 'package:testapp/core/services/theme/theme_provider.dart';

import '../services/connectivity/connectivity_service.dart';
import '../services/notification/notification_service.dart';

const bool USE_FAKE_IMPLEMENTATION = false;

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders,
];

List<SingleChildWidget> independentServices = [
  // Provider(create: (_) => () => DB()),
  Provider<Api>(create: (_) =>  HttpApi()),
  // ChangeNotifierProvider<ConnectivityService>(
  //     create: (context) => ConnectivityService()),
];

List<SingleChildWidget> dependentServices = [
  ProxyProvider<Api, AuthenticationService>(
      update: (context, api, authenticationService) =>
          AuthenticationService(api: api)),

];

List<SingleChildWidget> uiConsumableProviders = [
  ChangeNotifierProvider(create: (_) => ThemeProvider()),
  ChangeNotifierProvider<AppLanguageModel>(create: (_) => AppLanguageModel()),
  // StreamProvider<User>(
  //     create: (context) =>
  //         Provider.of<AuthenticationService>(context, listen: false).user),
];
