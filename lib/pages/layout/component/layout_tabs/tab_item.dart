import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/layout_controller.dart';
import '../sidebar/admin_menu_item.dart';

class TabItem extends StatefulWidget {
  const TabItem({super.key, required this.item, required this.index});

  final int index;
  final AdminMenuItem item;

  @override
  State<TabItem> createState() => _TabItemState();
}

class _TabItemState extends State<TabItem> with TickerProviderStateMixin {
  LayoutController layoutCtrl = Get.find();
  var state = Get.find<LayoutController>().state;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: () {
            context.delegate.toNamed(widget.item.path);
          },
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.symmetric(vertical: 3),
            width: 150,
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    border: Border(
                      left: BorderSide(width: 0.5, color: Color(0xFFDFE9FA)),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    margin: const EdgeInsets.only(left: 6),
                    padding: const EdgeInsets.only(top: 2, bottom: 2, left: 6),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6)),
                        color:
                            state.selectedRoute.value?.path == widget.item.path
                                ? const Color(0xFFDFE9FA)
                                : _isHovered
                                    ? Colors.black.withAlpha(10)
                                    : Colors.transparent),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            spacing: 6,
                            children: [
                              Icon(
                                widget.item.icon,
                                size: 16,
                                color: state.selectedRoute.value?.path ==
                                        widget.item.path
                                    ? Colors.blueAccent
                                    : Colors.black,
                              ),
                              Text(
                                widget.item.title,
                                style: TextStyle(
                                    color: state.selectedRoute.value?.path ==
                                            widget.item.path
                                        ? Colors.blueAccent
                                        : Colors.black,
                                    fontSize: 13),
                              )
                            ],
                          ),
                          GestureDetector(
                            child: const Icon(
                              Icons.close,
                              size: 12,
                            ),
                            onTap: () => layoutCtrl.removeTab(widget.index),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
