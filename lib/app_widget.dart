import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Consumindo Apis com GetX',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      getPages: AppPages.pages,
      initialRoute: AppRoutes.initial,
      debugShowCheckedModeBanner: false,
    );
  }
}
