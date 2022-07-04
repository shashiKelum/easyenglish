import 'package:easy_localization/src/public_ext.dart';
import 'package:easyenglish/assets/l10n/l10n.dart';
import 'package:easyenglish/core/enums/language.dart';
import 'package:easyenglish/generated/codegen_loader.g.dart';
import 'package:easyenglish/main.dart';
import 'package:easyenglish/provider/locale_provider.dart';
import 'package:easyenglish/r.g.dart';
import 'package:easyenglish/ui/theme/color.dart';
import 'package:easyenglish/ui/theme/styles.dart';
import 'package:easyenglish/ui/widgets/buttons/app_bar_back_button.dart';
import 'package:easyenglish/ui/widgets/buttons/special_button.dart';
import 'package:easyenglish/ui/widgets/language_picker_widget.dart';
import 'package:easyenglish/ui/widgets/monkey_widget.dart';
import 'package:easyenglish/ui/widgets/progress/background_progress.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'locale_item_view.dart';
import 'locale_view_model.dart';


class LocaleView extends ViewModelBuilderWidget<LocaleViewModel> {
  
  @override
  Widget builder(
      BuildContext context, LocaleViewModel viewModel, Widget? child) {
            var provider = Provider.of<LocaleProvider>(context);
            final locale = provider.locale ?? Localizations.localeOf(context);
            var tapPosition = 'en';

    return Scaffold(
      appBar: AppBar(
        leading: AppBarBackButton(callback: viewModel.onClickBack),
        leadingWidth: 64,
        automaticallyImplyLeading: true,
        // actions: [
        //     LanguagePickerWidget(),
        //     const SizedBox(width: 12),
        //   ],
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
                        child: SelectLang(),                        
                      ),                      
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          border:
                              Border.all(color: AppColors.border1, width: 2),
                          borderRadius:
                              BorderRadius.all(const Radius.circular(15)),
                        ),                       
                      ),
                      SizedBox(height: 24),
                      
                      alreadyAccount(),

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
