import 'dart:math';

import 'package:easyenglish/core/models/term_entity.dart';
import 'package:easyenglish/r.g.dart';
import 'package:easyenglish/ui/theme/color.dart';
import 'package:easyenglish/ui/theme/styles.dart';
import 'package:easyenglish/ui/views/book/views/prelude/book_prelude_view_model.dart';
import 'package:easyenglish/ui/widgets/buttons/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import 'item/prelude_view.dart';

class BookPreludeView extends ViewModelBuilderWidget<BookPreludeViewModel> {
  final List<Term> preludes;

  const BookPreludeView(this.preludes, {Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, BookPreludeViewModel viewModel, Widget? child) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            itemCount: viewModel.preludes.length,
            controller: viewModel.itemPageController,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) =>
                Center(child: PreludeView(term: viewModel.preludes[index])),
          ),
        ),
        SizedBox(
          height: 40,
          child: PageView.builder(
            itemCount: viewModel.preludes.length,
            pageSnapping: true,
            controller: viewModel.pageController,
            onPageChanged: viewModel.onPageChanged,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Button(
                  child: Center(
                      child: Text(
                    '${viewModel.preludes[index].englishTerm}',
                    style: AppStyle.text20SB.copyWith(
                        color: viewModel.index == index
                            ? Colors.white
                            : AppColors.textPrimary),
                  )),
                  width: null,
                  height: null,
                  color: viewModel.index == index
                      ? AppColors.primary
                      : AppColors.buttonDefault,
                  shadowColor: viewModel.index == index
                      ? AppColors.primaryDark
                      : AppColors.buttonDefaultShadow,
                  onTap: () => viewModel.onTapItem(index),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.secondary.withOpacity(0.2),
                      spreadRadius: 10,
                      blurRadius: 30,
                    ),
                  ],
                ),
                child: SfSliderTheme(
                  data: SfSliderThemeData(
                    thumbRadius: 5,
                    thumbStrokeWidth: 5,
                    activeTrackHeight: 11,
                    inactiveTrackHeight: 11,
                    thumbColor: Colors.transparent,
                    thumbStrokeColor: Colors.transparent,
                    activeTrackColor: AppColors.secondary,
                    inactiveTrackColor: AppColors.secondary.withOpacity(0.1),
                  ),
                  child: SfSlider(
                    max: viewModel.preludes.length,
                    value: viewModel.index + 1,
                    minorTicksPerInterval: 1,
                    stepSize: 1.0,
                    thumbIcon: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        colors: [
                          AppColors.secondary,
                          AppColors.secondary.withOpacity(0.5),
                          AppColors.secondary.withOpacity(0.1)
                        ],
                      ),),
                    ),
                    onChanged: (value) {},
                  ),
                ),
              ),
            ),
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
        SizedBox(height: 16),
      ],
    );
  }

  @override
  BookPreludeViewModel viewModelBuilder(BuildContext context) =>
      BookPreludeViewModel(preludes, Provider.of(context));
}
