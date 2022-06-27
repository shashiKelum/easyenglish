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
import 'package:easyenglish/core/config/error_messages.dart';
import 'package:easyenglish/core/enums/language.dart';
import 'package:easyenglish/core/models/term_entity.dart';
import 'package:easyenglish/r.g.dart';
import 'package:easyenglish/ui/theme/color.dart';
import 'package:easyenglish/ui/theme/styles.dart';
import 'package:easyenglish/ui/views/flashcard/flashcard_view_model.dart';
import 'package:easyenglish/ui/widgets/buttons/app_bar_back_button.dart';
import 'package:easyenglish/ui/widgets/buttons/button.dart';
import 'package:easyenglish/ui/widgets/error_view.dart';
import 'package:easyenglish/ui/widgets/stream_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import 'flashcard_similar_words_view.dart';

class FlashcardView extends ViewModelBuilderWidget<FlashcardViewModel> {
  final int termId;

  const FlashcardView({Key? key, required this.termId}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, FlashcardViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBarBackButton(callback: viewModel.onClickBack),
        leadingWidth: 64,
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: StreamWidget<Term>(
          stream: viewModel.termStream,
          waiting: () => Center(child: CircularProgressIndicator()),
          done: (data) {
            if (data == null)
              return ErrorView(message: ErrorMessages.SOMETHING_WENT_WRONG);

            return SingleChildScrollView(
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (data.image?.isNotEmpty ?? false)
                      AnimatedContainer(
                        width: 197,
                        height: 197,
                        duration: Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 14),
                            blurRadius: 40,
                            color: AppColors.shadow3,
                          ),
                        ]),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CachedNetworkImage(
                            key: UniqueKey(),
                            imageUrl: data.image!,
                            placeholder: (context, url) => Image(
                              image: BlurHashImage(data.imageBlurhash!),
                              fit: BoxFit.fitWidth,
                            ),
                            errorWidget: (context, url, error) => Image(
                              image: BlurHashImage(data.imageBlurhash!),
                              fit: BoxFit.fitWidth,
                            ),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    SizedBox(height: 24),
                    Text(
                      '${data.englishTerm}',
                      style: AppStyle.text60SB,
                    ),
                    if(data.audioClip != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 32, bottom: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Button(
                            width: 45.77,
                            height: 41.19,
                            color: AppColors.primary,
                            shadowColor: AppColors.primaryDark,
                            enabled: viewModel.speakerEnabled,
                            child: Center(
                              child: Image(
                                image: R.svg.ic_tortoise(width: 33.44, height: 16.67),
                              ),
                            ),
                            onTap: viewModel.onTapSpeed,
                          ),
                          SizedBox(width: 30),
                          Button(
                            width: 45.77,
                            height: 41.19,
                            color: AppColors.secondary,
                            shadowColor: AppColors.secondaryDark,
                            enabled: viewModel.speakerEnabled,
                            child: Center(
                              child: Image(
                                image: R.svg.ic_speaker(width: 25.76, height: 24.05),
                              ),
                            ),
                            onTap: viewModel.onTapSpeaker,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 28),
                    if (viewModel.language == Language.Sinhala)
                      Text(
                        '${data.sinhalaTerm}',
                        style: AppStyle.text37R,
                      ),
                    if (viewModel.language == Language.Tamil)
                      Text(
                        '${data.tamilTerm}',
                        style: AppStyle.text37R,
                      ),
                    if (data.similarTerms != null) Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: FlashcardSimilarWordsView(),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  FlashcardViewModel viewModelBuilder(BuildContext context) =>
      FlashcardViewModel(Provider.of(context), Provider.of(context), termId);
}
