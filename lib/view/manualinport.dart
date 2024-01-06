import 'package:flutter/material.dart';

class ManualImport extends StatefulWidget {
  const ManualImport({Key? key}) : super(key: key);

  @override
  _ManualImportState createState() => _ManualImportState();
}

class _ManualImportState extends State<ManualImport> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("手動インポート"),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Add your import-related widgets here
            ],
          ),
        ),
      ),
    );
  }
}
