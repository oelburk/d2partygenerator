import 'dart:developer';
import 'dart:math';

import 'package:d2_class_picker/player.dart';
import 'package:flutter/material.dart';

import 'class_resolver.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diablo 2 Class Picker',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      themeMode: ThemeMode.dark,
      darkTheme:
          ThemeData(brightness: Brightness.dark, primarySwatch: Colors.orange),
      home: const MyHomePage(title: 'Diablo 2 Party Generator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Player> players = [];
  List<Player> finalParty = [];

  void addPlayer(String name) {
    setState(() {
      if (name.isNotEmpty) {
        Player playerToAdd = Player(name);
        playerToAdd.generateColor(players);
        players.add(playerToAdd);
      }
    });
  }

  TextEditingController playerNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Add Player'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      const Text('Enter name'),
                                      TextField(
                                        controller: playerNameController,
                                        maxLength: 50,
                                      ),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      playerNameController.clear();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Approve'),
                                    onPressed: () {
                                      addPlayer(playerNameController.text);
                                      Navigator.of(context).pop();
                                      playerNameController.clear();
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'ADD PLAYER',
                          style: TextStyle(fontSize: 25, fontFamily: 'Diablo'),
                        ),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(players.length, (index) {
                      return SizedBox(
                        width: 150,
                        child: PlayerCard(
                          name: players[index].Name,
                          playerColor: players[index].playerColor,
                          onPress: () {},
                        ),
                      );
                    }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 800,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(7, (index) {
                            CClass char = CClass.values[index];
                            return ClassFrame(
                              name: ClassResolver.nameFromClass(char),
                              imageAddress:
                                  ClassResolver.imageAdrFromClass(char),
                              players: players,
                              displayOnly: false,
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        finalParty.clear();
                      });

                      generateParty();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'GENERATE',
                        style: TextStyle(fontSize: 55, fontFamily: 'Diablo'),
                      ),
                    ),
                  ),
                  const Text('Your demon slaying party:'),
                  SizedBox(
                    height: 500,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(finalParty.length, (index) {
                        CClass char = finalParty[index].playerClass;
                        return ClassFrame(
                          name: finalParty[index].Name,
                          imageAddress: ClassResolver.imageAdrFromClass(char),
                          players: players,
                          displayOnly: true,
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'There will be bugs, but also love - 2021',
                style: TextStyle(color: Colors.grey[800]),
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void generateParty() {
    finalParty.clear();
    List<Player> plList = List.from(players);
    while (plList.isNotEmpty) {
      //Get random player
      int playerIndex = Random().nextInt(plList.length);
      Player chosenPlayer = plList[playerIndex];

      //Get random wanted class
      CClass wantedClass = chosenPlayer.potentialClasses[
          Random().nextInt(chosenPlayer.potentialClasses.length)];

      chosenPlayer.playerClass = wantedClass;

      //Add final player to party, clean wish list.
      setState(() {
        finalParty.add(chosenPlayer);
        plList.removeAt(playerIndex);
      });
    }
  }
}

class PlayerCard extends StatelessWidget {
  const PlayerCard(
      {Key? key,
      required this.name,
      required this.playerColor,
      required this.onPress})
      : super(key: key);

  final String name;
  final Color playerColor;
  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: Container(
          width: 25.0,
          height: 25.0,
          decoration: new BoxDecoration(
            color: playerColor,
            shape: BoxShape.circle,
          ),
        ),
        title: Text(name),
        onTap: onPress,
      ),
    );
  }
}

class ClassFrame extends StatefulWidget {
  const ClassFrame(
      {Key? key,
      required this.name,
      required this.imageAddress,
      required this.players,
      required this.displayOnly})
      : super(key: key);

  final String name;
  final String imageAddress;
  final List<Player> players;
  final bool displayOnly;

  @override
  State<ClassFrame> createState() => _ClassFrameState();
}

class _ClassFrameState extends State<ClassFrame> {
  List<Color> _selectedPlayers = [];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Text(widget.name),
            Container(
              height: 200,
              margin: EdgeInsets.all(8),
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  widget.imageAddress,
                  height: 5,
                ),
              ),
            ),
            Visibility(
              visible: !widget.displayOnly,
              child: TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Add Player'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: List.generate(
                                        widget.players.length, (index) {
                                      return PlayerCard(
                                        name: widget.players[index].Name,
                                        playerColor:
                                            widget.players[index].playerColor,
                                        onPress: () {
                                          addPlayer(index);
                                        },
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Close'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                  },
                  child: Text('Assign Player')),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: List.generate(_selectedPlayers.length, (index) {
              return Container(
                margin: EdgeInsets.all(4),
                width: 15.0,
                height: 15.0,
                decoration: new BoxDecoration(
                  color: _selectedPlayers[index],
                  shape: BoxShape.circle,
                ),
              );
            }),
          ),
        )
      ],
    );
  }

  void addPlayer(int index) {
    setState(() {
      if (widget.players[index]
          .addClass(ClassResolver.classFromName(widget.name))) {
        _selectedPlayers.add(widget.players[index].playerColor);
      } else {
        Color selectedColor = widget.players[index].playerColor;
        if (_selectedPlayers.contains(selectedColor)) {
          _selectedPlayers.remove(selectedColor);
          widget.players[index]
              .removeClass(ClassResolver.classFromName(widget.name));
        }
      }
    });
  }
}
