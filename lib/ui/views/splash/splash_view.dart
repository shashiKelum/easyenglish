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

import 'dart:math';

import 'package:easyenglish/r.g.dart';
import 'package:easyenglish/ui/theme/color.dart';
import 'package:easyenglish/ui/views/splash/splash_view_model.dart';
import 'package:easyenglish/ui/widgets/buttons/special_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class SplashView extends ViewModelBuilderWidget<SplashViewModel> {
  @override
  Widget builder(
      BuildContext context, SplashViewModel viewModel, Widget? child) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Stack(
        children: [
          Positioned(
            top: size.height * 0.1,
            right: size.width * -0.3,
            child: Transform.rotate(
              angle: 7.0 * pi / 180,
              child: Container(
                width: 381.78,
                height: 186.09,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: R.image.img_2(),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.3,
            left: 0,
            right: 0,
            child: Text(
              'Easy\nEnglish',
              style: Theme.of(context).textTheme.headline1?.copyWith(
                    height: 0.8,
                    color: Colors.white,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            bottom: size.height * 0.1,
            right: (MediaQuery.of(context).size.width / 2.8),
            child: Transform.rotate(
              angle: -9.0 * pi / 180,
              child: Container(
                width: 399.0,
                height: 256.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: R.image.img_1(),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: SpecialButton(
              text: 'Start Learning!',
              onPressed: viewModel.onClickStart,
            ),
          ),
        ],
      ),
    );
  }

  @override
  SplashViewModel viewModelBuilder(BuildContext context) =>
      SplashViewModel(Provider.of(context));
}
