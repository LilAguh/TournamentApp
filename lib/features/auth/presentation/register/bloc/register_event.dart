abstract class RegisterEvent {}

class RegisterFirstNameChanged extends RegisterEvent {
  final String firstName;
  RegisterFirstNameChanged(this.firstName);
}

class RegisterLastNameChanged extends RegisterEvent {
  final String lastName;
  RegisterLastNameChanged(this.lastName);
}

class RegisterAliasChanged extends RegisterEvent {
  final String alias;
  RegisterAliasChanged(this.alias);
}

class RegisterEmailChanged extends RegisterEvent {
  final String email;
  RegisterEmailChanged(this.email);
}

class RegisterPasswordChanged extends RegisterEvent {
  final String password;
  RegisterPasswordChanged(this.password);
}

class RegisterPasswordRepeatChanged extends RegisterEvent {
  final String passwordRepeat;
  RegisterPasswordRepeatChanged(this.passwordRepeat);
}

class RegisterSubmitted extends RegisterEvent {
  final String firstName;
  final String lastName;
  final String alias;
  final String email;
  final String password;
  final String repeatPassword;

  RegisterSubmitted({
    required this.firstName,
    required this.lastName,
    required this.alias,
    required this.email,
    required this.password,
    required this.repeatPassword,
  });
}
