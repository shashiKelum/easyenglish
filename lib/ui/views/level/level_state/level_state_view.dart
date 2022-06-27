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

import 'package:easyenglish/core/enums/level_item_state.dart';
import 'package:easyenglish/ui/views/level/level_state/level_state_item.dart';
import 'package:flutter/material.dart';

class LevelStateView extends StatelessWidget {
  final List<LevelState> levelStateList;

  const LevelStateView({Key? key, required this.levelStateList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:
            levelStateList.map((e) => Expanded(child: LevelStateItem(levelState: e))).toList(),
      ),
    );
  }
}
