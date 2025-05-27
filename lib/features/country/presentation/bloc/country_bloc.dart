import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tournament_app/features/country/domain/use_cases/get_countries_use_cases.dart';
import 'country_event.dart';
import 'country_state.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  final GetCountriesUseCases getCountriesUseCases;

  CountryBloc({required this.getCountriesUseCases}) : super(CountryInitial()) {
    on<GetCountryRequested>(_onGetCountryRequested);
  }

  Future<void> _onGetCountryRequested(
    GetCountryRequested event,
    Emitter<CountryState> emit,
  ) async {
    emit(CountryLoading());

    try {
      emit(CountryLoading());

      final countries = await getCountriesUseCases();

      // Imprimir en consola
      print('Lista de países cargada (${countries.length}):');
      for (final c in countries) {
        print('${c.name} ${c.code}');
      }

      // Emitir estado
      emit(CountrySuccess(countries));
    } catch (e) {
      emit(CountryFailure('Error al cargar países'));
    }
  }
}
