import 'package:flutter/material.dart';

import 'autoimport.dart';
import 'manualinport.dart';

class Import extends StatefulWidget {
  const Import({Key? key}) : super(key: key);

  @override
  _ImportState createState() => _ImportState();
}

class _ImportState extends State<Import> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("インポート"),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          automaticallyImplyLeading:false,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ManualImport(),
                ),
              );}, child: Text("手動で入力する")),
              ElevatedButton(onPressed: () {Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AutoImport(),
                ),
              );}, child: Text("自動読み込み"))
              // Add your import-related widgets here
            ],
          ),
        ),
      ),
    );
  }
}
