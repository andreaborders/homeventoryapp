import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

// firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'firebase_options.dart';

// routes
import 'routes/itemForm.dart';
import 'routes/logonPage.dart';
import 'routes/roomItemsPage.dart';
import 'routes/uploadImagePage.dart';

// widgets
import 'widgets/bottom_sheet.dart';
import 'widgets/navigation_drawer.dart';

// models
import 'models/hexCode.dart';


final style = TextStyle(fontSize: 25, fontWeight: FontWeight.bold);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(ItemController());
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Homeventory App',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/roomItem', page: () => RoomItemPage()),
        GetPage(name: '/itemForm', page: () => ItemFormPage()),
        GetPage(name: '/uploadImage', page: () => ImageUploadPage()),
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
        centerTitle: true,
        backgroundColor: Color(hexCode('#7A9E9F')),
        title: Text(
          'Homeventory',
          style: GoogleFonts.playfairDisplay(
            textStyle: const TextStyle(
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
      body: Center(
        child: Text('This is the home page'),
      ),
    );
  }
}





