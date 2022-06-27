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

import 'package:easyenglish/ui/views/main/dashboard/dashboard_view_model.dart';
import 'package:easyenglish/ui/views/main/dashboard/header/dashboard_header.dart';
import 'package:easyenglish/ui/views/main/dashboard/songs/dashboard_songs_view.dart';
import 'package:easyenglish/ui/views/main/dashboard/timeline/timeline_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import 'books/dashboard_books_view.dart';

class DashboardView extends ViewModelBuilderWidget<DashboardViewModel> {
  @override
  Widget builder(
      BuildContext context, DashboardViewModel viewModel, Widget? child) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16),
            DashboardHeader(),
            // SizedBox(height: 16),
            // DashboardAchievements(),
            SizedBox(height: 16),
            TimelineView(),
            SizedBox(height: 16),
            DashboardBooksView(),
            // SizedBox(height: 16),
            // DashboardSongsView(),
          ],
        ),
      ),
      // child: CustomScrollView(
      //   slivers: [
      //     SliverList(
      //       delegate: SliverChildListDelegate(
      //         [
      //           SizedBox(height: 16),
      //           DashboardHeader(),
      //           SizedBox(height: 16),
      //           DashboardAchievements(),
      //           SizedBox(height: 16),
      //           DashboardBooksView(),
      //           SizedBox(height: 16),
      //           DashboardSongsView(),
      //         ],
      //       ),
      //     ),
      //     // SliverPadding(
      //     //   padding: const EdgeInsets.symmetric(horizontal: 16),
      //     //   sliver: DashboardBooksView(),
      //     // )
      //   ],
      // ),
    );
  }

  @override
  DashboardViewModel viewModelBuilder(BuildContext context) =>
      DashboardViewModel(Provider.of(context));

  @override
  bool get reactive => false;
}
