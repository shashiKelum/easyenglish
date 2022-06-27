import 'package:easy_localization/src/public_ext.dart';
import 'package:easyenglish/core/enums/language.dart';
import 'package:easyenglish/r.g.dart';
import 'package:easyenglish/ui/theme/color.dart';
import 'package:easyenglish/ui/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'locale_view_model.dart';

class LocaleItemView extends ViewModelWidget<LocaleViewModel> {
  final LocaleItemViewPosition position;
  final Language language;
  final Radius radius = const Radius.circular(15);

  const LocaleItemView({Key? key, required this.language, required this.position})
      : super(key: key);

  @override
  Widget build(BuildContext context, LocaleViewModel viewModel) {
    BoxDecoration selectedDecoration = BoxDecoration(
      color: AppColors.primaryLight,
      border: Border.all(color: AppColors.primary, width: 2),
    );

    switch (position) {
      case LocaleItemViewPosition.Start:
        selectedDecoration = selectedDecoration.copyWith(
          borderRadius: BorderRadius.only(topLeft: radius, topRight: radius),
        );
        break;
      case LocaleItemViewPosition.Middle:
        selectedDecoration = selectedDecoration.copyWith(
          borderRadius: BorderRadius.all(radius),
        );
        break;
      case LocaleItemViewPosition.End:
        selectedDecoration = selectedDecoration.copyWith(
          borderRadius:
              BorderRadius.only(bottomLeft: radius, bottomRight: radius),
        );
        break;
    }

    return InkWell(
      onTap: () => viewModel.onTapLangItem(context, language, position),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: viewModel.position == position
            ? selectedDecoration
            : BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(radius),
              ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${language.name}',
              style: AppStyle.text18B.copyWith(
                color: viewModel.position == position
                    ? AppColors.primary
                    : AppColors.textPrimary.withOpacity(0.5),
              ),
            ).tr(),
            if (viewModel.position == position)
              Image(image: R.svg.ic_successful(width: 22.47, height: 20.34))
          ],
        ),
      ),
    );
  }
}

enum LocaleItemViewPosition { Start, Middle, End }
