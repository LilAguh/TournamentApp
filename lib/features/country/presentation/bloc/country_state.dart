import 'package:tournament_app/features/country/domain/entities/country.dart';

abstract class CountryState {}

class CountryInitial extends CountryState {
  // Aca se pone todas las cosas que quiero que hagamos mientra inicia el estado de country
}

class CountryLoading extends CountryState {
  // Aca se pone lo que quiero que haga mientras carga
}

class CountrySuccess extends CountryState {
  // aca se pone lo que quiero que haga cuando se completa
  final List<Country> countries;
  CountrySuccess(this.countries);
}

class CountryFailure extends CountryState {
  // aca se pone lo que quiero que haga cuando falla
  final String message;
  CountryFailure(this.message);
}
