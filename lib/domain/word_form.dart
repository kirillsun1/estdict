import 'package:estdict/domain/word_type.dart';

enum WordFormType {
  // for noun + adjective
  EST_SINGULAR_FIRST,
  EST_SINGULAR_SECOND,
  EST_SINGULAR_THIRD,
  EST_PLURAL_FIRST,
  EST_PLURAL_SECOND,
  EST_PLURAL_THIRD,

  // for verbs
  EST_MA_INF,
  EST_DA_INF,
  EST_PRESENT_FIRST,
  EST_PAST_FIRST,
  EST_NUD,
  EST_TAKSE,
  EST_TUD,

  // russian
  RUS_INF,
}

enum Language { EST, RUS }

const wordTypesForms = {
  WordType.NOUN: {
    Language.EST: [
      WordFormType.EST_SINGULAR_FIRST,
      WordFormType.EST_SINGULAR_SECOND,
      WordFormType.EST_SINGULAR_THIRD,
      WordFormType.EST_PLURAL_FIRST,
      WordFormType.EST_PLURAL_SECOND,
      WordFormType.EST_PLURAL_THIRD
    ],
    Language.RUS: [
      WordFormType.RUS_INF,
    ]
  },
  WordType.ADJECTIVE: {
    Language.EST: [
      WordFormType.EST_SINGULAR_FIRST,
      WordFormType.EST_SINGULAR_SECOND,
      WordFormType.EST_SINGULAR_THIRD,
      WordFormType.EST_PLURAL_FIRST,
      WordFormType.EST_PLURAL_SECOND,
      WordFormType.EST_PLURAL_THIRD
    ],
    Language.RUS: [
      WordFormType.RUS_INF,
    ],
  },
  WordType.VERB: {
    Language.EST: [
      WordFormType.EST_MA_INF,
      WordFormType.EST_DA_INF,
      WordFormType.EST_PRESENT_FIRST,
      WordFormType.EST_PAST_FIRST,
      WordFormType.EST_NUD,
      WordFormType.EST_TAKSE,
      WordFormType.EST_TUD
    ],
    Language.RUS: [
      WordFormType.RUS_INF,
    ]
  }
};

class WordForm {
  final WordFormType formType;
  final String value;

  WordForm(this.formType, this.value);
}
