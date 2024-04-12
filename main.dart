import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(JankenPo());
}

class JankenPo extends StatefulWidget {
  JankenPo({Key? key}) : super(key: key);

  @override
  State<JankenPo> createState() => _JankenPoState();
}

class _JankenPoState extends State<JankenPo> {
  String _userChoiceImage = "lib/Image/indefinido.png";
  String _appChoiceImage = "lib/Image/indefinido.png";

  // PONTUAÇÃO
  int _userPoints = 0;
  int _appPoints = 0;
  int _tiePoints = 0;

  //Bordas:
  Color _userBorderColor = Colors.transparent;
  Color _appBorderColor = Colors.transparent;

  String _getAppChoice() {
    var options = ['pedra', 'papel', 'tesoura'];
    String chosenValue = options[Random().nextInt(3)];
    return chosenValue;
  }

  void _endRound(String userChoice, String appChoice) {
    var result = "indefinido";

    switch (userChoice) {
      case "pedra":
        if (appChoice == "papel") {
          result = "app";
        } else if (appChoice == "tesoura") {
          result = "user";
        } else {
          result = "empate";
        }
        break;
      case "papel":
        if (appChoice == "pedra") {
          result = "user";
        } else if (appChoice == "tesoura") {
          result = "app";
        } else {
          result = "empate";
        }
        break;
      case "tesoura":
        if (appChoice == "papel") {
          result = "user";
        } else if (appChoice == "pedra") {
          result = "app";
        } else {
          result = "empate";
        }
        break;
    }
    setState(() {
      if (result == "user") {
        _userPoints++;
        _userBorderColor = Colors.green;
        _appBorderColor = Colors.transparent;
      } else if (result == "app") {
        _appPoints++;
        _userBorderColor = Colors.transparent;
        _appBorderColor = Colors.green;
      } else {
        _tiePoints++;
        _userBorderColor = Colors.orange;
        _appBorderColor = Colors.orange;
      }
    });
  }

  void _startRound(String option) {
    //Configura a opção escolhida pelo usuário:
    setState(() {
      _userChoiceImage = "lib/Image/$option.png";
    });

    String appChoice = _getAppChoice();
    setState(() {
      _appChoiceImage = "lib/Image/$appChoice.png";
    });

    _endRound(option, appChoice);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("App - JankenPo"),
        ),
        body: Column(children: [
          const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 20),
            child: Text(
              'Disputa',
              style: TextStyle(fontSize: 26),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Badge(borderColor: _userBorderColor, imgPlayer: _userChoiceImage),
              const Text('VS'),
              Badge(borderColor: _appBorderColor, imgPlayer: _appChoiceImage),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 20),
            child: Text(
              'Placar',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Score(playerName: 'Você', playerPoints: _userPoints),
              Score(playerName: 'Empate', playerPoints: _tiePoints),
              Score(playerName: 'App', playerPoints: _appPoints),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 20),
            child: Text(
              'Opções',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => _startRound("pedra"),
                child: Image.asset(
                  'lib/Image/pedra.png',
                  height: 90,
                ),
              ),
              GestureDetector(
                onTap: () => _startRound("papel"),
                child: Image.asset(
                  'lib/Image/papel.png',
                  height: 90,
                ),
              ),
              GestureDetector(
                onTap: () => _startRound("tesoura"),
                child: Image.asset(
                  'lib/Image/tesoura.png',
                  height: 90,
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}

class Score extends StatelessWidget {
  const Score({
    Key? key,
    required String playerName,
    required int playerPoints,
  })  : _playerPoints = playerPoints,
        _playerName = playerName,
        super(key: key);

  final int _playerPoints;
  final String _playerName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(_playerName),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black45, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(7))),
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(35),
          child: Text('$_playerPoints', style: TextStyle(fontSize: 26)),
        )
      ],
    );
  }
}

class Badge extends StatelessWidget {
  const Badge({
    Key? key,
    required Color borderColor,
    required String imgPlayer,
  })  : _borderColor = borderColor,
        _imgPlayer = imgPlayer,
        super(key: key);

  final Color _borderColor;
  final String _imgPlayer;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: _borderColor, width: 4),
          borderRadius: const BorderRadius.all(Radius.circular(100))),
      child: Image.asset(
        _imgPlayer,
        height: 120,
      ),
    );
  }
}
