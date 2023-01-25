import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class Demo extends StatefulWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  var data;
  Future<void> productdata() async {
    http.Response response = await http.get(Uri.parse(
        "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json"));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("demo")),
      body: Column(children: [
        Expanded(
          child: FutureBuilder(
            future: productdata(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: 151,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        children: [
                          Image.network(
                            data["pokemon"][index]["img"],
                            height: 100,
                            fit: BoxFit.fitHeight,
                          ),
                          Text(data["pokemon"][index]["name"],
                              style: TextStyle(fontSize: 20)),
                          Text(data["pokemon"][index]["type"][0],
                              style: TextStyle(fontSize: 20)),
                          null == [1]
                              ? Text("")
                              : Text(data["pokemon"][index]["type"][1],
                                  style: TextStyle(fontSize: 20))
                        ],
                      ),
                    );
                  },
                );
              }
            },
          ),
        )
      ]),
    );
  }
}
