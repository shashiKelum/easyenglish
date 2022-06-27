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

import 'package:easyenglish/core/models/song_entity.dart';
import 'package:easyenglish/r.g.dart';
import 'package:easyenglish/ui/theme/styles.dart';
import 'package:easyenglish/ui/views/main/dashboard/songs/dashboard_songs_view_model.dart';
import 'package:easyenglish/ui/widgets/buttons/button.dart';
import 'package:easyenglish/ui/widgets/stream_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class DashboardSongsView
    extends ViewModelBuilderWidget<DashboardSongsViewModel> {
  @override
  Widget builder(
      BuildContext context, DashboardSongsViewModel viewModel, Widget? child) {
    return StreamWidget<List<Song>?>(
      stream: viewModel.songs,
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
                    'Songs in English',
                    style: AppStyle.text24SB,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Image(
                      image: R.svg.ic_arrow_right(width: 23.85, height: 19.84),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 100,
              child: data == null
                  ? Text('empty')
                  : ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final song = data[index];
                        return Container(
                          margin: EdgeInsets.only(
                            bottom: 8,
                            left: index == 0 ? 12 : 0,
                            right: index == data.length ? 12 : 0,
                          ),
                          child: Button(
                            child: Center(
                              child: SizedBox(
                                width: 45,
                                height: 45,
                                child: Image.network(song.icon),
                              ),
                            ),
                            color: viewModel.songss[0].color,
                            shadowColor: viewModel.songss[0].shadow,
                            width: 68,
                            height: 87,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(width: 12),
                      itemCount: data.length,
                    ),
            ),
          ],
        );
      },
    );
  }

  @override
  DashboardSongsViewModel viewModelBuilder(BuildContext context) =>
      DashboardSongsViewModel(Provider.of(context));
}
