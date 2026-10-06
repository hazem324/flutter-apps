class LanguageModel {
  final int id;
  final String flag;
  final String name;
  final String languageCode;

  LanguageModel(this.id, this.flag, this.name, this.languageCode);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanguageModel &&
          runtimeType == other.runtimeType &&
          languageCode == other.languageCode;

  @override
  int get hashCode => languageCode.hashCode;

  static List<LanguageModel> languageList() {
    return <LanguageModel>[
      LanguageModel(1, "🇺🇸", "English", "en"),
      LanguageModel(2, "🇫🇷", "Francais", "fr"),
      
    ];
  }
}