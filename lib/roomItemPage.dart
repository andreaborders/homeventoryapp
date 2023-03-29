import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'models/items.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/bottom_sheet.dart';
import 'package:get/get.dart';
import 'main.dart';
import 'widgets/navigation_drawer.dart';


void main() {
  runApp( MyApp());

}
final style = TextStyle(fontSize: 25, fontWeight: FontWeight.bold);

hexCode (String colorHexCode) {
  colorHexCode = colorHexCode.replaceAll('#', '0xFF');
  return int.tryParse ( colorHexCode ) ?? 0xFFFFF;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => MyHomePage()),
        GetPage(name: '/roomItem', page: () => const RoomItemPage()),
      ],
      builder: (context, child) {
        return Scaffold(
          drawer: AppDrawer(),
          body: child,
        );
      },
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(hexCode('#7A9E9F')),
          title: Text(
            "Living Room",
            style: GoogleFonts.playfairDisplay(
              textStyle: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        body: const RoomItemPage(),
      ),
    );
  }
}


class RoomItemPage extends StatefulWidget {
  const RoomItemPage({Key? key}) : super(key: key);

  @override
  State<RoomItemPage> createState() => _RoomItemPageState();
}

class _RoomItemPageState extends State<RoomItemPage> {

  final List<RoomItem> RoomItems = [
    RoomItem(name: "Couch", imageAsset: "assets/item1.png", description: "This is a blue couch."),
    RoomItem(name: "Candle", imageAsset: "assets/item2.png", description: "This is a candle."),
    RoomItem(name: "TV", imageAsset: "assets/item3.png", description: "This is a TV."),
    RoomItem(name: "Coffee Table", imageAsset: "assets/item4.png", description: "This is a coffee table."),
  ];
  int index = 0;

  void addItem(){
    setState(() {
      RoomItems.add(RoomItem(
          name: "New Item",
          imageAsset: "assets/item5.png",
          description: "item"));
    });
  }

  void removeItem(int index){
    setState(() {
      RoomItems.removeAt(index);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(hexCode('#7A9E9F')),
          title:  Text(
            'Items',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Color(0xff4f6367),
                fontSize: 35,
              ),
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
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
                    return GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => BottomSheetWidget(roomItem: RoomItems[index])
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(3, 4),
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
                            const SizedBox(height: 10.0),
                            Text(
                              RoomItems[index].name,
                              style: const TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFACB98B),
                      ),
                      child: const Text('Add Item'),
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFE5F55),
                      ),
                      child: const Text('Remove Item'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}




