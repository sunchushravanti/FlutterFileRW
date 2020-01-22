import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_permissions/simple_permissions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget{
  MyFileWrite createState() => MyFileWrite();
}
class MyFileWrite extends State<MyHomePage> {
  bool _allowWriteFile = false;

  @override
  void initState() {
    super.initState();
    requestWritePermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saving data'),
      ),
      body: Row(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              child: Text('Read'),
              onPressed: () {
                _read();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              child: Text('Save'),
              onPressed: () {
                _save();
              },
            ),
          ),
        ],
      ),
    );
  }

  _read() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final externalDirectory = await getExternalStorageDirectory();

      final file = File('${externalDirectory.path}/my_file.txt');
      String text = await file.readAsString();
      print(text);
    } catch (e) {
      print("Couldn't read file");
    }
  }

  _save() async {
    final directory = await getApplicationDocumentsDirectory();
    final externalDirectory = await getExternalStorageDirectory();

    print(directory.path);
    final file = File('${externalDirectory.path}/my_file.txt');
    final text = 'Hello Shravanti! ';
    await file.writeAsString(text);
    print('saved');
  }

  requestWritePermission() async {
    PermissionStatus permissionStatus = await SimplePermissions
        .requestPermission(Permission.WriteExternalStorage);

    if (permissionStatus == PermissionStatus.authorized) {
      setState(() {
        _allowWriteFile = true;
      });
    }
  }
}