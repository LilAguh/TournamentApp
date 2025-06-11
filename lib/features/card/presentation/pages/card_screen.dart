import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tournament_app/features/auth/config/auth_config.dart';
import 'package:tournament_app/features/card/presentation/bloc/card_bloc.dart';
import 'package:tournament_app/features/card/presentation/bloc/card_event.dart';
import 'package:tournament_app/features/card/presentation/bloc/card_state.dart';
import 'package:tournament_app/features/card/domain/entities/card.dart'
    as model;

class CardScreen extends StatelessWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CardBloc>(
      create: (_) => sl<CardBloc>()..add(GetAllCardsEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Cartas')),
        body: BlocBuilder<CardBloc, CardState>(
          builder: (context, state) {
            if (state is CardLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CardLoaded) {
              final List<model.Card> cards = state.cards;
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: cards.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final card = cards[index];
                  return _CardItem(card: card);
                },
              );
            } else if (state is CardError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _CardItem extends StatelessWidget {
  final model.Card card;

  const _CardItem({required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                card.image,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/cartas/default.png', // imagen por defecto
                    fit: BoxFit.contain,
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              card.name['es'] ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
