import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/logger.dart';
import 'admin_menu_item.dart';
import 'expanded_section.dart';

class SideBarItem extends StatefulWidget {
  const SideBarItem({
    super.key,
    required this.item,
    required this.index,
    this.depth = 0,
    this.iconColor,
    this.activeIconColor,
    required this.textStyle,
    required this.activeTextStyle,
    required this.backgroundColor,
    required this.activeBackgroundColor,
    required this.borderColor,
  });

  final int depth;
  final int index;
  final AdminMenuItem item;
  final Color? iconColor;
  final Color? activeIconColor;
  final TextStyle textStyle;
  final TextStyle activeTextStyle;
  final Color backgroundColor;
  final Color activeBackgroundColor;
  final Color borderColor;

  @override
  State<SideBarItem> createState() => _SideBarItemState();
}

class _SideBarItemState extends State<SideBarItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1),
      child: _buildTiles(context, widget.item),
    );
  }

  Widget _buildTiles(BuildContext context, AdminMenuItem item) {
    if (item.children.isEmpty) {
      return ExpandedSection(
        amItem: item,
        onTap: () {
          Log.i(item.path);
          context.delegate.toNamed(item.path);
        },
        children: const [],
      );
    }

    int index = 0;
    final childrenTiles = item.children.map((child) {
      return SideBarItem(
        item: child,
        index: index++,
        depth: widget.depth + 1,
        iconColor: widget.iconColor,
        activeIconColor: widget.activeIconColor,
        textStyle: widget.textStyle,
        activeTextStyle: widget.activeTextStyle,
        backgroundColor: widget.backgroundColor,
        activeBackgroundColor: widget.activeBackgroundColor,
        borderColor: widget.borderColor,
      );
    }).toList();

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpandedSection(
        // tilePadding: _getTilePadding(depth),
        // leading: _buildIcon(item.icon),
        amItem: item,
        onTap: () {},
        children: childrenTiles,
      ),
    );
  }
}
