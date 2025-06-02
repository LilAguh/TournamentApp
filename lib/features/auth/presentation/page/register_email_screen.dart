import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tournament_app/features/auth/presentation/register/bloc/register_bloc.dart';
import 'package:tournament_app/features/auth/presentation/register/bloc/register_event.dart';
import 'package:tournament_app/features/auth/presentation/register/bloc/register_state.dart';

class RegisterEmailScreen extends StatelessWidget {
  const RegisterEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear cuenta')),
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state.isSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Registro exitoso')));
            // Redirigir si querés
          }

          if (state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              _buildInput(
                label: 'Nombre',
                onChanged:
                    (value) => context.read<RegisterBloc>().add(
                      RegisterFirstNameChanged(value),
                    ),
              ),
              _buildInput(
                label: 'Apellido',
                onChanged:
                    (value) => context.read<RegisterBloc>().add(
                      RegisterLastNameChanged(value),
                    ),
              ),
              _buildInput(
                label: 'Alias',
                onChanged:
                    (value) => context.read<RegisterBloc>().add(
                      RegisterAliasChanged(value),
                    ),
              ),
              _buildInput(
                label: 'Email',
                keyboard: TextInputType.emailAddress,
                onChanged:
                    (value) => context.read<RegisterBloc>().add(
                      RegisterEmailChanged(value),
                    ),
              ),
              _buildInput(
                label: 'Contraseña',
                obscure: true,
                onChanged:
                    (value) => context.read<RegisterBloc>().add(
                      RegisterPasswordChanged(value),
                    ),
              ),
              _buildInput(
                label: 'Repetir contraseña',
                obscure: true,
                onChanged:
                    (value) => context.read<RegisterBloc>().add(
                      RegisterPasswordRepeatChanged(value),
                    ),
              ),
              const SizedBox(height: 20),
              BlocBuilder<RegisterBloc, RegisterState>(
                builder: (context, state) {
                  final isFormValid =
                      state.firstName.isNotEmpty &&
                      state.lastName.isNotEmpty &&
                      state.alias.isNotEmpty &&
                      state.email.isNotEmpty &&
                      state.password.isNotEmpty &&
                      state.passwordRepeat.isNotEmpty;

                  return ElevatedButton(
                    onPressed:
                        state.isLoading || !isFormValid
                            ? null
                            : () => context.read<RegisterBloc>().add(
                              RegisterSubmitted(),
                            ),
                    child:
                        state.isLoading
                            ? const CircularProgressIndicator()
                            : const Text('Registrarse'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput({
    required String label,
    bool obscure = false,
    TextInputType keyboard = TextInputType.text,
    required void Function(String) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        onChanged: onChanged,
        obscureText: obscure,
        keyboardType: keyboard,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
