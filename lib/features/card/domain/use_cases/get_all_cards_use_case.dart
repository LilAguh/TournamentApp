import '../entities/card.dart';
import '../repository/card_repository.dart';

class GetAllCardsUseCase {
  final CardRepository repository;

  GetAllCardsUseCase(this.repository);

  Future<List<Card>> call() {
    return repository.getAllCards();
  }
}
