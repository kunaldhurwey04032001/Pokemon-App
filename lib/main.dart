import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;
import 'package:poke_app/pokedetail.dart';
import 'package:poke_app/pokemon.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

void main() => runApp(MaterialApp(
      title: "Pokemon App",
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  PokeHub pokeHub;

  @override
  void initState() {
    super.initState();

    fetchData();
    print("Other work");
  }

  fetchData() async {
    var res = await http.get(url);
    var decodedValue = jsonDecode(res.body);

    pokeHub = PokeHub.fromJson(decodedValue);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokemon App"),
        backgroundColor: Colors.red,
      ),
      body: pokeHub == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.count(
              crossAxisCount: 1,
              children: pokeHub.pokemon
                  .map((Pokemon p) => Padding(
                        padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PokeDetails(
                                          pokemon: p,
                                        )));
                          },
                          child: Container(
                            padding: EdgeInsets.only(bottom: 20.0, top: 20.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0)),
                              elevation: 20.0,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Hero(
                                      tag: p.img,
                                      child: Container(
                                        height: 220.0,
                                        width: 220.0,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(p.img))),
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50.0),
                                      child: Container(
                                        color: Colors.lightBlue,
                                        alignment: Alignment.center,
                                        width: 300.0,
                                        height: 92.0,
                                        child: Text(
                                          p.name,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'HN',
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
      drawer: Drawer(),
    );
  }
}
