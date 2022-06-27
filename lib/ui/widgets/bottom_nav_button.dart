import 'dart:io';

import 'package:easyenglish/core/enums/bottom_nav_items.dart';
import 'package:easyenglish/ui/views/main/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class BottomNavButton extends ViewModelWidget<MainViewModel> {
  final BottomNavItems item;
  final Widget? iconWidget;
  final String? name;

  BottomNavButton({required this.item, this.iconWidget, this.name});

  @override
  Widget build(BuildContext context, MainViewModel model) {
    return InkWell(
      onTap: () => model.onClickBottomNavItem(item),
      radius: 36,
      borderRadius: BorderRadius.circular(42.0),
      child: Container(
        margin: EdgeInsets.only(
            left: 8.0,
            right: 8.0,
            top: 8.0,
            bottom: (Platform.isIOS ? 2.0 : 8.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            iconWidget != null
                ? Container(child: iconWidget)
                : Image(
                    image: item.icon!,
                    // height: 22.0,
                    // width: 22.0,
                    // color: model.currentNavItem == item
                    //     ? AppColors.primary
                    //     : Colors.black,
                  ),
            // if (name != null) SizedBox(height: 2.0),
            // if (name != null)
            //   Text(
            //     name!,
            //     style: Theme.of(context).textTheme.bodyText2!.copyWith(
            //           color: model.currentNavItem == item
            //               ? AppColors.primary
            //               : Colors.white,
            //         ),
            //   ),
          ],
        ),
      ),
    );
  }
}
