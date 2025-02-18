import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotelautomationapp/Presentation/getx/appPages.dart';
import 'package:hotelautomationapp/approutes.dart';
import 'package:hotelautomationapp/constants/Theme.dart';
import 'package:hotelautomationapp/constants/fontsize.dart';
import 'package:hotelautomationapp/data/datasource/local/local_storage.dart';
import 'package:hotelautomationapp/data/datasource/remote/services/dio/dio.dart';
import 'package:hotelautomationapp/di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await GetStorage.init();
  await ScreenUtil.ensureScreenSize();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: [
    SystemUiOverlay.top,
    SystemUiOverlay.bottom
  ]);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown,DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]);
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(
          Dimensions.defaultWidth,
          Dimensions.deviceHeight),
      minTextAdapt: false,
      ensureScreenSize: true,
      useInheritedMediaQuery: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          initialBinding: InitialBinding(),
          builder: EasyLoading.init(),
          debugShowCheckedModeBanner: false,
          theme: AppTheme().lightTheme,
          darkTheme: AppTheme().darkTheme,
          themeMode: LocalStorage().getTheme(),
          title: "Trade Bit",
          initialRoute:  AppRoutes.onBoarding,
          getPages: AppPages.list,
        );
      },
    );
  }
}

