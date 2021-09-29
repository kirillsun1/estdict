import 'package:estdict/domain/part_of_speech.dart';
import 'package:estdict/domain/word_form.dart';

enum FormsGroup { EST, RUS, ENG }

extension PartOfSpeechForms on PartOfSpeech {
  Map<FormsGroup, List<WordFormType>> get groupedForms {
    return _wordTypesForms[this]!;
  }
}

extension FormsGroupTranslations on FormsGroup {
  String get name {
    return _names[this]!;
  }
}

const _names = {
  FormsGroup.RUS: "Russian forms",
  FormsGroup.EST: "Estonian forms",
  FormsGroup.ENG: "English forms",
};

const _wordTypesForms = {
  PartOfSpeech.NOUN: {
    FormsGroup.EST: [
      WordFormType.EST_INF,
      WordFormType.EST_SINGULAR_SECOND,
      WordFormType.EST_SINGULAR_THIRD,
      WordFormType.EST_PLURAL_FIRST,
      WordFormType.EST_PLURAL_SECOND,
      WordFormType.EST_PLURAL_THIRD
    ],
    FormsGroup.RUS: [
      WordFormType.RUS_INF,
    ],
    FormsGroup.ENG: [
      WordFormType.ENG_INF,
    ]
  },
  PartOfSpeech.ADJECTIVE: {
    FormsGroup.EST: [
      WordFormType.EST_INF,
      WordFormType.EST_SINGULAR_SECOND,
      WordFormType.EST_SINGULAR_THIRD,
      WordFormType.EST_PLURAL_FIRST,
      WordFormType.EST_PLURAL_SECOND,
      WordFormType.EST_PLURAL_THIRD
    ],
    FormsGroup.RUS: [
      WordFormType.RUS_INF,
    ],
    FormsGroup.ENG: [
      WordFormType.ENG_INF,
    ]
  },
  PartOfSpeech.VERB: {
    FormsGroup.EST: [
      WordFormType.EST_INF,
      WordFormType.EST_DA_INF,
      WordFormType.EST_PRESENT_FIRST,
      WordFormType.EST_PAST_FIRST,
      WordFormType.EST_NUD,
      WordFormType.EST_TAKSE,
      WordFormType.EST_TUD
    ],
    FormsGroup.RUS: [
      WordFormType.RUS_INF,
    ],
    FormsGroup.ENG: [
      WordFormType.ENG_INF,
    ]
  }
};
