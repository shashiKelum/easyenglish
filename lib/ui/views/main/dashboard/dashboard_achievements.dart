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
import 'package:easyenglish/ui/theme/styles.dart';
import 'package:easyenglish/ui/views/main/dashboard/dashboard_view_model.dart';
import 'package:easyenglish/ui/widgets/buttons/button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class DashboardAchievements extends ViewModelWidget<DashboardViewModel> {
  @override
  Widget build(BuildContext context, DashboardViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Achievements',
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
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final achievement = viewModel.achievements[index];
                return Container(
                  margin: EdgeInsets.only(
                    bottom: 8,
                    left: index == 0 ? 12 : 0,
                    right: index == viewModel.achievements.length ? 12 : 0,
                  ),
                  child: Button(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image(image: achievement.image),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: R.svg.ic_star(width: 16.25, height: 15.6),
                              color: achievement.shadow,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Image(
                                image:
                                    R.svg.ic_star(width: 16.25, height: 15.6),
                                color: achievement.shadow,
                              ),
                            ),
                            Image(
                              image: R.svg.ic_star(width: 16.25, height: 15.6),
                              color: achievement.shadow,
                            ),
                          ],
                        )
                      ],
                    ),
                    color: achievement.color,
                    shadowColor: achievement.shadow,
                    width: 68,
                    height: 87,
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(width: 12),
              itemCount: viewModel.achievements.length),
        ),
      ],
    );
  }
}
