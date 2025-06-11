import 'package:tournament_app/features/card/domain/entities/card.dart';

abstract class CardState {}

class CardInitial extends CardState {}

class CardLoading extends CardState {}

class CardLoaded extends CardState {
  final List<Card> cards;

  CardLoaded(this.cards);
}

class CardError extends CardState {
  final String message;

  CardError(this.message);
}
