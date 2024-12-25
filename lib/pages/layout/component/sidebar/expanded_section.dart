import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/layout_controller.dart';
import 'admin_menu_item.dart';

class ExpandedSection extends StatefulWidget {
  final AdminMenuItem amItem;
  final GestureTapCallback? onTap;
  final List<Widget> children;

  const ExpandedSection({
    super.key,
    required this.amItem,
    required this.children,
    this.onTap,
  });

  @override
  _ExpandedSectionState createState() => _ExpandedSectionState();
}

class _ExpandedSectionState extends State<ExpandedSection> {
  LayoutController layoutCtrl = Get.find();
  var state = Get.find<LayoutController>().state;

  bool _isHovered = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Column(
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (_) => setState(() => _isHovered = true),
              onExit: (_) => setState(() => _isHovered = false),
              child: GestureDetector(
                onTap: () {
                  if (widget.onTap != null) {
                    widget.onTap!();
                  }
                  widget.amItem.isExpanded = !widget.amItem.isExpanded;
                  setState(() {});
                },
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 10, top: 10, bottom: 10, right: 10),
                  decoration: BoxDecoration(
                    color: state.selectedRoute.value?.path == widget.amItem.path
                        ? const Color(0xFFDFE9FA)
                        : _isHovered
                            ? Colors.black.withAlpha(10)
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        spacing: 6,
                        children: [
                          TweenAnimationBuilder<double>(
                            duration: const Duration(milliseconds: 200),
                            tween: Tween<double>(
                                begin: 1.0, end: _isHovered ? 1.3 : 1.0),
                            builder: (context, scale, child) {
                              return Transform.scale(
                                scale: scale,
                                child: child,
                              );
                            },
                            child: Icon(
                              widget.amItem.icon,
                              color: state.selectedRoute.value?.path ==
                                      widget.amItem.path
                                  ? Colors.blueAccent
                                  : _isHovered
                                      ? Colors.blueAccent
                                      : Colors.black,
                              size: 16,
                            ),
                          ),
                          Text(
                            widget.amItem.title,
                            style: TextStyle(
                                color: state.selectedRoute.value?.path ==
                                        widget.amItem.path
                                    ? Colors.blueAccent
                                    : _isHovered
                                        ? Colors.blueAccent
                                        : Colors.black),
                          ),
                        ],
                      ),
                      if (widget.children.isNotEmpty)
                        AnimatedRotation(
                          duration: const Duration(milliseconds: 300),
                          turns: widget.amItem.isExpanded ? 0.5 : 0.0,
                          // 0.5 turns is 180 degrees
                          child: Icon(
                            Icons.expand_more_rounded,
                            color: state.selectedRoute.value?.path ==
                                    widget.amItem.path
                                ? Colors.blueAccent
                                : _isHovered
                                    ? Colors.blueAccent
                                    : Colors.black,
                            size: 18,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            AnimatedContainer(
              padding: const EdgeInsets.only(left: 10),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height: widget.amItem.isExpanded ? null : 0.0,
              child: Column(children: widget.children),
            )
          ],
        );
      },
    );
  }
}
