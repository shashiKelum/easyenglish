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

import 'package:easy_localization/src/public_ext.dart';
import 'package:easyenglish/core/models/book_entity.dart';
import 'package:easyenglish/generated/codegen_loader.g.dart';
import 'package:easyenglish/ui/theme/styles.dart';
import 'package:easyenglish/ui/views/main/dashboard/books/dashboard_book_item.dart';
import 'package:easyenglish/ui/views/main/dashboard/books/dashboard_books_view_model.dart';
import 'package:easyenglish/ui/widgets/stream_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class DashboardBooksView
    extends ViewModelBuilderWidget<DashboardBooksViewModel> {
  @override
  Widget builder(
      BuildContext context, DashboardBooksViewModel viewModel, Widget? child) {
    return StreamWidget<List<Book>?>(
      stream: viewModel.books,
      waiting: () => Container(),
      done: (data) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LocaleKeys.book_reading_list.tr(),
                    style: AppStyle.text24SB,
                  ),
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: Image(
                  //     image: R.svg.ic_arrow_right(width: 23.85, height: 19.84),
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(height: 12),
            ListView.separated(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => DashboardBookItem(
                  index, data!.length, data[index], viewModel.onTapBook),
              separatorBuilder: (context, index) => SizedBox(height: 12),
              itemCount: data?.length ?? 0,
              primary: false,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            ),
          ],
        );
      },
    );
  }

  @override
  DashboardBooksViewModel viewModelBuilder(BuildContext context) =>
      DashboardBooksViewModel(Provider.of(context));
}
