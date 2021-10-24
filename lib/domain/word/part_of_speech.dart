enum PartOfSpeech { NOUN, ADJECTIVE, VERB }

extension PartOfSpeechTranslations on PartOfSpeech {
  String get name {
    return _names[this]!;
  }
}

const _names = {
  PartOfSpeech.NOUN: "Noun",
  PartOfSpeech.ADJECTIVE: "Adjective",
  PartOfSpeech.VERB: "Verb",
};
