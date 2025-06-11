import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:tournament_app/features/card/domain/entities/card.dart';
import 'card_remote_data_source.dart';

class CardRemoteDataSourceImpl implements CardRemoteDataSource {
  @override
  Future<List<Card>> getAllCards() async {
    // Simula una respuesta de backend
    final String jsonString = await rootBundle.loadString(
      'assets/json/tarot_cartas_completas.json',
    );
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((e) => Card.fromJson(e)).toList();
  }
}
