import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterProvider = StateProvider((ref) => 0);
final bottomNavigationIndexProvider = StateProvider((ref) => 0);
final navigationRailIndexProvider = StateProvider((ref) => 0);
final titleProvider = Provider((ref) => "Flutter Demo");

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material3',
      theme: ThemeData(
        colorSchemeSeed: Colors.orange,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material3'),
        leading: IconButton(
            onPressed: () => _showAlertDialog(context),
            icon: const Icon(Icons.crisis_alert_outlined)),
      ),
      body: ListView.builder(
        itemCount: 12, // この行を追加
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 100,
              child: Card(
                child: ListTile(
                  leading: CircleAvatar(
                    maxRadius: 50,
                    backgroundColor: Colors.amber,
                  ),
                  title: Text('タイトルです'),
                  subtitle: Text('サブタイトルです'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _showAlertDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('アラートダイアログ'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('ダイアログメッセージ１行目'),
                Text('ダイアログメッセージ２行目'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
