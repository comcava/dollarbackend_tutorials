// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

import 'pages/details.dart' as _i2;
import 'pages/home.dart' as _i1;
import 'pages/order.dart' as _i3;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.HomePage(),
      );
    },
    DetailsRoute.name: (routeData) {
      final args = routeData.argsAs<DetailsRouteArgs>();
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.DetailsPage(
          id: args.id,
          key: args.key,
        ),
      );
    },
    OrderRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.OrderPage(),
      );
    },
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(
          HomeRoute.name,
          path: '/',
        ),
        _i4.RouteConfig(
          DetailsRoute.name,
          path: '/details-page',
        ),
        _i4.RouteConfig(
          OrderRoute.name,
          path: '/order-page',
        ),
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i4.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i2.DetailsPage]
class DetailsRoute extends _i4.PageRouteInfo<DetailsRouteArgs> {
  DetailsRoute({
    required String id,
    _i5.Key? key,
  }) : super(
          DetailsRoute.name,
          path: '/details-page',
          args: DetailsRouteArgs(
            id: id,
            key: key,
          ),
        );

  static const String name = 'DetailsRoute';
}

class DetailsRouteArgs {
  const DetailsRouteArgs({
    required this.id,
    this.key,
  });

  final String id;

  final _i5.Key? key;

  @override
  String toString() {
    return 'DetailsRouteArgs{id: $id, key: $key}';
  }
}

/// generated route for
/// [_i3.OrderPage]
class OrderRoute extends _i4.PageRouteInfo<void> {
  const OrderRoute()
      : super(
          OrderRoute.name,
          path: '/order-page',
        );

  static const String name = 'OrderRoute';
}
