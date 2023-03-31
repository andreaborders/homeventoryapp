import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'models/items.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/bottom_sheet.dart';
import 'package:get/get.dart';
import 'main.dart';
import 'widgets/navigation_drawer.dart';

hexCode (String colorHexCode) {
  colorHexCode = colorHexCode.replaceAll('#', '0xFF');
  return int.tryParse ( colorHexCode ) ?? 0xFFFFF;
}

class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
        backgroundColor: Color(hexCode('#7A9E9F')),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_a_photo,
                size: 100,
              ),
              SizedBox(height: 70),
              Text(
                "WELCOME",
                style: GoogleFonts.playfairDisplay(
                  fontSize: 45,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}