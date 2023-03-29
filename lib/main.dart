import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'roomItemPage.dart';
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
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Homeventory App',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => MyHomePage()),
        GetPage(name: '/roomItem', page: () => RoomItemPage()),
      ],
      builder: (context, child) {
        return Scaffold(
          drawer: AppDrawer(),
          body: child,
        );
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homeventory'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      body: Center(
        child: Text('This is the home page'),
      ),
    );
  }
}

