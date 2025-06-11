import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tournament_app/features/card/domain/use_cases/get_all_cards_use_case.dart';
import 'package:tournament_app/features/card/domain/entities/card.dart';
import 'card_event.dart';
import 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final GetAllCardsUseCase getAllCardsUseCase;

  CardBloc({required this.getAllCardsUseCase}) : super(CardInitial()) {
    on<GetAllCardsEvent>(_onGetAllCards);
  }

  Future<void> _onGetAllCards(
    GetAllCardsEvent event,
    Emitter<CardState> emit,
  ) async {
    emit(CardLoading());
    try {
      final List<Card> cards = await getAllCardsUseCase();
      emit(CardLoaded(cards));
    } catch (e) {
      emit(CardError('Error al cargar las cartas'));
    }
  }
}
