import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;
import 'dart:io';
import 'dart:convert';
import 'package:meta/meta.dart';

extension Log on Object {
  void log() => devtools.log(toString());
}

extension GetOnUri on Object {
  Future<HttpClientResponse> getUrl(
    String url,
  ) =>
      HttpClient()
          .getUrl(
            Uri.parse(url),
          )
          .then((req) => req.close());
}

mixin CanMakeGetCall {
  String get url;
  @useResult
  Future<String> getString() => getUrl(
        url,
      ).then(
        (res) => res
            .transform(
              utf8.decoder,
            )
            .join(),
      );
}

@immutable
class GetPeople with CanMakeGetCall {
  const GetPeople();

  @override
  String get url => 'http://127.0.0.1:5500/api/people.json';
}

void testIt() async {
  final people = await const GetPeople().getString();
  people.log();
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    testIt();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
