import 'package:tournament_app/features/card/domain/entities/card_effect.dart';

class Card {
  final String id;
  final Map<String, String> name;
  final Map<String, String> description;
  final String type;
  final String species;
  final String arcana;
  final String series;
  final int attack;
  final int defense;
  final CardEffect effect;
  final String image;

  Card({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.species,
    required this.arcana,
    required this.series,
    required this.attack,
    required this.defense,
    required this.effect,
    required this.image,
  });

  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(
      id: json['id'],
      name: Map<String, String>.from(json['name']),
      description: Map<String, String>.from(json['description']),
      type: json['type'],
      species: json['species'],
      arcana: json['arcana'],
      series: json['series'],
      attack: json['attack'],
      defense: json['defense'],
      effect: CardEffect.fromJson(json['effect']),
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'type': type,
      'species': species,
      'arcana': arcana,
      'series': series,
      'attack': attack,
      'defense': defense,
      'effect': effect.toJson(),
      'image': image,
    };
  }
}
