import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



import 'app_bloc.dart';
import 'app_theme.dart';
import 'generated/l10n.dart';
import 'main.dart';
import 'presentation/bloc/bloc_provider.dart';
 import 'screens/splesh/splesh_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class PasaApp extends StatefulWidget {
  @override
  _PasaAppState createState() => _PasaAppState();
}

class _PasaAppState extends State<PasaApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(bloc: AppBloc(), child: App());
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      navigatorObservers: [routeObserver],
      theme: appTheme,
      localizationsDelegates: [
        S.delegate,
        // GlobalMaterialLocalizations.delegate,
        // GlobalCupertinoLocalizations.delegate,
        // GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: SpleshScreen(),
      // home: isviewed != 0 ? OnBoarding() : SpleshScreen(),
    );
  }
}
