enum PartOfSpeech { NOUN, ADJECTIVE, VERB }

const names = {
  PartOfSpeech.NOUN: "Noun",
  PartOfSpeech.ADJECTIVE: "Adjective",
  PartOfSpeech.VERB: "Verb",
};

extension PartOfSpeechTranslations on PartOfSpeech {
  String get name {
    return names[this]!;
  }
}
