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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:easyenglish/core/methods/typedefs.dart';
import 'package:easyenglish/core/models/book_entity.dart';
import 'package:easyenglish/generated/codegen_loader.g.dart';
import 'package:easyenglish/r.g.dart';
import 'package:easyenglish/ui/theme/color.dart';
import 'package:easyenglish/ui/theme/styles.dart';
import 'package:easyenglish/ui/views/main/dashboard/books/dashboard_books_view_model.dart';
import 'package:easyenglish/ui/widgets/buttons/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_support_pack/flutter_support_pack.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:stacked/stacked.dart';

class DashboardBookItem extends ViewModelWidget<DashboardBooksViewModel> {
  final int index;
  final int length;
  final Book book;
  final Callback<Book> callback;

  DashboardBookItem(this.index, this.length, this.book, this.callback);

  @override
  Widget build(BuildContext context, DashboardBooksViewModel viewModel) {
    return InkWell(
      onTap: () => callback(book),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Button(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    key: UniqueKey(),
                    imageUrl: book.image,
                    placeholder: (context, url) => Image(
                      image: BlurHashImage(book.imageBlurHash),
                      fit: BoxFit.cover,
                    ),
                    fit: BoxFit.cover,
                  ),
                  if (book.subscribe == 0)
                    Container(
                      color: AppColors.bookDisabled,
                      child: Center(
                        child: Image(
                          image: R.svg.ic_padlock(width: 17.16, height: 23.73),
                        ),
                      ),
                    ),
                ],
              ),
              width: 68,
              height: 100,
              color: book.primaryColor.color,
              shadowColor: book.secondaryColor.color,
              disabledShadowColor: book.secondaryColor.color,
              enabled: book.subscribe == 1,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(book.title, style: AppStyle.text16B),
                    SizedBox(height: 12),
                    Text(LocaleKeys.book_listening.tr(),
                        style: AppStyle.text10SB),
                    Row(
                      children: [
                        Expanded(
                          child: LinearPercentIndicator(
                            lineHeight: 8,
                            percent:
                                (book.listen > 0 ? book.listen / 100.0 : 0.01),
                            progressColor: AppColors.progressValue,
                            backgroundColor: AppColors.progressBackground,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                            LocaleKeys.book_completed_percentage.tr(
                                namedArgs: {'percentage': '${book.listen}'}),
                            style: AppStyle.text10SB),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(LocaleKeys.book_speaking.tr(),
                        style: AppStyle.text10SB),
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: LinearPercentIndicator(
                              lineHeight: 8,
                              percent: (book.speaking > 0
                                  ? book.speaking / 100.0
                                  : 0.01),
                              progressColor: AppColors.progressValue,
                              backgroundColor: AppColors.progressBackground,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                            LocaleKeys.book_completed_percentage.tr(
                                namedArgs: {'percentage': '${book.speaking}'}),
                            style: AppStyle.text10SB),
                      ],
                    ),
                    // SizedBox(height: 8),
                    // Row(
                    //   children: [
                    //     Text('Grammar', style: AppStyle.text10SB),
                    //     Expanded(
                    //       child: Padding(
                    //         padding: const EdgeInsets.symmetric(horizontal: 8),
                    //         child: ClipRRect(
                    //           borderRadius: BorderRadius.circular(8),
                    //           child: LinearPercentIndicator(
                    //             lineHeight: 8,
                    //             percent: (book.grammer > 0
                    //                 ? book.grammer / 100.0
                    //                 : 0.01),
                    //             progressColor: AppColors.progressValue,
                    //             backgroundColor: AppColors.progressBackground,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     Text('${book.grammer}% Completed',
                    //         style: AppStyle.text10SB),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
