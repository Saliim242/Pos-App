import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';
import 'app/themes/theme.dart';
import 'app/themes/theme_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  await GetStorage().writeIfNull('getProductType', false);
  HttpOverrides.global = MyHttpOverrides();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      isToolbarVisible: true,
      // data: DevicePreviewData(
      //   deviceIdentifier: Devices.ios.iPhone12.toString(),
      //   isFrameVisible: false,
      //   //locale: 'fr_FR',
      // ),
      builder: (BuildContext context) {
        return MyApp();
      },
    ),

    // MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: "POS Management",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      // checkerboardOffscreenLayers: true,
      theme: Themes.lightMode,
      // Themes.darkMode,
      darkTheme: Themes.darkMode,
      themeMode: ServicesThemes().theme,
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
