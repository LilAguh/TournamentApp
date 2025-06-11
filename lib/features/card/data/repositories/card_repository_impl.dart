import 'package:tournament_app/features/card/domain/entities/card.dart';
import 'package:tournament_app/features/card/domain/repository/card_repository.dart';
import 'package:tournament_app/features/card/data/datasources/card_remote_data_source.dart';

class CardRepositoryImpl implements CardRepository {
  final CardRemoteDataSource remoteDataSource;

  CardRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Card>> getAllCards() {
    return remoteDataSource.getAllCards();
  }
}
