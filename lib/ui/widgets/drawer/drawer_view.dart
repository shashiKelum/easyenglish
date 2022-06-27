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

import 'package:easyenglish/core/enums/account_type.dart';
import 'package:easyenglish/core/enums/drawer_items.dart';
import 'package:easyenglish/core/services/app_state_service.dart';
import 'package:easyenglish/ui/widgets/drawer/drawer_item.dart';
import 'package:easyenglish/ui/widgets/drawer/drawer_view_model.dart';
import 'package:easyenglish/ui/widgets/stream_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class DrawerView extends ViewModelBuilderWidget<DrawerViewModel> {
  @override
  Widget builder(
      BuildContext context, DrawerViewModel viewModel, Widget? child) {
    return Drawer(
      child: SafeArea(
        child: SingleChildScrollView(
          child: StreamWidget<AccountType>(
            stream: Provider.of<AppStateService>(context, listen: false)
                .accountType,
            done: (data) => Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DrawerItem(
                  item: DrawerItems.Salons,
                  itemCallback: viewModel.onItemClick,
                ),
                DrawerItem(
                  item: DrawerItems.Professionals,
                  itemCallback: viewModel.onItemClick,
                ),
                if (data == AccountType.Student)
                  DrawerItem(
                    item: DrawerItems.Customers,
                    itemCallback: viewModel.onItemClick,
                  ),
                DrawerItem(
                  item: DrawerItems.Vacancies,
                  itemCallback: viewModel.onItemClick,
                ),
                DrawerItem(
                  item: DrawerItems.Promotions,
                  itemCallback: viewModel.onItemClick,
                ),
                if (data == AccountType.Student)
                  DrawerItem(
                    item: DrawerItems.RequestLoan,
                    itemCallback: viewModel.onItemClick,
                  ),
                if (data == AccountType.Student)
                  DrawerItem(
                    item: DrawerItems.RequestTraining,
                    itemCallback: viewModel.onItemClick,
                  ),
                if (data == AccountType.Student)
                  DrawerItem(
                    item: DrawerItems.PromoteSalon,
                    itemCallback: viewModel.onItemClick,
                  ),
                if (data == AccountType.Student)
                  DrawerItem(
                    item: DrawerItems.UpgradeSalon,
                    itemCallback: viewModel.onItemClick,
                  ),
                if (data == AccountType.Student)
                  DrawerItem(
                    item: DrawerItems.ManagementSoftware,
                    itemCallback: viewModel.onItemClick,
                  ),
                Divider(),
                DrawerItem(
                  item: DrawerItems.About,
                  itemCallback: viewModel.onItemClick,
                ),
                DrawerItem(
                  item: DrawerItems.Privacy,
                  itemCallback: viewModel.onItemClick,
                ),
                DrawerItem(
                  item: DrawerItems.Terms,
                  itemCallback: viewModel.onItemClick,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  DrawerViewModel viewModelBuilder(BuildContext context) => DrawerViewModel();
}
