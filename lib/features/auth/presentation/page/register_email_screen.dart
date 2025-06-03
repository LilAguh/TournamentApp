import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tournament_app/common/widgets/gothic_button.dart';
import 'package:tournament_app/common/widgets/gothic_text_field.dart';
import 'package:tournament_app/features/auth/presentation/register/bloc/register_bloc.dart';
import 'package:tournament_app/features/auth/presentation/register/bloc/register_event.dart';
import 'package:tournament_app/features/auth/presentation/register/bloc/register_state.dart';

class RegisterEmailScreen extends StatelessWidget {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _aliasController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordRepeatController =
      TextEditingController();

  RegisterEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.isSuccess) {
          // Navegar a la siguiente pantalla después de registro exitoso
          Navigator.of(context).pushReplacementNamed('/new-user-welcome');
        }

        if (state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          // Sincronizar controladores con el estado actual
          _firstNameController.text = state.firstName;
          _lastNameController.text = state.lastName;
          _aliasController.text = state.alias;
          _emailController.text = state.email;
          _passwordController.text = state.password;
          _passwordRepeatController.text = state.passwordRepeat;

          return Scaffold(
            backgroundColor: const Color(0xFF0D0D0D),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  // Título
                  const Text(
                    'Completa tus datos',
                    style: TextStyle(
                      color: Color(0xFFD6C8B0),
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Minion',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),

                  // Campo: Nombre
                  GothicTextField(
                    label: 'Nombre',
                    fieldName: 'nombre',
                    hasBeenValidated: state.validatedFields.contains('nombre'),
                    controller: _firstNameController,
                    onChanged:
                        (value) => context.read<RegisterBloc>().add(
                          RegisterFirstNameChanged(value),
                        ),
                    errorText: state.firstNameError,
                    isValid:
                        state.firstName.isNotEmpty &&
                        state.firstNameError == null,
                  ),
                  const SizedBox(height: 16),

                  // Campo: Apellido
                  GothicTextField(
                    label: 'Apellido',
                    fieldName: 'apellido',
                    hasBeenValidated: state.validatedFields.contains(
                      'apellido',
                    ),
                    controller: _lastNameController,
                    onChanged:
                        (value) => context.read<RegisterBloc>().add(
                          RegisterLastNameChanged(value),
                        ),
                    errorText: state.lastNameError,
                    isValid:
                        state.lastName.isNotEmpty &&
                        state.lastNameError == null,
                  ),
                  const SizedBox(height: 16),

                  // Campo: Alias
                  GothicTextField(
                    label: 'Alias',
                    fieldName: 'alias',
                    hasBeenValidated: state.validatedFields.contains('alias'),
                    controller: _aliasController,
                    onChanged:
                        (value) => context.read<RegisterBloc>().add(
                          RegisterAliasChanged(value),
                        ),
                    errorText: state.aliasError,
                    isValid: state.alias.isNotEmpty && state.aliasError == null,
                  ),
                  const SizedBox(height: 16),

                  // Campo: Email
                  GothicTextField(
                    label: 'Email',
                    fieldName: 'email',
                    hasBeenValidated: state.validatedFields.contains('email'),
                    controller: _emailController,
                    onChanged:
                        (value) => context.read<RegisterBloc>().add(
                          RegisterEmailChanged(value),
                        ),
                    errorText: state.emailError,
                  ),
                  const SizedBox(height: 16),

                  // Campo: Contraseña
                  GothicTextField(
                    label: 'Contraseña',
                    fieldName: 'contraseña',
                    obscureText: true,
                    hasBeenValidated: state.validatedFields.contains(
                      'contraseña',
                    ),
                    controller: _passwordController,
                    onChanged:
                        (value) => context.read<RegisterBloc>().add(
                          RegisterPasswordChanged(value),
                        ),
                    errorText: state.passwordError,
                    isValid:
                        state.password.isNotEmpty &&
                        state.passwordError == null,
                  ),
                  const SizedBox(height: 16),

                  // Campo: Repetir contraseña
                  GothicTextField(
                    label: 'Repetir contraseña',
                    fieldName: 'Repetir contraseña',
                    obscureText: true,
                    hasBeenValidated: state.validatedFields.contains(
                      'Repetir contraseña',
                    ),
                    controller: _passwordRepeatController,
                    onChanged:
                        (value) => context.read<RegisterBloc>().add(
                          RegisterPasswordRepeatChanged(value),
                        ),
                    errorText: state.passwordRepeatError,
                    isValid:
                        state.password.isNotEmpty &&
                        state.passwordError == null,
                  ),
                  const SizedBox(height: 30),

                  // Texto de requisitos de contraseña
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'La contraseña debe contener:\n'
                      '• Mínimo 8 caracteres\n'
                      '• Al menos 1 letra mayúscula\n'
                      '• Al menos 1 número\n'
                      '• Al menos 1 carácter especial (!@#\$%^&*)',
                      style: TextStyle(color: Color(0xFFD6C8B0), fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Botón de registro
                  GothicButton(
                    text: 'Registrarse',
                    onPressed: () {
                      // Solo enviar si no está cargando
                      if (!state.isLoading) {
                        context.read<RegisterBloc>().add(RegisterSubmitted());
                      }
                    },
                  ),

                  // Mostrar carga si está procesando
                  if (state.isLoading)
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFFB7D6B8),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
