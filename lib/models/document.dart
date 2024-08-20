class Document {
  final int id;
  final String name;
  final String url;
  final bool isSingedByPacient;

  Document({
    required this.id,
    required this.name,
    required this.url,
    required this.isSingedByPacient,
  });

  Document copyWith({
    int? id,
    String? name,
    String? url,
    bool? isSingedByPacient,
  }) {
    return Document(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      isSingedByPacient: isSingedByPacient ?? this.isSingedByPacient,
    );
  }
}
