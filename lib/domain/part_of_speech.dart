enum PartOfSpeech { NOUN, ADJECTIVE, VERB }

String translatePartOfSpeech(PartOfSpeech wordType) {
  switch (wordType) {
    case PartOfSpeech.NOUN:
      return "Noun";

    case PartOfSpeech.ADJECTIVE:
      return "Adjective";

    case PartOfSpeech.VERB:
      return "Verb";
  }
}
