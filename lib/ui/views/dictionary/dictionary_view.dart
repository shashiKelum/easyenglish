import 'package:easyenglish/core/config/error_messages.dart';
import 'package:easyenglish/core/enums/language.dart';
import 'package:easyenglish/core/models/dictionary_entity.dart';
import 'package:easyenglish/core/models/term_entity.dart';
import 'package:easyenglish/r.g.dart';
import 'package:easyenglish/ui/theme/color.dart';
import 'package:easyenglish/ui/theme/styles.dart';
import 'package:easyenglish/ui/widgets/buttons/app_bar_back_button.dart';
import 'package:easyenglish/ui/widgets/buttons/button.dart';
import 'package:easyenglish/ui/widgets/error_view.dart';
import 'package:easyenglish/ui/widgets/future_widget.dart';
import 'package:easyenglish/ui/widgets/stream_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import 'dictionary_view_model.dart';

class DictionaryView extends ViewModelBuilderWidget<DictionaryViewModel> {
  final int? bookId;

  const DictionaryView({Key? key, this.bookId}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, DictionaryViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBarBackButton(callback: viewModel.onClickBack),
        leadingWidth: 64,
        automaticallyImplyLeading: true,
      ),
      body: StreamWidget<List<Dictionary>>(
        stream: viewModel.dictionary,
        done: (data) {
          if (data == null) {
            return ErrorView(message: ErrorMessages.SOMETHING_WENT_WRONG);
          }

          return Column(
            children: [
              SizedBox(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ListView.builder(
                    itemCount: data.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Button(
                            width: 46,
                            height: 46,
                            onTap: () => viewModel.onTapDictionary(index),
                            color: index == viewModel.selectedDictionaryIndex
                                ? AppColors.primary
                                : Colors.white,
                            child: Center(
                              child: Text(
                                '${data[index].letter}',
                                style: AppStyle.text33SB.copyWith(
                                  color:
                                      index == viewModel.selectedDictionaryIndex
                                          ? Colors.white
                                          : AppColors.textPrimary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: AppColors.border1,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Table(
                        border: TableBorder(
                          horizontalInside: BorderSide(
                            color: AppColors.border1,
                            width: 2,
                          ),
                        ),
                        columnWidths: {
                          0: IntrinsicColumnWidth(),
                          1: FlexColumnWidth(),
                          2: FixedColumnWidth(75),
                        },
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: data[viewModel.selectedDictionaryIndex]
                            .terms
                            .map(
                              (term) => TableRow(
                                children: [
                                  TableRowInkWell(
                                    onTap: () => viewModel.onTapTerm(term),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 24),
                                      child: Text(
                                        '${term.englishTerm}',
                                        style: AppStyle.text30SB,
                                      ),
                                    ),
                                  ),
                                  if (viewModel.language == Language.Sinhala)
                                    TableRowInkWell(
                                      onTap: () => viewModel.onTapTerm(term),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 24),
                                        child: Text(
                                          '${term.sinhalaTerm}',
                                          style: AppStyle.text30SB,
                                        ),
                                      ),
                                    ),
                                  if (viewModel.language == Language.Tamil)
                                    TableRowInkWell(
                                      onTap: () => viewModel.onTapTerm(term),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 24),
                                        child: Text(
                                          '${term.tamilTerm}',
                                          style: AppStyle.text30SB,
                                        ),
                                      ),
                                    ),
                                  if (viewModel.selectedTerm == null ||
                                      viewModel.selectedTerm?.id != term.id)
                                    SizedBox(width: 25.12, height: 23.45),
                                  if (viewModel.selectedTerm != null &&
                                      viewModel.selectedTerm!.id == term.id)
                                    SizedBox(
                                      width: 75,
                                      child: FutureWidget<Term>(
                                        future: viewModel.getTerm(term),
                                        waiting: () => Center(child: CircularProgressIndicator()),
                                        done: (data) {
                                          return IconButton(
                                            onPressed: () =>
                                                viewModel.onTapSpeaker(data),
                                            icon: Image(
                                              image: R.svg.ic_speaker(
                                                  width: 25.12, height: 23.45),
                                              color: AppColors.primary,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  DictionaryViewModel viewModelBuilder(BuildContext context) =>
      DictionaryViewModel(bookId, Provider.of(context), Provider.of(context));
}
