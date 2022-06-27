import 'dart:math';

import 'package:easyenglish/r.g.dart';
import 'package:easyenglish/ui/theme/color.dart';
import 'package:easyenglish/ui/theme/styles.dart';
import 'package:easyenglish/ui/widgets/buttons/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import 'phonic_words_view_model.dart';

class PhonicWordsView extends ViewModelBuilderWidget<PhonicWordsViewModel> {
  const PhonicWordsView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, PhonicWordsViewModel viewModel, Widget? child) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              pageSnapping: true,
              itemCount: 26,
              onPageChanged: viewModel.onPageChanged,
              controller: PageController(viewportFraction: 0.5),
              itemBuilder: (context, index) {
                return FittedBox(
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
            ),
          ),
          SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              alignment: WrapAlignment.start,
              runAlignment: WrapAlignment.start,
              children: [
                Text(
                  'These are ',
                  style:
                      AppStyle.text22SB.copyWith(color: AppColors.textPrimary),
                ),
                Text(
                  'Phonic Words',
                  style: AppStyle.text22SB.copyWith(color: AppColors.primary),
                ),
                Text('.',
                    style: AppStyle.text22SB
                        .copyWith(color: AppColors.textPrimary)),
              ],
            ),
          ),
          SizedBox(height: 32),
          Text(
            'Tap the words to hear the phonic letter used in the word.',
            style: AppStyle.text22SB.copyWith(color: AppColors.textPrimary),
          ),
          SizedBox(height: 32),
          Align(
            alignment: Alignment.centerRight,
            child: Button(
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
          ),
        ],
      ),
    );
  }

  @override
  PhonicWordsViewModel viewModelBuilder(BuildContext context) =>
      PhonicWordsViewModel(Provider.of(context));
}
