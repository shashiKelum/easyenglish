import 'package:easyenglish/r.g.dart';
import 'package:easyenglish/ui/widgets/buttons/app_bar_back_button.dart';
import 'package:easyenglish/ui/widgets/buttons/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import 'level_state/level_state_view.dart';
import 'level_view_model.dart';

class LevelView extends ViewModelBuilderWidget<LevelViewModel> {
  final int level;
  final int unit;

  const LevelView({Key? key, required this.level, required this.unit})
      : super(key: key);

  @override
  Widget builder(
      BuildContext context, LevelViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBarBackButton(callback: viewModel.onClickBack),
        leadingWidth: 64,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        centerTitle: true,
        title: LevelStateView(levelStateList: viewModel.stateItems),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16, left: 12),
            child: Center(
              child: Button(
                onTap: () => viewModel.onTapLanguage(context),
                child:
                    Image(image: R.svg.ic_lang_si(width: 17.19, height: 18.81)),
              ),
            ),
          ),
        ],
      ),
      body: PageView.builder(
        controller: viewModel.controller,
        physics: NeverScrollableScrollPhysics(),
        itemCount: viewModel.getPageCount(),
        itemBuilder: (context, index) => viewModel.getPage(context, index),
      ),
    );
  }

  @override
  LevelViewModel viewModelBuilder(BuildContext context) =>
      LevelViewModel(Provider.of(context), level, unit);

  @override
  void onViewModelReady(LevelViewModel viewModel) => viewModel.init();
}
