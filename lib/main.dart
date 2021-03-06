import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart'; // allow to work on file
import 'package:shared_preferences/shared_preferences.dart';

main() async {
  // var data = await readData();
  // if (data != Null) {
  //   String message = await readData();
  //   //print(message);
  // }

  runApp(
    new MaterialApp(
      title: 'IO',
      home: new Home(),
    ),
  );
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _HomeState();
  }
}

class _HomeState extends State<Home> {

  var _enterDataField = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Read/Write'),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: new Container(
          padding: const EdgeInsets.all(13.4),
          alignment: Alignment.topCenter,
          child: new ListView(
            children: [
              new TextField(
                controller: _enterDataField,
                decoration: new InputDecoration(
                  labelText: 'Write Something',
                ),
              ),
              new ElevatedButton(
                onPressed: () {
                  //save to file
                  writeData(_enterDataField.text);
                },
                child: new Column(
                  children: <Widget>[
                    new Text('Save Data'),
                    new Padding(
                      padding: new EdgeInsets.all(14.5),
                    ),

                    new FutureBuilder(
                      future: readData(),
                      builder: (BuildContext context, AsyncSnapshot<String> data){
                        if(data.hasData != null){
                          return new Text(
                            data.data.toString(),
                            style: new TextStyle(
                              color: Colors.white,
                            ),
                          );
                        }
                        else
                          {
                            return new Text("No Data Saved!");
                          }
                      }
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path; //home/directory
} // finding local path to store data

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/data.txt'); //home/directory/data.txt
} // creating a file

//Write and Read from our File

Future<File> writeData(String message) async {
  final file = await _localFile;
  //write to File
  return file.writeAsString('$message');
}

Future<String> readData() async {
  try {
    //if something goes wrong then this piece of code will run
    final file = await _localFile;
    //Read from file
    String data = await file.readAsString();
    return data;
  }
  catch(e)
  {
    return "nothing saved";
  }
}

//The path_provider package provides a platform-agnostic way to access commonly used locations on the device???s file system.

//The try block embeds code that might possibly result in an exception. The on block is used when the exception type needs to be specified.
//The catch block is used when the handler needs the exception object.
