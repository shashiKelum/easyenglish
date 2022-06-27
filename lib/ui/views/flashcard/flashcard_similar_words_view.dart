import 'package:easy_localization/src/public_ext.dart';
import 'package:easyenglish/generated/codegen_loader.g.dart';
import 'package:easyenglish/ui/theme/styles.dart';
import 'package:easyenglish/ui/views/flashcard/flashcard_view_model.dart';
import 'package:easyenglish/ui/widgets/buttons/button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class FlashcardSimilarWordsView extends ViewModelWidget<FlashcardViewModel> {
  const FlashcardSimilarWordsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, FlashcardViewModel viewModel) {
    return Container(
      child: Column(
        children: [
          Text(
            LocaleKeys.flashcard_similar_terms.tr(),
            style: AppStyle.text25SB,
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 40,
            child: ListView.builder(
              itemCount: viewModel.term.similarTerms?.length ?? 0,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: Center(
                  child: Button(
                    height: 40,
                    width: null,
                    onTap: () => viewModel.onTapTerm(viewModel.term.similarTerms![index].id),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Center(
                        child: Text(
                          '${viewModel.term.similarTerms![index].englishTerm}',
                          style: AppStyle.text24SB,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
