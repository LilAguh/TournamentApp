import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tournament_app/features/auth/presentation/register/bloc/register_bloc.dart';
import 'package:tournament_app/features/auth/presentation/register/bloc/register_event.dart';
import 'package:tournament_app/features/auth/presentation/register/bloc/register_state.dart';

class RegisterEmailScreen extends StatefulWidget {
  const RegisterEmailScreen({super.key});

  @override
  State<RegisterEmailScreen> createState() => _RegisterEmailScreenState();
}

class _RegisterEmailScreenState extends State<RegisterEmailScreen> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _aliasController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _aliasController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      context.read<RegisterBloc>().add(
        RegisterSubmitted(
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          alias: _aliasController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text,
          repeatPassword: _repeatPasswordController.text,
        ),
      );
    }
  }

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
            // Redireccionar si querés
          }

          if (state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                _buildInput(_firstNameController, 'Nombre'),
                _buildInput(_lastNameController, 'Apellido'),
                _buildInput(_aliasController, 'Alias'),
                _buildInput(
                  _emailController,
                  'Email',
                  keyboard: TextInputType.emailAddress,
                ),
                _buildInput(_passwordController, 'Contraseña', obscure: true),
                _buildInput(
                  _repeatPasswordController,
                  'Repetir contraseña',
                  obscure: true,
                ),
                const SizedBox(height: 20),
                BlocBuilder<RegisterBloc, RegisterState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: state.isLoading ? null : _submitForm,
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
      ),
    );
  }

  Widget _buildInput(
    TextEditingController controller,
    String label, {
    bool obscure = false,
    TextInputType keyboard = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboard,
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return '$label es obligatorio';
          }

          if (label == 'Email' && !value.contains('@')) {
            return 'Email inválido';
          }

          if (label == 'Repetir contraseña' &&
              value != _passwordController.text) {
            return 'Las contraseñas no coinciden';
          }

          return null;
        },
      ),
    );
  }
}
