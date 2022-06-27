import 'dart:async';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:stacked/stacked.dart';

import '../../../core/config/application.dart';
import '../../../core/services/authentication_service.dart';
import '../../../core/services/dialog_service/dialog_service.dart';
import 'web_request_type.dart';

class AppWebViewModel extends BaseViewModel {
  final AuthenticationService _authService;
  final DialogService _dialogService;
  final WebRequestType requestType;
  final String url;
  final Completer<InAppWebViewController> controller =
      Completer<InAppWebViewController>();

  AppWebViewModel(
      this._authService, this._dialogService, this.requestType, this.url);

  double _progress = -1;

  double get progress => _progress;

  set progress(double progress) {
    _progress = progress;
    notifyListeners();
  }

  void init() async {
    var headers = await getHeaders();
    controller.future.then((value) {
      value.loadUrl(
        urlRequest: URLRequest(
            url: Uri.parse(url), headers: headers as Map<String, String>?),
      );
    });
  }

  Future<Map<String, String?>> getHeaders() async {
    if (requestType != WebRequestType.Checkout) return {};
    var user = await _authService.getUser();
    return {
      'x-authorization': Application.authKey,
      'authentication': 'Bearer ${user?.token}',
    };
  }

  bool handleUrl(String url) {
    // if (requestType == WebRequestType.Checkout) {
    //   var params = Uri.parse(url).queryParameters;
    //   var transNo = params != null && params.containsKey('transaction_no')
    //       ? params['transaction_no']
    //       : null;
    //   if (url.contains(Constants.checkoutSuccess)) {
    //     var message = params != null && params.containsKey('message')
    //         ? params['message']
    //         : 'Your payment has been successfully received.';
    //     _dialogService.message(
    //       transNo != null ? '$message\n\nTransaction No: $transNo' : message,
    //       title: 'Thank You',
    //       type: DialogType.Success,
    //       dismissible: false,
    //       positiveCallback: (val) => _onClickOk(true, transNo),
    //     );
    //     return true;
    //   } else if (url.contains(Constants.checkoutFailed)) {
    //     var message = params != null && params.containsKey('message')
    //         ? params['message']
    //         : 'Your payment not received.';
    //     _dialogService.message(
    //       transNo != null ? '$message\n\nTransaction No: $transNo' : message,
    //       title: 'Sorry!',
    //       type: DialogType.Error,
    //       dismissible: false,
    //       positiveCallback: (val) => _onClickOk(false, transNo),
    //     );
    //     return true;
    //   }
    // }

    return false;
  }

  void _onClickOk(bool result, String transNo) {
    // switch (requestType) {
    //   case WebRequestType.Checkout:
    //     ExtendedNavigator.root
    //         .popUntil((route) => route.settings.name == Routes.checkoutView);
    //     break;
    //   default:
    //     ExtendedNavigator.root
    //         .popUntil((route) => route.settings.name == Routes.appWebView);
    //     break;
    // }
  }
}
