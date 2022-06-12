import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final materialSwitchProvider = StateProvider((ref) => false);
final counterProvider = StateProvider((ref) => 0);
final bottomNavigationIndexProvider = StateProvider((ref) => 0);
final navigationRailIndexProvider = StateProvider((ref) => 0);
final titleProvider = Provider((ref) => "Flutter Demo");

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: ref.watch(titleProvider),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: ref.watch(materialSwitchProvider), // Material3 有効
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text(ref.watch(titleProvider)),
            actions: [
              Row(children: [
                Text("Material3"),
                Switch(
                  value: ref.watch(materialSwitchProvider),
                  onChanged: (_) => ref
                      .read(materialSwitchProvider.state)
                      .update((state) => !state),
                ),
              ]),
            ],
          ),
          body: Builder(builder: (context) {
            final Size screenSize = MediaQuery.of(context).size;
            final index = ref.watch(bottomNavigationIndexProvider);
            return <Widget>[
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('You have pushed the button this many times:'),
                    Text(ref.watch(counterProvider).toString(),
                        style: Theme.of(context).textTheme.headline4),
                  ],
                ),
              ),
              Row(
                children: [
                  NavigationRail(
                      selectedIndex: ref.watch(navigationRailIndexProvider),
                      onDestinationSelected: (index) => ref
                          .read(navigationRailIndexProvider.state)
                          .update((state) => index),
                      labelType: NavigationRailLabelType.selected,
                      destinations: const <NavigationRailDestination>[
                        NavigationRailDestination(
                            icon: Icon(Icons.favorite_border),
                            selectedIcon: Icon(Icons.favorite),
                            label: Text('First')),
                        NavigationRailDestination(
                            icon: Icon(Icons.bookmark_border),
                            selectedIcon: Icon(Icons.book),
                            label: Text('Second')),
                        NavigationRailDestination(
                            icon: Icon(Icons.star_border),
                            selectedIcon: Icon(Icons.star),
                            label: Text('Third')),
                      ]),
                  Container(
                    margin: EdgeInsets.only(
                        left: screenSize.width * 0.1,
                        right: screenSize.width * 0.1),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 20),
                        Card(
                            child: Container(
                                width: screenSize.width * 0.6,
                                padding: EdgeInsets.all(30),
                                child: Text("Card ウィジェット"))),
                        SizedBox(height: 20),
                        ElevatedButton(
                          child: Container(
                              width: screenSize.width * 0.6 - 40,
                              padding: EdgeInsets.all(30),
                              child: Text(
                                  "ElevatedButton ウィジェット\n（クリックしてAlertDialog）")),
                          onPressed: () => _showAlertDialog(context),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ][index];
          }),
          floatingActionButton: ref.watch(bottomNavigationIndexProvider) == 0
              ? FloatingActionButton(
                  onPressed: () => ref
                      .read(counterProvider.state)
                      .update((state) => state + 1),
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                )
              : null,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: ref.watch(bottomNavigationIndexProvider),
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "ホーム"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.widgets), label: "ウィジェット")
            ],
            onTap: (index) => ref
                .read(bottomNavigationIndexProvider.state)
                .update((state) => index),
          ),
        ));
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
