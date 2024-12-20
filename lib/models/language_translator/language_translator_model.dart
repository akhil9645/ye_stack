class LanguageModel {
  final String name;
  final String code;

  LanguageModel({required this.name, required this.code});

  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    return LanguageModel(
      name: json['name'] ?? '',
      code: json['language'],
    );
  }
}
