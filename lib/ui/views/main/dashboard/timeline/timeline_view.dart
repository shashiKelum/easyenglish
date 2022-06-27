import 'package:easyenglish/r.g.dart';
import 'package:easyenglish/ui/views/main/dashboard/timeline/timeline_item_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'timeline_view_model.dart';

class TimelineView extends ViewModelBuilderWidget<TimelineViewModel> {
  const TimelineView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, TimelineViewModel viewModel, Widget? child) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          TimelineItemView(
            level: 1,
            unit: 1,
            title: 'Unit 01',
            description: 'Phonic Alphabet\n& Letter Names',
            image: R.svg.img_polygon(width: 350, height: 350),
            textAlignment: Alignment.centerRight,
            callback: viewModel.onTapUnit,
          ),
          TimelineItemView(
            level: 1,
            unit: 2,
            title: 'Unit 02',
            description: 'Word Construction\n& Decoding',
            image: R.svg.img_ellipse(width: 125, height: 125),
            textAlignment: Alignment.centerLeft,
            callback: viewModel.onTapUnit,
          ),
          TimelineItemView(
            level: 2,
            unit: 1,
            title: 'Unit 01',
            description: 'Wordbook\n& Story',
            image: R.svg.img_rectangle(width: 150, height: 150),
            textAlignment: Alignment.centerRight,
            callback: viewModel.onTapUnit,
          ),
          TimelineItemView(
            level: 2,
            unit: 2,
            title: 'Unit 02',
            description: 'Wordbook\n& Story',
            image: R.svg.img_triangle(width: 200, height: 200),
            textAlignment: Alignment.centerLeft,
            callback: viewModel.onTapUnit,
          ),
          TimelineItemView(
            level: 2,
            unit: 3,
            title: 'Unit 03',
            description: 'Phonic Alphabet\n& Letter Names',
            image: R.svg.img_polygon(width: 350, height: 350),
            textAlignment: Alignment.centerRight,
            callback: viewModel.onTapUnit,
          ),
        ],
      ),
    );
  }

  @override
  TimelineViewModel viewModelBuilder(BuildContext context) =>
      TimelineViewModel();
}
