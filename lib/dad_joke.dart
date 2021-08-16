import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:dad_joke_1/model/joke.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class DadJoke extends StatefulWidget {
  const DadJoke({Key? key}) : super(key: key);

  @override
  _DadJokeState createState() => _DadJokeState();
}

class _DadJokeState extends State<DadJoke> {
  final baseUrl = "https://icanhazdadjoke.com/";
  Joke? jokeData;

  Future<Joke>? getData() async {
    var response = await http
        .get(Uri.parse(baseUrl), headers: {"Accept": "application/json"});
    switch (response.statusCode) {
      case HttpStatus.ok:
        var jsonBody = jsonDecode(response.body);
        return jokeData = Joke.fromJson(jsonBody);
    }
    return Joke(status: 0);
  }

  // Future<String> getAJoke() async {
  //   String jokeData;
  //   var res = await http.get(Uri.parse('https://icanhazdadjoke.com/'),
  //       headers: {"Accept": "application/json"});

  //   if (res.statusCode == 200) {
  //     jokeData = json.decode(res.body)['joke'];
  //   }
  //   return getAJoke();
  // }

  List<String> typesOfDad = [
    'Cranky',
    'Angry',
    'Hungry',
    'Calm',
    'Sleepy',
    'Corny'
  ];
  String saka = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.purple.shade800,
        body: SafeArea(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.orange.shade500,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                  onPressed: () {
                    getData();
                    setState(() {
                      saka = jokeData?.joke ?? '';
                      saka = saka;
                    });
                  },
                  child: Text(
                    'For Dad Joke ',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  '$saka',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        )));
  }
}
