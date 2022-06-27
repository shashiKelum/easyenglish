import 'package:easy_localization/src/public_ext.dart';
import 'package:easyenglish/core/enums/language.dart';
import 'package:easyenglish/generated/codegen_loader.g.dart';
import 'package:easyenglish/r.g.dart';
import 'package:easyenglish/ui/theme/color.dart';
import 'package:easyenglish/ui/theme/styles.dart';
import 'package:easyenglish/ui/widgets/buttons/app_bar_back_button.dart';
import 'package:easyenglish/ui/widgets/buttons/special_button.dart';
import 'package:easyenglish/ui/widgets/monkey_widget.dart';
import 'package:easyenglish/ui/widgets/progress/background_progress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import 'locale_item_view.dart';
import 'locale_view_model.dart';

class LocaleView extends ViewModelBuilderWidget<LocaleViewModel> {
  @override
  Widget builder(
      BuildContext context, LocaleViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBarBackButton(callback: viewModel.onClickBack),
        leadingWidth: 64,
        automaticallyImplyLeading: true,
      ),
      body: BackgroundProgress<LocaleViewModel>(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Easy English',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headline2
                            ?.copyWith(color: AppColors.textPrimary),
                      ),
                      SizedBox(height: 24),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: MonkeyWidget(
                          monkey: R.image.img_monkey_1(),
                          text:
                              'Please select your Primary\nLanguage to continue',
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          border:
                              Border.all(color: AppColors.border1, width: 2),
                          borderRadius:
                              BorderRadius.all(const Radius.circular(15)),
                        ),
                        child: Column(
                          children: [
                            LocaleItemView(
                              position: LocaleItemViewPosition.Start,
                              language: Language.English,
                            ),
                            LocaleItemView(
                              position: LocaleItemViewPosition.Middle,
                              language: Language.Sinhala,
                            ),
                            LocaleItemView(
                              position: LocaleItemViewPosition.End,
                              language: Language.Tamil,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: LocaleKeys.locale_already_have_account.tr(),
                              style: AppStyle.text18SB,
                            ),
                            TextSpan(
                              text: LocaleKeys.locale_login.tr(),
                              style: AppStyle.text18SB
                                  .copyWith(color: AppColors.primary),
                              recognizer: viewModel.onTapSignIn,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
              SpecialButton(onPressed: viewModel.onClickContinue),
            ],
          ),
        ),
      ),
    );
  }

  @override
  LocaleViewModel viewModelBuilder(BuildContext context) =>
      LocaleViewModel(Provider.of(context), Provider.of(context));
}
