import 'dart:math';

import 'package:easyenglish/r.g.dart';
import 'package:easyenglish/ui/theme/color.dart';
import 'package:easyenglish/ui/theme/styles.dart';
import 'package:easyenglish/ui/widgets/audio_controller/audio_controller_view.dart';
import 'package:easyenglish/ui/widgets/buttons/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'letter_names_view_model.dart';

class LetterNamesView extends ViewModelBuilderWidget<LetterNamesViewModel> {
  final method;

  const LetterNamesView({Key? key, required this.method}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, LetterNamesViewModel viewModel, Widget? child) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
              itemBuilder: (context, index) {
                return Container(
                  child: Center(
                    child: Text(
                      viewModel.getLetter(index),
                      style: viewModel.highlightedIndex == index
                          ? AppStyle.text60SB.copyWith(color: AppColors.primary)
                          : AppStyle.text38SB.copyWith(
                              color: AppColors.textPrimary.withOpacity(0.7)),
                    ),
                  ),
                );
              },
              shrinkWrap: true,
              itemCount: 26,
            ),
          ),
          SizedBox(height: 16),
          viewModel.book1page1(context),
          SizedBox(height: 32),
          Text(
            AppLocalizations.of(context)!.book1page1bottom,
            style: AppStyle.text22SB.copyWith(color: AppColors.textPrimary),
          ),
          SizedBox(height: 32),
          Row(
            children: [
              Expanded(child: AudioControllerView<LetterNamesViewModel>()),
              SizedBox(width: 16),
              Button(
                width: 46,
                height: 46,
                enabled: viewModel.nextButtonEnabled,
                color: AppColors.secondary,
                shadowColor: AppColors.secondaryDark,
                child: Center(
                  child: Transform.rotate(
                    angle: pi / 1.0,
                    child: Image(
                      image: R.image.ic_arrow_back(),
                      color: viewModel.nextButtonEnabled
                          ? Colors.white
                          : AppColors.textDisabled,
                    ),
                  ),
                ),
                onTap: viewModel.onClickNext,
              ),
              SizedBox(width: 16),
            ],
          ),
        ],
      ),
    );
  }

  @override
  LetterNamesViewModel viewModelBuilder(BuildContext context) =>
      LetterNamesViewModel(Provider.of(context), method);

  @override
  void onViewModelReady(LetterNamesViewModel viewModel) => viewModel.init();
}
