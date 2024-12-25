import 'package:flutter/material.dart';

class AdminMenuItem {
  AdminMenuItem(
      {required this.title,
      required this.path,
      this.icon,
      this.isExpanded = false,
      this.children = const []});

  final String title;
  final String path;
  final IconData? icon;
  bool isExpanded;
  final List<AdminMenuItem> children;
}
