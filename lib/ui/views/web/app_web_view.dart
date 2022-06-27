import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../ui/views/web/app_web_view_model.dart';
import '../../../ui/views/web/web_request_type.dart';

class AppWebView extends ViewModelBuilderWidget<AppWebViewModel> {
  final WebRequestType requestType;
  final String url;
  final String title;
  final bool withAppBar;

  const AppWebView(
      {Key? key,
      required this.requestType,
      required this.url,
      this.title = '',
      this.withAppBar = true})
      : super(key: key);

  @override
  Widget builder(BuildContext context, AppWebViewModel model, Widget? child) {
    var body = SafeArea(
      child: Stack(
        children: [
          InAppWebView(
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                javaScriptCanOpenWindowsAutomatically: true,
                javaScriptEnabled: true,
                // debuggingEnabled: true,
              ),
            ),
            onWebViewCreated: (controller) {
              model.controller.complete(controller);
            },
            // onLoadStart: (controller, String url) {
            //   print('onLoadStart: $url');
            //   model.progress = 0;
            // },
            // onLoadStop: (controller, String url) async {
            //   print('onLoadStop: $url');
            //   model.progress = -1;
            // },
            onProgressChanged: (controller, int progress) {
              print('progress: ${progress / 100}');
              model.progress = progress / 100;
            },
            // shouldOverrideUrlLoading:
            //     (controller, shouldOverrideUrlLoadingRequest) async {
            //   if (model.handleUrl(shouldOverrideUrlLoadingRequest.url))
            //     return ShouldOverrideUrlLoadingAction.CANCEL;
            //   return ShouldOverrideUrlLoadingAction.ALLOW;
            // },
          ),
          AnimatedOpacity(
            opacity: model.progress >= 0 ? 1 : 0,
            duration: Duration(milliseconds: 300),
            child: LinearProgressIndicator(value: model.progress),
          ),
        ],
      ),
    );

    if (withAppBar)
      return Scaffold(
        appBar: AppBar(
          title: Text('$title'),
        ),
        body: body,
      );
    else
      return body;
  }

  @override
  AppWebViewModel viewModelBuilder(BuildContext context) => AppWebViewModel(
      Provider.of(context), Provider.of(context), requestType, url);

  @override
  void onViewModelReady(AppWebViewModel model) => model.init();
}
