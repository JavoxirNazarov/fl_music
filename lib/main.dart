import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:top_music/common/libs/download_service/download_manager.dart';
import 'package:top_music/common/libs/store_manager/store_manager.dart';
import 'package:top_music/common/ui/layout/app_wrapper.dart';
import 'package:top_music/feauteres/auth/services/session_store.dart';
import 'package:top_music/feauteres/navigation/navigation.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await DownloadService.initDirectories();
  await StoreManager.init();
  await SessionStore.init();

  runApp(MyApp());

  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AppNavigation _appNavigation = AppNavigation();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: 'Top Music',
        debugShowCheckedModeBanner: false,
        routerConfig: _appNavigation.router,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('fr')],
        builder: (context, child) => AppWrapper(child: child!));
  }
}
