import 'package:tournament_app/features/card/domain/entities/card.dart';

abstract class CardRemoteDataSource {
  Future<List<Card>> getAllCards();
}
