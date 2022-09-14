import 'package:flutter/material.dart';
import 'package:flutter_hive_template/hive_db.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveDb.instance.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _result = "";

  void _load([bool write = true]) async {
    if (write) {
      await HiveDb.instance.setInt("key_int", 1234567);

      await HiveDb.instance.setDouble("key_double", 12.3);

      await HiveDb.instance.setBool("key_bool", true);

      await HiveDb.instance.setString("key_string", 'Hello');

      await HiveDb.instance.setStringList("key_list_string", ["a", "b", null]);

      await HiveDb.instance.setMap("key_map", {
        "km1": 1,
        "km2": "abc",
        "km3": [1, 2, 3],
        "km4": {"a": 1, "b": 2, "c": null},
        "km5": null
      });

      await HiveDb.instance.setDateTime("key_date_time", DateTime.now());
    }

    setState(() {
      _result = """
        ${HiveDb.instance.getInt("key_int")}
        ${HiveDb.instance.getDouble("key_double")}
        ${HiveDb.instance.getBool("key_bool")}
        ${HiveDb.instance.getString("key_string")}
        ${HiveDb.instance.getStringList("key_list_string")}
        ${HiveDb.instance.getMap("key_map")}
        ${HiveDb.instance.getDateTime("key_date_time")}


        ${HiveDb.instance.getStringList("key_int")}
        ${HiveDb.instance.getMap("key_int")}

        ${HiveDb.instance.getInt("key_other")}
      """;
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('SELECT PREFIX'),
                ElevatedButton(
                  onPressed: () {
                    HiveDb.instance.prefix = 'home';
                  },
                  child: const Text('Home'),
                ),
                ElevatedButton(
                  onPressed: () {
                    HiveDb.instance.prefix = 'work';
                  },
                  child: const Text('Work'),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('CLEAR'),
                ElevatedButton(
                  onPressed: () async {
                    await HiveDb.instance.clearAll();
                    _load(false);
                  },
                  child: const Text('CLEAR'),
                ),
              ],
            ),
            Text(
              _result,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            ValueListenableBuilder<Box>(
              valueListenable: HiveDb.instance.listen(['key_int']),
              builder: (context, box, widget) {
                return Text(box.get('key_int').toString());
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _load,
        child: const Icon(Icons.add),
      ),
    );
  }
}
