import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

hexCode (String colorHexCode) {
  colorHexCode = colorHexCode.replaceAll('#', '0xFF');
  return int.tryParse ( colorHexCode ) ?? 0xFFFFF;
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text(
              'Homeventory Navigation',
              style: GoogleFonts.playfairDisplay(
                textStyle: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Color(hexCode('#7A9E9F')),
            ),
          ),
          ListTile(
            title: Text('Log In Page'),
            onTap: () {
              Get.offNamed('/');
            },
          ),
          ListTile(
            title: Text('Item Form Page'),
            onTap: () {
              Get.offNamed('/itemForm');
            },
          ),
          ListTile(
            title: Text('Room Item Page'),
            onTap: () {
              Get.offNamed('/roomItem');
            },
          ),
        ],
      ),
    );
  }
}