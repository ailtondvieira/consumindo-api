import 'package:get/get.dart';

import 'app_routes.dart';
import 'routes_imports.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: AppRoutes.initial,
      page: () => LoginPage(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomePage(),
    ),
  ];
}
