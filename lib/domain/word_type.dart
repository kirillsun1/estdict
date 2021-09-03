enum WordType { NOUN, ADJECTIVE, VERB }

String translateWordType(WordType wordType) {
  switch (wordType) {
    case WordType.NOUN:
      return "Noun";

    case WordType.ADJECTIVE:
      return "Adjective";

    case WordType.VERB:
      return "Verb";
  }
}
