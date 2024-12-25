import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/logger.dart';
import '../component/sidebar/admin_menu_item.dart';
import 'layout_state.dart';

class LayoutController extends GetxController {
  final LayoutState state = LayoutState();

  @override
  void onInit() {
    super.onInit();
    state.selectedRoute.value = state.menuItems.first;
    state.tabsItems.add(state.menuItems.first);
  }

  Widget getLateralPath(TextStyle style) {
    List<AdminMenuItem> list = findMenuItemPathByPath(
        state.menuItems, state.selectedRoute.value!.path)!;
    List<Widget> wlist = [];
    for (int i = 0; i < list.length; i++) {
      if (i != list.length - 1) {
        wlist.add(Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          alignment: Alignment.center,
          child: Row(
            spacing: 6,
            children: [
              Icon(list[i].icon, size: 16, color: const Color(0xFF717179)),
              Text(list[i].title, style: style)
            ],
          ),
        ));
      } else {
        wlist.add(Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          alignment: Alignment.center,
          child: Row(
            spacing: 6,
            children: [
              Icon(list[i].icon, size: 16, color: Colors.black),
              Text(
                list[i].title,
                style: TextStyle(color: Colors.black, fontSize: style.fontSize),
              )
            ],
          ),
        ));
      }
      if (i != list.length - 1) {
        wlist.add(const Icon(Icons.arrow_forward_ios_rounded,
            color: const Color(0xFF717179), size: 12));
      }
    }
    return Row(children: wlist);
  }

  AdminMenuItem? findMenuItemByPath(
      List<AdminMenuItem> menuItems, String path) {
    for (var item in menuItems) {
      if (item.path == path) {
        return item;
      }
      // 如果子菜单中有匹配的项，返回该项
      final foundItem = findMenuItemByPath(item.children, path);
      if (foundItem != null) {
        return foundItem;
      }
    }
    // 如果没有找到，返回 null
    return null;
  }

  List<AdminMenuItem> getNeedExpandedList() {
    List<AdminMenuItem> list = findMenuItemPathByPath(
        state.menuItems, state.selectedRoute.value!.path)!;
    return list;
  }

  List<AdminMenuItem>? findMenuItemPathByPath(
      List<AdminMenuItem> menuItems, String path) {
    // 一个帮助函数，用于递归查找路径
    List<AdminMenuItem>? search(
        List<AdminMenuItem> items, String path, List<AdminMenuItem> subItems) {
      for (var item in items) {
        // 将当前项添加到路径中
        subItems.add(item);

        if (item.path == path) {
          return subItems;
        }

        // 在子菜单中寻找
        final result = search(item.children, path, subItems);
        if (result != null) {
          return result;
        }

        // 如果没找到，移除当前项
        subItems.removeLast();
      }
      return null;
    }

    // 初始化路径列表，并开始搜索
    return search(menuItems, path, []);
  }

  void onNavByNative(String path, BuildContext context) {
    if (path == '') {
      return;
    }
    AdminMenuItem? item = findMenuItemByPath(state.menuItems, path);
    if (item == null) {
      Log.e('item is null');
      return;
    }
    state.selectedRoute.value = item;
    RenderBox box =
        state.tabsKey.currentContext?.findRenderObject() as RenderBox;
    int tabsWidth = box.size.width.toInt();
    int index = state.tabsItems.indexOf(item);
    int start = 0;
    int end = 0;
    double offset = state.scrollController.offset;
    if (!state.tabsItems.contains(item)) {
      state.tabsItems.add(item);
      index = state.tabsItems.indexOf(item);
      end = (index + 1) * 150;
      if (end >= tabsWidth + offset) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          state.scrollController.animateTo(
            (index + 1) * 150.0 - tabsWidth,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        });
      }
    } else {
      if (offset >= start) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          state.scrollController.animateTo(
            start.toDouble(),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        });
      }
    }
    List<AdminMenuItem> needExpandedList = getNeedExpandedList();
    for (int i = 0; i < needExpandedList.length; i++) {
      needExpandedList[i].isExpanded = true;
    }
  }

  void removeTab(int index) {
    if (state.selectedRoute.value == state.tabsItems[index]) {
      state.tabsItems.removeAt(index);
      state.selectedRoute.value = state.tabsItems.last;
    } else {
      state.tabsItems.removeAt(index);
    }
  }

  void onReorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final AdminMenuItem item = state.tabsItems.removeAt(oldIndex);
    state.tabsItems.insert(newIndex, item);
  }
}
