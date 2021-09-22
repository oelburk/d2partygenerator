import 'dart:math';

import 'package:flutter/material.dart';

enum CClass {
  Amazon,
  Assassin,
  Barbarian,
  Druid,
  Necromancer,
  Paladin,
  Sorceress,
  Undefined
}

class Player {
  String _name = "";
  CClass _charClass = CClass.Undefined;
  Color _color = Colors.black;

  List<CClass> _potentialClasses = [];

  Player(String name) {
    _name = name;
    //Color _randomColor =
    //Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }

  set playerClass(CClass charClass) {
    _charClass = charClass;
  }

  CClass get playerClass {
    return _charClass;
  }

  String get Name {
    return _name;
  }

  Color get playerColor {
    return _color;
  }

  void generateColor(List<Player> playerList) {
    bool reachedEnd = false;
    Color randomColor =
        Colors.primaries[Random().nextInt(Colors.primaries.length)];

    while (!reachedEnd) {
      bool dupe = false;
      for (int i = 0; i < playerList.length; i++) {
        if (playerList[i]._color == randomColor) {
          randomColor =
              Colors.primaries[Random().nextInt(Colors.primaries.length)];
          dupe = true;
          break;
        }
      }
      if (dupe == false) reachedEnd = true;
    }
    _color = randomColor;
  }

  bool addClass(CClass playerClass) {
    if (_potentialClasses.isEmpty || !_potentialClasses.contains(playerClass)) {
      _potentialClasses.add(playerClass);
      return true;
    }
    return false;
  }

  bool removeClass(CClass playerClass) {
    if (_potentialClasses.isNotEmpty ||
        _potentialClasses.contains(playerClass)) {
      _potentialClasses.remove(playerClass);
      return true;
    }
    return false;
  }

  List<CClass> get potentialClasses {
    return _potentialClasses;
  }
}
