import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final textProvider = StateProvider<String>((_) => 'not selected');

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: ((context, ref, child) {
        final content = ref.watch(textProvider);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Flutter Demo Home Page'),
          ),
          drawer: const DrawerMenu(),
          body: Stack(alignment: AlignmentDirectional.topCenter, children: [
            const ButtonMenu(),
            Center(
              child:
                  Text(content, style: Theme.of(context).textTheme.headline2),
            ),
          ]),
        );
      }),
    );
  }
}

class ButtonMenu extends StatelessWidget {
  const ButtonMenu({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: ((context, ref, child) => Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(3, (i) => 'hello, $i')
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.all(5),
                    child: InkWell(
                      onTap: () {
                        ref.read(textProvider.notifier).state = e;
                      },
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.person, size: 40),
                            Text(e,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          )),
    );
  }
}

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final content = ref.watch(textProvider);
        return Drawer(
          child: Column(children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              color: Theme.of(context).colorScheme.primary,
              child: Center(
                  child: Text(
                'header',
                style: Theme.of(context).textTheme.headlineMedium,
              )),
            ),
            Expanded(
              child: ListView(
                  children: List.generate(3, (i) => 'hello, $i')
                      .map((e) => ListTile(
                            title: Text(e),
                            selected: content == e,
                            onTap: () {
                              ref.read(textProvider.notifier).state = e;
                              Navigator.pop(context);
                            },
                          ))
                      .toList()),
            )
          ]),
        );
      },
    );
  }
}
