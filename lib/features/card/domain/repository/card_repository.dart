import '../entities/card.dart';

abstract class CardRepository {
  Future<List<Card>> getAllCards();
}
