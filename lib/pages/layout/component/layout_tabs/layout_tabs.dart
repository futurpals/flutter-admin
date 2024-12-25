import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/layout_controller.dart';
import 'tab_item.dart';

class LayoutTabs extends StatefulWidget {
  const LayoutTabs({super.key});

  @override
  State<LayoutTabs> createState() => _LayoutTabsState();
}

class _LayoutTabsState extends State<LayoutTabs> with TickerProviderStateMixin {
  LayoutController layoutCtrl = Get.find();
  var state = Get.find<LayoutController>().state;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black12, width: 0.5),
          ),
        ),
        height: 38,
        child: ReorderableListView(
          proxyDecorator: (child, index, animation) => Material(
            borderRadius: BorderRadius.circular(12),
            child: child,
          ),
          key: state.tabsKey,
          buildDefaultDragHandles: false,
          scrollDirection: Axis.horizontal,
          scrollController: state.scrollController,
          onReorder: (int oldIndex, int newIndex) {
            layoutCtrl.onReorder(oldIndex, newIndex);
          },
          children: state.tabsItems.map((item) {
            int index = state.tabsItems.indexOf(item);
            return ReorderableDragStartListener(
              key: ValueKey(item),
              index: index,
              child: TabItem(item: item, index: index),
            );
          }).toList(),
        ),
      ),
    );
  }
}
