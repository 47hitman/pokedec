// ignore_for_file: sort_child_properties_last, use_key_in_widget_constructors, library_private_types_in_public_api, sized_box_for_whitespace

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<dynamic> pokedex = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchPokemonData();
  }

  void fetchPokemonData() async {
    var url = Uri.https('raw.githubusercontent.com',
        '/Biuni/PokemonGO-Pokedex/master/pokedex.json');
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          pokedex = data['pokemon'];
          isLoading = false;
        });
        print(pokedex);
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
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
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
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
            ),
          ),
          Positioned(
            top: 150,
            bottom: 0,
            width: width,
            child: Column(
              children: [
                Expanded(
                  child: pokedex.isNotEmpty
                      ? GridView.builder(
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
                                          Radius.circular(25)),
                                    ),
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
                                              imageUrl: pokedex[index]['img'],
                                              height: 100,
                                              fit: BoxFit.fitHeight,
                                              placeholder: (context, url) =>
                                                  const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            ),
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
                                                      color: Colors.blueGrey,
                                                      offset: Offset(0, 0),
                                                      spreadRadius: 1.0,
                                                      blurRadius: 15,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(20)),
                                              color: getColorForInfo(
                                                  pokedex[index]['type'][0]),
                                            ),
                                          ),
                                        ),
                                        if (pokedex[index]['type'].length > 1)
                                          Positioned(
                                            top: 90,
                                            left: 15,
                                            child: Container(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0,
                                                    right: 10,
                                                    top: 5,
                                                    bottom: 5),
                                                child: Text(
                                                  pokedex[index]['type']
                                                              .length >
                                                          1
                                                      ? pokedex[index]['type']
                                                          [1]
                                                      : '',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    shadows: [
                                                      BoxShadow(
                                                        color: Colors.blueGrey,
                                                        offset: Offset(0, 0),
                                                        spreadRadius: 1.0,
                                                        blurRadius: 15,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(20)),
                                                color: getColorForInfo(
                                                    pokedex[index]['type'][0]),
                                              ),
                                            ),
                                          ),
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
                                                  blurRadius: 15,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Color getColorForType(String type) {
                                    switch (type) {
                                      case "Grass":
                                        return Colors.greenAccent;
                                      case "Fire":
                                        return Colors.redAccent;
                                      case "Water":
                                        return Colors.blue;
                                      case "Poison":
                                        return Colors.deepPurpleAccent;
                                      case "Electric":
                                        return Colors.amber;
                                      case "Rock":
                                        return Colors.grey;
                                      case "Ground":
                                        return Colors.brown;
                                      case "Psychic":
                                        return Colors.indigo;
                                      case "Fighting":
                                        return Colors.orange;
                                      case "Bug":
                                        return Colors.lightGreenAccent;
                                      case "Ghost":
                                        return Colors.deepPurple;
                                      case "Normal":
                                        return Colors.white70;
                                      default:
                                        return Colors.pink;
                                    }
                                  }

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => DetailScreen(
                                        heroTag: index,
                                        pokemonDetail: pokedex[index],
                                        color: getColorForType(
                                            pokedex[index]['type'][0]),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
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
        ],
      ),
    );
  }
}
