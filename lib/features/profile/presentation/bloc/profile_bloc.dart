import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tournament_app/features/profile/domain/use_cases/delete_account_use_case.dart';
import 'package:tournament_app/features/profile/domain/use_cases/desactivate_account_use_case.dart';
import 'package:tournament_app/features/profile/domain/use_cases/get_profile_use_case.dart';
import 'package:tournament_app/features/profile/domain/use_cases/update_profile_use_case.dart';
import 'package:tournament_app/features/profile/domain/use_cases/change_password_use_case.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfile;
  final UpdateProfileUseCase updateProfile;
  final DeactivateAccountUseCase deactivateAccount;
  final DeleteAccountUseCase deleteAccount;
  final ChangePasswordUseCase changePassword;
  final SharedPreferences prefs;

  ProfileBloc({
    required this.getProfile,
    required this.updateProfile,
    required this.deactivateAccount,
    required this.deleteAccount,
    required this.changePassword,
    required this.prefs,
  }) : super(const ProfileState()) {
    on<LoadProfile>(_onLoadProfile);
    on<UpdateProfileEvent>(_onUpdateProfile);
    on<DeactivateAccountEvent>(_onDeactivate);
    on<DeleteAccountEvent>(_onDelete);
    on<ChangePasswordEvent>(_onChangePassword);

    on<AliasChanged>((e, emit) => emit(state.copyWith(alias: e.alias)));
    on<EmailChanged>((e, emit) => emit(state.copyWith(email: e.email)));
    on<CountryCodeChanged>(
      (e, emit) => emit(state.copyWith(countryCode: e.countryCode)),
    );
    on<AvatarUrlChanged>(
      (e, emit) => emit(state.copyWith(avatarUrl: e.avatarUrl)),
    );
    on<CurrentPasswordChanged>(
      (e, emit) => emit(state.copyWith(currentPassword: e.currentPassword)),
    );
    on<NewPasswordChanged>(
      (e, emit) => emit(state.copyWith(newPassword: e.newPassword)),
    );
  }

  Future<void> _onLoadProfile(
    LoadProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final token = prefs.getString('authToken') ?? '';

    final result = await getProfile(userId: event.userId, token: token);
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (profile) => emit(
        state.copyWith(
          isLoading: false,
          profile: profile,
          alias: profile.alias,
          email: profile.email,
          countryCode: profile.countryCode,
          avatarUrl: profile.avatarUrl,
        ),
      ),
    );
  }

  Future<void> _onUpdateProfile(
    UpdateProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final token = prefs.getString('authToken') ?? '';
    final current = state.profile;

    if (current == null) {
      emit(state.copyWith(isLoading: false, errorMessage: 'Perfil no cargado'));
      return;
    }

    final updated = current.copyWith(
      alias: state.alias,
      email: state.email,
      countryCode: state.countryCode,
      avatarUrl: state.avatarUrl,
    );

    final result = await updateProfile(profile: updated, token: token);
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (_) => emit(
        state.copyWith(isLoading: false, profile: updated, success: true),
      ),
    );
  }

  Future<void> _onDeactivate(
    DeactivateAccountEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final token = prefs.getString('authToken') ?? '';

    final result = await deactivateAccount(userId: event.userId, token: token);
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (_) => emit(state.copyWith(isLoading: false, success: true)),
    );
  }

  Future<void> _onDelete(
    DeleteAccountEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final token = prefs.getString('authToken') ?? '';

    final result = await deleteAccount(userId: event.userId, token: token);
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (_) => emit(state.copyWith(isLoading: false, success: true)),
    );
  }

  Future<void> _onChangePassword(
    ChangePasswordEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final token = prefs.getString('authToken') ?? '';

    final result = await changePassword(
      userId: event.userId,
      newPassword: state.newPassword,
      password: state.currentPassword,
      token: token,
    );

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (_) => emit(state.copyWith(isLoading: false, success: true)),
    );
  }
}
