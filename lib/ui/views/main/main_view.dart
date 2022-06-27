/*
 * Copyright 2021 CeylonCodeLabs. All rights reserved.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:easyenglish/core/config/router/router.router.dart';
import 'package:easyenglish/r.g.dart';
import 'package:easyenglish/ui/views/main/main_view_model.dart';
import 'package:easyenglish/ui/widgets/buttons/app_bar_back_button.dart';
import 'package:easyenglish/ui/widgets/buttons/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MainView extends ViewModelBuilderWidget<MainViewModel> {
  @override
  Widget builder(BuildContext context, MainViewModel viewModel, Widget? child) {
    return WillPopScope(
      onWillPop: viewModel.onWillPop,
      child: Scaffold(
        key: viewModel.scaffoldKey, 
        appBar: AppBar(
          leading: AppBarBackButton(callback: viewModel.onClickBack),
          leadingWidth: 64,
          automaticallyImplyLeading: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Center(
                child: Button(
                  onTap: () => viewModel.onTapLanguage(context),
                  child: Image(image: R.svg.ic_lang_si(width: 17.19, height: 18.81)),
                ),
              ),
            )
          ],
        ),
        body: ExtendedNavigator(
          router: MainViewRouter(),
          navigatorKey: StackedService.nestedNavigationKey(1),
        ),
        // bottomNavigationBar: CustomPaint(
        //   painter: BottomNavPainter(),
        //   child: ClipPath(
        //     clipper: BottomNavClipper(),
        //     child: Container(
        //       height: 70,
        //       color: Colors.white,
        //       padding: const EdgeInsets.only(top: 8),
        //       child: Center(
        //         child: Row(
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           mainAxisAlignment: MainAxisAlignment.spaceAround,
        //           children: viewModel.bottomNavItems,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ),
    );
  }

  @override
  MainViewModel viewModelBuilder(BuildContext context) => MainViewModel(
      Provider.of(context), Provider.of(context), Provider.of(context));
}
