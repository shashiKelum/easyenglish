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

import 'package:easyenglish/r.g.dart';
import 'package:easyenglish/ui/theme/color.dart';
import 'package:easyenglish/ui/views/book/views/pages/page/book_page_view_model.dart';
import 'package:easyenglish/ui/widgets/stream_widget.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class BookPageAudioControllerView extends ViewModelWidget<BookPageViewModel> {
  const BookPageAudioControllerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, BookPageViewModel viewModel) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary.withOpacity(0.2),
            spreadRadius: 10,
            blurRadius: 30,
          ),
        ],
      ),
      child: StreamWidget<Duration>(
        stream: viewModel.audioProgress,
        done: (progress) {
          return StreamWidget<ProcessingState>(
            stream: viewModel.player.processingStateStream,
            initialValue: ProcessingState.idle,
            done: (state) => SfSliderTheme(
              data: SfSliderThemeData(
                thumbColor: (state == ProcessingState.ready)
                    ? AppColors.secondary
                    : AppColors.primary,
                thumbRadius: 23,
                thumbStrokeWidth: 4,
                activeTrackHeight: 11,
                inactiveTrackHeight: 11,
                thumbStrokeColor: (state == ProcessingState.ready)
                    ? AppColors.secondary
                    : AppColors.primary,
                activeTrackColor: (state == ProcessingState.ready)
                    ? AppColors.secondary
                    : AppColors.primary,
                inactiveTrackColor: AppColors.secondary.withOpacity(0.1),
              ),
              child: SfSlider(
                max: viewModel.audioLength,
                value: progress!.inMilliseconds,
                minorTicksPerInterval: 1,
                stepSize: 1.0,
                thumbIcon: Center(
                  child: InkWell(
                    child: (state == ProcessingState.ready)
                        ? Image(
                            image: R.svg.ic_pause(width: 45, height: 45),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Image(
                              image: R.svg.ic_play(width: 16, height: 21),
                              fit: BoxFit.fill,
                              color: Colors.white,
                            ),
                          ),
                    onTap: viewModel.onTapSliderThumb,
                  ),
                ),
                onChanged: (value) => viewModel.onChangeSlider(value),
              ),
            ),
          );
        },
      ),
    );
  }
}
