// ignore_for_file: sort_child_properties_last

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'detail_screen.dart';
// import 'package:pokemon/detail_screen.dart';
// import 'package:pokemon/pokedex.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List pokedex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (mounted) {
      fetchPokemonData();
    }
  }

  Color? getColorForType(String type) {
    final typeColors = {
      'Grass': Colors.greenAccent,
      'Fire': Colors.redAccent,
      'Water': Colors.blue,
      'Poison': Colors.deepPurpleAccent,
      'Electric': Colors.amber,
      'Rock': Colors.grey,
      'Ground': Colors.brown,
      'Psychic': Colors.indigo,
      'Fighting': Colors.orange,
      'Bug': Colors.lightGreenAccent,
      'Ghost': Colors.deepPurple,
      'Normal': Colors.black26,
    };

    return typeColors.containsKey(type) ? typeColors[type] : Colors.pink;
  }

  Color? getColorForInfo(String type) {
    final typeColors = {
      'Grass': Colors.greenAccent[400],
      'Fire': Colors.redAccent[400],
      'Water': Colors.blue[400],
      'Poison': Colors.deepPurpleAccent[400],
      'Electric': Colors.amber[400],
      'Rock': Colors.grey[400],
      'Ground': Colors.brown[400],
      'Psychic': Colors.indigo[400],
      'Fighting': Colors.orange[400],
      'Bug': Colors.lightGreenAccent[400],
      'Ghost': Colors.deepPurple[400],
      'Normal': Colors.black26,
    };

    return typeColors.containsKey(type) ? typeColors[type] : Colors.pink;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    Color _greenColor = const Color(0xff2a9d8f);
    Color _redColor = const Color(0xffe76f51);
    Color _blueColor = const Color(0xff37A5C6);

    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          Positioned(
            top: -50,
            right: -50,
            child: Image.asset(
              'images/pokeball.png',
              width: 200,
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
              top: 100,
              left: 20,
              child: Text(
                'Pokedex',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              )),
          Positioned(
            top: 150,
            bottom: 0,
            width: width,
            child: Column(
              children: [
                pokedex != null
                    ? Expanded(
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, childAspectRatio: 1.4),
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: pokedex.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                child: InkWell(
                                  child: SafeArea(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: getColorForType(
                                              pokedex[index]['type'][0]),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(25))),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            bottom: -10,
                                            right: -10,
                                            child: Image.asset(
                                              'images/pokeball.png',
                                              height: 100,
                                              fit: BoxFit.fitHeight,
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 5,
                                            right: 5,
                                            child: Hero(
                                              tag: index,
                                              child: CachedNetworkImage(
                                                  imageUrl: pokedex[index]
                                                      ['img'],
                                                  height: 100,
                                                  fit: BoxFit.fitHeight,
                                                  placeholder: (context, url) =>
                                                      const Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      )),
                                            ),
                                          ),
                                          Positioned(
                                            top: 55,
                                            left: 15,
                                            child: Container(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0,
                                                    right: 10,
                                                    top: 5,
                                                    bottom: 5),
                                                child: Text(
                                                  pokedex[index]['type'][0],
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      shadows: [
                                                        BoxShadow(
                                                            color:
                                                                Colors.blueGrey,
                                                            offset:
                                                                Offset(0, 0),
                                                            spreadRadius: 1.0,
                                                            blurRadius: 15)
                                                      ]),
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(20)),
                                                  color: getColorForInfo(
                                                      pokedex[index]['type']
                                                          [0])),
                                            ),
                                          ),
                                          pokedex[index]['type'].length > 1
                                              ? Positioned(
                                                  top: 90,
                                                  left: 15,
                                                  child: Container(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0,
                                                              right: 10,
                                                              top: 5,
                                                              bottom: 5),
                                                      child: Text(
                                                        pokedex[index]['type']
                                                                    .length >
                                                                1
                                                            ? pokedex[index]
                                                                ['type'][1]
                                                            : '',
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          shadows: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .blueGrey,
                                                              offset:
                                                                  Offset(0, 0),
                                                              spreadRadius: 1.0,
                                                              blurRadius: 15,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    20)),
                                                        color: getColorForInfo(
                                                            pokedex[index]
                                                                ['type'][0])),
                                                  ),
                                                )
                                              : Container(),
                                          Positioned(
                                            top: 30,
                                            left: 15,
                                            child: Text(
                                              pokedex[index]['name'],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  shadows: [
                                                    BoxShadow(
                                                        color: Colors.blueGrey,
                                                        offset: Offset(0, 0),
                                                        spreadRadius: 1.0,
                                                        blurRadius: 15)
                                                  ]),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => DetailScreen(
                                                  heroTag: index,
                                                  pokemonDetail: pokedex[index],
                                                  color: pokedex[index]['type']
                                                              [0] ==
                                                          "Grass"
                                                      ? Colors.greenAccent
                                                      : pokedex[index]['type']
                                                                  [0] ==
                                                              "Fire"
                                                          ? Colors.redAccent
                                                          : pokedex[index]['type']
                                                                      [0] ==
                                                                  "Water"
                                                              ? Colors.blue
                                                              : pokedex[index]['type']
                                                                          [0] ==
                                                                      "Poison"
                                                                  ? Colors
                                                                      .deepPurpleAccent
                                                                  : pokedex[index]['type'][0] ==
                                                                          "Electric"
                                                                      ? Colors
                                                                          .amber
                                                                      : pokedex[index]['type'][0] ==
                                                                              "Rock"
                                                                          ? Colors
                                                                              .grey
                                                                          : pokedex[index]['type'][0] == "Ground"
                                                                              ? Colors.brown
                                                                              : pokedex[index]['type'][0] == "Psychic"
                                                                                  ? Colors.indigo
                                                                                  : pokedex[index]['type'][0] == "Fighting"
                                                                                      ? Colors.orange
                                                                                      : pokedex[index]['type'][0] == "Bug"
                                                                                          ? Colors.lightGreenAccent
                                                                                          : pokedex[index]['type'][0] == "Ghost"
                                                                                              ? Colors.deepPurple
                                                                                              : pokedex[index]['type'][0] == "Normal"
                                                                                                  ? Colors.white70
                                                                                                  : Colors.pink,
                                                )));
                                  },
                                ),
                              );
                            }))
                    : const Center(
                        child: CircularProgressIndicator(),
                      )
              ],
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              height: 150,
              width: width,
            ),
          ),
        ]));
  }

  void fetchPokemonData() {
    var url = Uri.https('raw.githubusercontent.com',
        '/Biuni/PokemonGO-Pokedex/master/pokedex.json');
    http.get(url).then((value) {
      if (value.statusCode == 200) {
        var data = jsonDecode(value.body);
        pokedex = data['pokemon'];

        setState(() {});

        print(pokedex);
      }
    }).catchError((e) {
      print(e);
    });
  }
}
