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

import 'package:easy_localization/src/public_ext.dart';
import 'package:easyenglish/core/config/error_messages.dart';
import 'package:easyenglish/core/models/book_entity.dart';
import 'package:easyenglish/core/models/user.dart';
import 'package:easyenglish/core/services/app_state_service.dart';
import 'package:easyenglish/generated/codegen_loader.g.dart';
import 'package:easyenglish/r.g.dart';
import 'package:easyenglish/ui/theme/color.dart';
import 'package:easyenglish/ui/theme/styles.dart';
import 'package:easyenglish/ui/widgets/error_view.dart';
import 'package:easyenglish/ui/widgets/stream_widget.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import 'dashboard_header_view_model.dart';

class DashboardHeader extends ViewModelBuilderWidget<DashboardHeaderViewModel> {
  @override
  Widget builder(
      BuildContext context, DashboardHeaderViewModel viewModel, Widget? child) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: size.width * -0.3,
            child: Image(image: R.image.img_4(), width: 316, height: 231),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: StreamWidget<Book>(
              stream: viewModel.book,
              done: (data) {
                if (data == null) 
                  return const ErrorView(message: ErrorMessages.SOMETHING_WENT_WRONG);
                  
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.book_book_title_n_level.tr(namedArgs: {
                        'title': data.title,
                        'level': '${data.level}'
                      }),
                      style: AppStyle.text38B,
                    ).tr(),
                    SizedBox(height: 16),
                    SizedBox(
                      width: size.width * 0.5,
                      height: 7,
                      child: LinearPercentIndicator(
                        lineHeight: 8,
                        percent: (data.bookStatus > 0
                            ? data.bookStatus / 100.0
                            : 0.01),
                        progressColor: AppColors.progressValue,
                        backgroundColor: AppColors.progressBackground,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      LocaleKeys.book_completed_percentage
                          .tr(namedArgs: {'percentage': '${data.bookStatus}'}),
                      style: AppStyle.text12SB,
                    ).tr(),
                    SizedBox(height: 24),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                StreamWidget<AppUser?>(
                                  stream: Provider.of<AppStateService>(context)
                                      .user,
                                  waiting: () => Text(
                                    LocaleKeys.dashboard_hi.tr(),
                                    style: AppStyle.text21SB,
                                  ),
                                  done: (data) => Text(
                                    LocaleKeys.dashboard_hi_name_get_started.tr(
                                        namedArgs: {
                                          'name':
                                              '${data?.profile?.firstName ?? ''}'
                                        }),
                                    style: AppStyle.text21SB,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  LocaleKeys.dashboard_greeting_1.tr(namedArgs: {'level': '${data.level}'}),
                                  style: AppStyle.text14R,
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: viewModel.onTapStart,
                            child: Container(
                              width: 69.0,
                              height: 69.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white,
                                      blurRadius: 5,
                                      spreadRadius: 3,
                                    )
                                  ]),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Image(
                                    image: R.svg
                                        .ic_play(width: 23.46, height: 31.24),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  DashboardHeaderViewModel viewModelBuilder(BuildContext context) =>
      DashboardHeaderViewModel(Provider.of(context));
}
