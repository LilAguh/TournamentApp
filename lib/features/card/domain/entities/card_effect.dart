class CardEffect {
  final String id;
  final Map<String, String> description;

  CardEffect({required this.id, required this.description});

  factory CardEffect.fromJson(Map<String, dynamic> json) {
    return CardEffect(
      id: json['id'],
      description: Map<String, String>.from(json['description']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'description': description};
  }
}
