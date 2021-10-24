import 'package:estdict/domain/word.dart';

enum FormsGroupId { EST, RUS, ENG }

class FormsGroup {
  final FormsGroupId id;
  final WordFormType infinitive;
  final List<WordFormType> optionalForms;

  const FormsGroup(
      {required this.id,
      required this.infinitive,
      this.optionalForms = const []});

  List<WordFormType> get allForms {
    return [infinitive, ...optionalForms];
  }

  String get name {
    return _names[id]!;
  }
}

extension PartOfSpeechForms on PartOfSpeech {
  List<FormsGroup> get groupedForms {
    return _wordTypesForms[this]!;
  }
}

const _names = {
  FormsGroupId.RUS: "Russian forms",
  FormsGroupId.EST: "Estonian forms",
  FormsGroupId.ENG: "English forms",
};

const _wordTypesForms = {
  PartOfSpeech.NOUN: [
    FormsGroup(
        id: FormsGroupId.EST,
        infinitive: WordFormType.EST_INF,
        optionalForms: [
          WordFormType.EST_SINGULAR_SECOND,
          WordFormType.EST_SINGULAR_THIRD,
          WordFormType.EST_PLURAL_FIRST,
          WordFormType.EST_PLURAL_SECOND,
          WordFormType.EST_PLURAL_THIRD
        ]),
    FormsGroup(id: FormsGroupId.RUS, infinitive: WordFormType.RUS_INF),
    FormsGroup(id: FormsGroupId.ENG, infinitive: WordFormType.ENG_INF),
  ],
  PartOfSpeech.ADJECTIVE: [
    FormsGroup(
        id: FormsGroupId.EST,
        infinitive: WordFormType.EST_INF,
        optionalForms: [
          WordFormType.EST_SINGULAR_SECOND,
          WordFormType.EST_SINGULAR_THIRD,
          WordFormType.EST_PLURAL_FIRST,
          WordFormType.EST_PLURAL_SECOND,
          WordFormType.EST_PLURAL_THIRD
        ]),
    FormsGroup(id: FormsGroupId.RUS, infinitive: WordFormType.RUS_INF),
    FormsGroup(id: FormsGroupId.ENG, infinitive: WordFormType.ENG_INF),
  ],
  PartOfSpeech.VERB: [
    FormsGroup(
        id: FormsGroupId.EST,
        infinitive: WordFormType.EST_INF,
        optionalForms: [
          WordFormType.EST_DA_INF,
          WordFormType.EST_PRESENT_FIRST,
          WordFormType.EST_PAST_FIRST,
          WordFormType.EST_NUD,
          WordFormType.EST_TAKSE,
          WordFormType.EST_TUD
        ]),
    FormsGroup(id: FormsGroupId.RUS, infinitive: WordFormType.RUS_INF),
    FormsGroup(id: FormsGroupId.ENG, infinitive: WordFormType.ENG_INF),
  ]
};
