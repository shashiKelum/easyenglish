import 'package:easy_localization/src/public_ext.dart';
import 'package:easyenglish/core/config/router/router.router.dart';
import 'package:easyenglish/core/enums/auth_state.dart';
import 'package:easyenglish/core/enums/language.dart';
import 'package:easyenglish/core/services/app_state_service.dart';
import 'package:easyenglish/core/services/dialog_service/dialog_service.dart';
import 'package:easyenglish/core/services/dialog_service/dialogs/dialog_message.dart';
import 'package:easyenglish/generated/codegen_loader.g.dart';
import 'package:easyenglish/ui/views/locale/locale_item_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart' as ss;

class LocaleViewModel extends BaseViewModel {
  final ss.NavigationService _navigationService = GetIt.I.get();
  final AppStateService _appStateService;
  final DialogService _dialogService;
  final onTapSignIn = TapGestureRecognizer();

  LocaleItemViewPosition _position = LocaleItemViewPosition.Start;

  LocaleViewModel(this._appStateService, this._dialogService) {
    onTapSignIn.onTap = _onClickSignIn;
  }

  LocaleItemViewPosition get position => _position;

  set position(LocaleItemViewPosition position) {
    _position = position;
    notifyListeners();
  }

  void onClickContinue() async {
    if(!_validatePrimaryLanguage())
      return;

    await _appStateService.setAuthState(AuthState.None);
    await _appStateService.setUser(null);
    _navigationService.navigateTo(Routes.registerView);
  }

  void onClickBack() {
    _navigationService.back();
  } 

  onTapLangItem(BuildContext context, Language language,
      LocaleItemViewPosition position) {
    this.position = position;
    _appStateService.setLanguage(context, language);
  }

  void _onClickSignIn() async {
    if(!_validatePrimaryLanguage())
      return;

    await _appStateService.setAuthState(AuthState.None);
    await _appStateService.setUser(null);
    _navigationService.navigateTo(Routes.loginView);
  }

  bool _validatePrimaryLanguage() {
    if (position == null) {
      _dialogService.message(LocaleKeys.message_validate_primary_language.tr(), type: DialogType.Error);
      return false;
    } else
      return true;
  }
}
