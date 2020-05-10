import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:poke_app/pokemon.dart';

class PokeDetails extends StatelessWidget {

  final Pokemon pokemon;

  PokeDetails({this.pokemon});

  bodyWidget(BuildContext context)=>Stack(
    children: <Widget>[
      Positioned(
        height: MediaQuery.of(context).size.height/1.618,
        width: MediaQuery.of(context).size.width-20.0,
        left: 10.0,
        top: MediaQuery.of(context).size.height*0.15,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(height: 30.0,),
              Text(pokemon.name,style: TextStyle(fontWeight: FontWeight.bold), textScaleFactor: 1.618,),
              Text("Height : ${pokemon.height}"),
              Text("Weight : ${pokemon.weight}"),
              Text("Types"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: pokemon.type.map((t)=>FilterChip(label: Text(t),
                    backgroundColor: Colors.amber,
                    onSelected: (b){})).toList(),
              ),
              Text("Weakness"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: pokemon.weaknesses.map((w)=>FilterChip(
                    label: Text(w,style: TextStyle(color: Colors.white),),
                    backgroundColor: Colors.red,
                    onSelected: (b){})).toList(),
              ),

            ],
          ),
        ),
      ),

      Align(
        alignment: Alignment.topCenter,
        child: Hero(tag: pokemon.img,
            child: Container(
              height: 200.0,
              width: 200.0,
              decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(pokemon.img))),
            )),
      )

    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        centerTitle: true,
        title: Text(pokemon.name),
        backgroundColor: Colors.red,
        elevation: 10.0,
      ),

      body: bodyWidget(context),
    );
  }
}
