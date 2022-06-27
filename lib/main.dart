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
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Material3'),
            leading: IconButton(
                onPressed: () => showAboutDialog(context: context),
                icon: const Icon(Icons.crisis_alert_outlined)),
          ),
          body: SingleChildScrollView(
              child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(
                  width: 250,
                  height: 200,
                  child: Card(
                    elevation: 2,
                    color: Color.fromARGB(255, 159, 175, 183),
                  ),
                )
              ],
            ),
          )),
        ),
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
