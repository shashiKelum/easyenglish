import 'package:easyenglish/ui/views/main/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class MainAppBarView extends ViewModelWidget<MainViewModel>
    implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context, MainViewModel viewModel) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        '${viewModel.title}',
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
