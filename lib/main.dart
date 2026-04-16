// ignore_for_file: unused_import
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:homesloc/core/routes/pages.dart';
import 'package:homesloc/core/routes/routes.dart';
import 'package:homesloc/screens/auth/change_password.dart';
import 'package:homesloc/screens/auth/otp_varification.dart';
import 'package:homesloc/screens/auth/sign_in.dart';
import 'package:homesloc/screens/auth/sign_up.dart';
import 'package:homesloc/screens/bottom_bar_screen/bottom_bar_screen.dart';
import 'package:homesloc/screens/calendar_screen/calendar_screen.dart';
import 'package:homesloc/screens/categorie_screen/categorie_screen.dart';
import 'package:homesloc/screens/check_out/check_out.dart';
import 'package:homesloc/screens/home/home_screen.dart';
import 'package:homesloc/screens/splashscreen/splashscreen.dart';
import 'package:homesloc/themes/app_theme.dart';

import 'package:homesloc/core/services/firebase_service.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await FirebaseService.init();
  } catch (e) {
    debugPrint("Firebase initialization failed: $e");
  }

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Homesloc',
          debugShowCheckedModeBanner: false,
          theme: appTheme,
          builder: (context, widget) {
            // Only constrain on tablets (width > 600), mobile stays untouched
            final screenWidth = MediaQuery.of(context).size.width;
            if (screenWidth > 600) {
              return Container(
                color: Colors.white,
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: widget,
                  ),
                ),
              );
            }
            return widget ?? const SizedBox.shrink();
          },
          home: child ?? const Splashscreen(),
        );
      },
      child: const Splashscreen(),
    );
  }
}
