import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'models/items.dart';

void main() {
  runApp( MyApp());
}

hexCode (String colorHexCode) {
  colorHexCode = colorHexCode.replaceAll('#', '0xFF');
  return int.tryParse ( colorHexCode ) ?? 0xFFFFF;
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
            backgroundColor: Color(hexCode('#7A9E9F')),
            title: Text("Living Room"),
      ),
        body: RoomItemPage(),
    ));
  }
}

class RoomItemPage extends StatefulWidget {
  const RoomItemPage({Key? key}) : super(key: key);

  @override
  State<RoomItemPage> createState() => _RoomItemPageState();
}

class _RoomItemPageState extends State<RoomItemPage> {

  final List<RoomItem> RoomItems = [
    RoomItem(name: "Couch", imageAsset: "assets/item1.png"),
    RoomItem(name: "Candle", imageAsset: "assets/item2.png"),
    RoomItem(name: "TV", imageAsset: "assets/item3.png"),
    RoomItem(name: "Coffee Table", imageAsset: "assets/item4.png"),
  ];
  int index = 0;

  void addItem(){
    setState(() {
      RoomItems.add(RoomItem(
          name: "New Item",
          imageAsset: "assets/item5.png"));
    });
  }

  void removeItem(int index){
    setState(() {
      RoomItems.removeAt(index);
    });
  }


  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Items',
          style: TextStyle(
              color: Color(0xff4f6367),
              fontSize: 35,
          ),
        ),
      ),
      body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                    gridDelegate:
                      const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 250,
                          childAspectRatio: 1,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20),
                    itemCount: RoomItems.length,
                    itemBuilder: (BuildContext ctx, index) {
                    return Container(
                      margin: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(3, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            RoomItems[index].imageAsset,
                            width: 100,
                            height: 100,
                          ),
                          SizedBox(height: 10.0),
                          Text(
                          RoomItems[index].name,
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: addItem,
                      child: Text('Add Item'),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFACB98B),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          RoomItems.removeAt(index);
                        });
                      },
                      child: Text('Remove Item'),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFFE5F55),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
    ));
  }
}




