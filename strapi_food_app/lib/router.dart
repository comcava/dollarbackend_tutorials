import 'package:auto_route/auto_route.dart';

import 'pages/home.dart';
import 'pages/details.dart';
import 'pages/order.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomePage, initial: true),
    AutoRoute(page: DetailsPage),
    AutoRoute(page: OrderPage),
  ],
)
class $AppRouter {}
