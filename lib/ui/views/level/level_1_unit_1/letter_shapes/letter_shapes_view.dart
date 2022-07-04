import 'dart:math';

import 'package:easyenglish/r.g.dart';
import 'package:easyenglish/ui/theme/color.dart';
import 'package:easyenglish/ui/theme/styles.dart';
import 'package:easyenglish/ui/widgets/buttons/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'letter_shapes_view_model.dart';

class LetterShapesView extends ViewModelBuilderWidget<LetterShapesViewModel> {
  const LetterShapesView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, LetterShapesViewModel viewModel, Widget? child) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: FittedBox(
              child: Text(
                viewModel.getHighlightedLetter(),
                style: AppStyle.text60SB.copyWith(color: AppColors.primary),
              ),
            ),
          ),
          SizedBox(
            height: 72,
            child: PageView.builder(
              pageSnapping: true,
              itemCount: 26,
              onPageChanged: viewModel.onPageChanged,
              controller: PageController(viewportFraction: 0.15),
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
            ),
          ),
          SizedBox(height: 16),
           viewModel.book1page2(context),
          SizedBox(height: 32),
          Text(
           AppLocalizations.of(context)!.book1page2bottom,
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
  LetterShapesViewModel viewModelBuilder(BuildContext context) =>
      LetterShapesViewModel(Provider.of(context));
}
