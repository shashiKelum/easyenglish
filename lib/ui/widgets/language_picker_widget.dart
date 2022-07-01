import 'package:easyenglish/core/config/router/router.router.dart';
import 'package:easyenglish/ui/theme/color.dart';
import 'package:easyenglish/ui/theme/styles.dart';
import 'package:easyenglish/ui/views/locale/locale_view_model.dart';
import 'package:flutter/material.dart';
import 'package:easyenglish/assets/l10n/l10n.dart';
import 'package:easyenglish/provider/locale_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:easyenglish/r.g.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart' as ss;


class LanguageWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final flag = L10n.getFlag(locale.languageCode);

    return Center(
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 72,
        child: Text(
          flag,
          style: TextStyle(fontSize: 80),
        ),
      ),
    );
  }
}

class alreadyAccount extends StatelessWidget {
    final ss.NavigationService _navigationService = GetIt.I.get();
  //  LocaleViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    LocaleViewModel viewModel;
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale ?? Localizations.localeOf(context);
    return Padding(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          child: Column(
            children: <Widget>[
              // SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context)!.already_have_account,
                    style: AppStyle.text18SB,
                    textAlign: TextAlign.center,
                  ),                 
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[                  
                  TextButton(
                    child: Text(
                      AppLocalizations.of(context)!.login,
                      style: AppStyle.text18SB
                      .copyWith(color: AppColors.primary),
                    ),
                    onPressed: () async {
                      _navigationService.navigateTo(Routes.loginView);
                    },
                  )
              ]),
              
              
            ],
        ),
      );
    // RichText(
    //   textAlign: TextAlign.center,
    //   text: 
    //   TextSpan(
    //     children: [
    //       TextSpan(                              
    //         text: AppLocalizations.of(context)!.already_have_account,
    //         style: AppStyle.text18SB,
    //       ),
          
    //       TextSpan(
    //         text: AppLocalizations.of(context)!.login,
    //         style: AppStyle.text18SB
    //             .copyWith(color: AppColors.primary),
    //         recognizer: viewModel.onTapSignIn,
    //         // recognizer:  _navigationService.navigateTo(Routes.loginView);,
    //       ),  
                
    //     ],
        
    //   ),
    // );    
  }
}

class SelectLang extends StatefulWidget {

  @override
  _SelectLangState createState() => _SelectLangState();
  
}
class _SelectLangState extends State<SelectLang> {
  var setLan = '1';
  
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LocaleProvider>(context); 
  return Column(
    children: [
      InkWell(
        onTap: () => {
           provider =
            Provider.of<LocaleProvider>(context, listen: false),                           
        
        provider.setLocale(const Locale('en')),
        setState(() {
          setLan = '1';
        }),
        },
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: setLan == '1'
                ? BoxDecoration(
                  color: AppColors.primaryLight,
                  border: Border.all(color: AppColors.primary, width: 2),
                  borderRadius:BorderRadius.all(const Radius.circular(15)),
                )
                :const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(const Radius.circular(15)),
                ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'English',
                style: AppStyle.text18B.copyWith(
                  color: setLan == '1'
                      ? AppColors.primary
                      : AppColors.textPrimary.withOpacity(0.5),
                ),
              ),
              if (setLan == '1')
                Image(image: R.svg.ic_successful(width: 22.47, height: 20.34))
            ],
          ),
        ),
      ),
      InkWell(
        onTap: () => {
          provider =
            Provider.of<LocaleProvider>(context, listen: false),
        provider.setLocale(const Locale('si')),
         setState(() {
          setLan = '2';
        }),
        },
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration:  setLan == '2'
                ? BoxDecoration(
                  color: AppColors.primaryLight,
                  border: Border.all(color: AppColors.primary, width: 2),
                  borderRadius:BorderRadius.all(const Radius.circular(15)),
                )
                :BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(const Radius.circular(15)),
                ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'සිංහල',
                style: AppStyle.text18B.copyWith(
                  color:setLan == '2'
                      ? AppColors.primary
                      : AppColors.textPrimary.withOpacity(0.5),
                ),
              ),
              if ( setLan == '2')
                Image(image: R.svg.ic_successful(width: 22.47, height: 20.34))
            ],
          ),
        ),
      ),
      InkWell(
        onTap: () => {
          provider =
            Provider.of<LocaleProvider>(context, listen: false),
        provider.setLocale(const Locale('ta')),
         setState(() {
          setLan = '3';
        }),
        },
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: setLan == '3'
                ? BoxDecoration(
                  color: AppColors.primaryLight,
                  border: Border.all(color: AppColors.primary, width: 2),
                  borderRadius:BorderRadius.all(const Radius.circular(15)),
                )
                : BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(const Radius.circular(15)),
                ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'தமிழ்',
                style: AppStyle.text18B.copyWith(
                  color: setLan == '3'
                      ? AppColors.primary
                      : AppColors.textPrimary.withOpacity(0.5),
                ),
              ),
              if (setLan == '3')
                Image(image: R.svg.ic_successful(width: 22.47, height: 20.34))
            ],
          ),
        ),
      ),
    ]);
    
  }
}
