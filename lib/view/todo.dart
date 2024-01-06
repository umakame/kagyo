import 'package:flutter/material.dart';

import 'detail.dart';


class Todo extends StatefulWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Todo> {
  bool isChecked = false;
  List<bool> isCheckedList = new List.generate(20, (index)=>false);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("ホーム"),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            automaticallyImplyLeading:false,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.amber,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 20,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Detail(),
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        child: Row(
                          children: [
                            Checkbox(
                              value: isCheckedList[index],
                              onChanged: (value) {
                                setState(() {
                                  isCheckedList[index] = value!;
                                });
                              },
                            ),
                            Text(index.toString()),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 50),
              Container(
                color: Colors.blue,
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: List.generate(30, (index) => Text("a")),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
