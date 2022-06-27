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
import 'package:easyenglish/ui/views/register/register_view_model.dart';
import 'package:easyenglish/ui/widgets/buttons/app_bar_back_button.dart';
import 'package:easyenglish/ui/widgets/progress/background_progress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RegisterView extends ViewModelBuilderWidget<RegisterViewModel> {

  @override
  Widget builder(
      BuildContext context, RegisterViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBarBackButton(callback: viewModel.onClickBack),
        leadingWidth: 64,
        automaticallyImplyLeading: true,
      ),
      body: BackgroundProgress<RegisterViewModel>(
        child: SafeArea(
          child: ExtendedNavigator(
            router: RegisterViewRouter(),
            navigatorKey:
                StackedService.nestedNavigationKey(RegisterViewModel.navKey),
          ),
        ),
      ),
    );
  }

  @override
  RegisterViewModel viewModelBuilder(BuildContext context) =>
      RegisterViewModel(Provider.of(context), Provider.of(context));

  @override
  void onViewModelReady(RegisterViewModel viewModel) =>
      viewModel.getProviderAccount();
}
