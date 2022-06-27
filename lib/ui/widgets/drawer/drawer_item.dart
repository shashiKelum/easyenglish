import 'package:easyenglish/core/enums/auth_state.dart';
import 'package:easyenglish/core/enums/drawer_items.dart';
import 'package:easyenglish/core/methods/typedefs.dart';
import 'package:easyenglish/core/services/app_state_service.dart';
import 'package:easyenglish/ui/widgets/drawer/drawer_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class DrawerItem extends ViewModelWidget<DrawerViewModel> {
  final DrawerItems item;
  final bool enabled;
  final Callback<DrawerItems> itemCallback;

  DrawerItem(
      {required this.item, this.enabled = true, required this.itemCallback});

  @override
  Widget build(BuildContext context, DrawerViewModel model) {
    return StreamBuilder<AuthState>(
      stream: Provider.of<AppStateService>(context, listen: false).authState,
      builder: (BuildContext context, AsyncSnapshot<AuthState> snapshot) {
        bool singedIn = snapshot.hasData && snapshot.data == AuthState.SignedIn;
        return ListTile(
          dense: true,
          enabled: enabled || singedIn,
          leading: item.icon != null ? Image(image: item.icon!) : null,
          title: Text(
            '${item.text}',
            // style: enabled || singedIn
            //     ? AppStyle.textStyle14
            //     : AppStyle.textStyle14.copyWith(color: Colors.black45),
          ),
          onTap: () => itemCallback(this.item),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          visualDensity: VisualDensity.compact,
        );
      },
    );
  }
}
