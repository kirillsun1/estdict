enum WordFormType {
  // Main forms. Might have different name depending on the word type.
  EST_INF,
  RUS_INF,
  ENG_INF,

  // Additional forms below:
  //
  // for noun + adjective
  EST_SINGULAR_SECOND,
  EST_SINGULAR_THIRD,
  EST_PLURAL_FIRST,
  EST_PLURAL_SECOND,
  EST_PLURAL_THIRD,

  // for verbs
  EST_DA_INF,
  EST_PRESENT_FIRST,
  EST_PAST_FIRST,
  EST_NUD,
  EST_TAKSE,
  EST_TUD,
}

extension WordFormTypeMetaAndTranslations on WordFormType {
  String get name {
    return _names[this]!;
  }
}

const _names = {
  WordFormType.EST_INF: "Infinitiiv",
  WordFormType.RUS_INF: "Infinitiiv",
  WordFormType.ENG_INF: "Infinitiiv",
  WordFormType.EST_SINGULAR_SECOND: "Omastav (ainsus)",
  WordFormType.EST_SINGULAR_THIRD: "Osastav (ainsus)",
  WordFormType.EST_PLURAL_FIRST: "Infinitiiv (mitmus)",
  WordFormType.EST_PLURAL_SECOND: "Omastav (mitmus)",
  WordFormType.EST_PLURAL_THIRD: "Osastav (mitmus)",
  WordFormType.EST_DA_INF: "da-tegevusnimi",
  WordFormType.EST_PRESENT_FIRST: "kindel olevik (ma)",
  WordFormType.EST_PAST_FIRST: "kindel minevik (ma)",
  WordFormType.EST_NUD: "nud-kesksõna",
  WordFormType.EST_TAKSE: "umbisikuline form (-takse)",
  WordFormType.EST_TUD: "tud-kesksõna",
};
