import 'package:flutter/material.dart';
import 'package:grocery_genie/router.dart';

class DashboardRouteDescriptors {
  final List<AppRoute> routes;
  final AppRoute destinationRoute;
  final String label;
  final Widget selectedIcon;
  final Widget icon;

  const DashboardRouteDescriptors({
    required this.routes,
    required this.destinationRoute,
    required this.label,
    required this.selectedIcon,
    required this.icon,
  });
}
