import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class Example extends StatelessWidget {
  List<Container> cards = [
    Container(
      alignment: Alignment.center,
      child: const Text('HOLA BELEN'),
      color: Colors.blue,
    ),
    Container(
      alignment: Alignment.center,
      child: const Text('2'),
      color: Colors.red,
    ),
    Container(
      alignment: Alignment.center,
      child: const Text('3'),
      color: Colors.purple,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Flexible(
        child: CardSwiper(
          cardsCount: cards.length,
          cardBuilder:
              (context, index, percentThresholdX, percentThresholdY) =>
                  cards[index],
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Example();
  }
}
