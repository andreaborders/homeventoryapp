import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

// models
import '../models/hexCode.dart';

// routes
import '../main.dart';
import '../routes/roomItemsPage.dart';


class Item {
  int? itemId;
  String? itemName;
  String? itemType;
  String? itemSubtype;
  String? itemBrand;
  String? itemModel;
  String? itemDimensions;
  String? itemNotes;
  String? itemColor;
  File? itemImage;

  Item({
    required this.itemId,
    required this.itemName,
    required this.itemType,
    this.itemSubtype,
    this.itemBrand,
    this.itemModel,
    required this.itemDimensions,
    this.itemNotes,
    this.itemImage,
    this.itemColor,
  });
}



class ItemController extends GetxController {
  final items = <Item>[].obs;
  final highestId = 0.obs;

  void addItem(Item item) {
    items.add(item);
    highestId.value = item.itemId!;
  }

  void removeItem(int index) {
    final itemController = Get.find<ItemController>();
    itemController.items.removeAt(index);
    Get.back();
  }
}

// void main() => runApp(ItemFormPage());

class ItemFormPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _itemNameController = TextEditingController();
  final _itemTypeController = TextEditingController();
  final _itemSubtypeController = TextEditingController();
  final _itemBrandController = TextEditingController();
  final _itemModelController = TextEditingController();
  final _itemDimensionsController = TextEditingController();
  final _itemColorController = TextEditingController();
  final _notesController = TextEditingController();

  String imageUrl = '';


  ItemFormPage({super.key});



  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newItem = Item(
        itemId: Get.find<ItemController>().highestId.value + 1,
        itemName: _itemNameController.text!,
        itemType: _itemTypeController.text!,
        itemSubtype: _itemSubtypeController.text!,
        itemBrand: _itemBrandController.text!,
        itemModel: _itemModelController.text!,
        itemDimensions: _itemDimensionsController.text!,
        itemColor: _itemColorController.text!,
        itemNotes: _notesController.text!,
      );

      final itemController = Get.find<ItemController>();
      itemController.addItem(newItem);

      Get.off(() => const RoomItemPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Item'),
        centerTitle: true,
        backgroundColor: Color(hexCode('#7A9E9F')),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _itemNameController,
                decoration: const InputDecoration(labelText: 'Item Name'),
                validator: (value) => value!.isEmpty ? 'Please enter an Item Name' : null,
              ),
              TextFormField(
                controller: _itemTypeController,
                decoration: InputDecoration(labelText: 'Item Type'),
                validator: (value) => value!.isEmpty ? 'Please enter type of Item' : null,
              ),
              TextFormField(
                controller: _itemSubtypeController,
                decoration: InputDecoration(labelText: 'Item SubType'),
                validator: (value) => value!.isEmpty ? 'Please enter the item Subtype' : null,
              ),
              TextFormField(
                controller: _itemBrandController,
                decoration: InputDecoration(labelText: 'Item Brand'),
                validator: (value) => value!.isEmpty ? 'Please enter the item Brand' : null,
              ),
              TextFormField(
                controller: _itemModelController,
                decoration: InputDecoration(labelText: 'Item Model'),
                validator: (value) => value!.isEmpty ? 'Please enter the item Model' : null,
              ),
              TextFormField(
                controller: _itemDimensionsController,
                decoration: InputDecoration(labelText: 'Item Dimensions'),
                validator: (value) => value!.isEmpty ? 'Please enter the item Dimensions' : null,
              ),
              TextFormField(
                controller: _itemColorController,
                decoration: InputDecoration(labelText: 'Item Color'),
                validator: (value) => value!.isEmpty ? 'Please enter the item Color' : null,
              ),
              TextFormField(
                controller: _notesController,
                decoration: InputDecoration(labelText: 'Item Notes'),
                validator: (value) => value!.isEmpty ? 'Please enter any additional item information' : null,
              ),

              SizedBox(height: 5.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFACB98B)),
              ),
              SizedBox(height: 5.0),
            ],
          ),
        ),
      ),
    );
  }
}