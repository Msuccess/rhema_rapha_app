import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import 'package:rhema_rapha_app/core/routes/routes.dart';
import 'package:rhema_rapha_app/provider_setup.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MultiProvider(
        providers: providers,
        child: MaterialApp(
          initialRoute: RoutePaths.Splash,
          onGenerateRoute: RouterPath.generateRoute,
          navigatorKey: navigatorKey,
        ),
      ),
    );
  }
}
