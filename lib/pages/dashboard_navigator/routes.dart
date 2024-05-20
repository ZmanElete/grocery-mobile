import 'package:flutter/material.dart';

class DashboardRouteDescriptors {
  final String routeName;
  final String label;
  final Widget selectedIcon;
  final Widget icon;

  const DashboardRouteDescriptors({
    required this.routeName,
    required this.label,
    required this.selectedIcon,
    required this.icon,
  });
}
