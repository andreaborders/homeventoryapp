import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

// models
import '../models/hexCode.dart';

// widgets
import '../widgets/bottom_sheet.dart';
import '../widgets/navigation_drawer.dart';

// routes
import '/main.dart';
import '/routes/logonPage.dart';
import '/routes/itemForm.dart';




final style = TextStyle(fontSize: 25, fontWeight: FontWeight.bold);

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return Scaffold(
          drawer: AppDrawer(),
          body:  const RoomItemPage(),
        );
      },
    );
  }
}


class RoomItemPage extends StatefulWidget {
  const RoomItemPage({Key? key}) : super(key: key);

  @override
  State<RoomItemPage> createState() => _RoomItemPageState();
}

class _RoomItemPageState extends State<RoomItemPage> {
  final ItemController itemController = Get.find();
  final List<Item> _items = [];
  String _searchText = '';


  int? get index => null;

  void addItem(Item newItem) {
    setState(() {
      _items.add(newItem);
    });
  }

  void showItemForm() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ItemFormPage();
      },
    );
  }

  void removeItem(int index) {
    final itemController = Get.find<ItemController>();
    itemController.items.removeAt(index);
    Get.back();
  }

  void _onSearchTextChanged(String searchText) {
    setState(() {
      _searchText = searchText;
    });
  }

  List<Item> _getFilteredItems() {
    if (_searchText.isEmpty) {
      return itemController.items;
    } else {
      return itemController.items
          .where((item) =>
      item.itemName?.toLowerCase()?.contains(_searchText.toLowerCase()) ?? false)
          .toList();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(hexCode('#7A9E9F')),
        title: Text(
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
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final searchText = await showSearch<String>(
                context: context,
                delegate: _SearchDelegate(itemController.items),
              );
              if (searchText != null && searchText.isNotEmpty) {
                setState(() {
                  _searchText = searchText;
                });
              }
            },
          ),
        ],
      ),
      body: Obx(() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 250,
            childAspectRatio: 1,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemCount: _getFilteredItems().length,
          itemBuilder: (BuildContext ctx, index) {
            return GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => BottomSheetWidget(
                    item: _getFilteredItems()[index],
                  ),
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
                    //Image.asset(
                    //  _items[index].itemImage,
                    //  width: 100,
                    //  height: 100,
                    // ),
                    const SizedBox(height: 10.0),
                    Text(
                      itemController.items[index].itemName ?? '',
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
      )),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: showItemForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFACB98B),
                ),
                child: const Text('Add Item'),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  final itemController = Get.find<ItemController>();
                  itemController.removeItem(index!); // pass the index of the item to be removed
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFE5F55),
                ),
                child: const Text('Remove Item'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _SearchDelegate extends SearchDelegate<String> {
  final List<Item> items;

  _SearchDelegate(this.items);

  @override
  String? get searchFieldLabel => 'Search items...';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<Item> filteredItems = items
        .where((item) =>
    item.itemName?.toLowerCase().contains(query?.toLowerCase() ?? '') ?? false)
        .toList();

    return ListView.builder(
      itemCount: filteredItems.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(filteredItems[index].itemName ?? ''),
          onTap: () {
            close(context, filteredItems[index].itemName ?? '');
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Item> filteredItems = items
        .where((item) =>
    item.itemName?.toLowerCase().contains(query?.toLowerCase() ?? '') ?? false)
        .toList();

    return ListView.builder(
      itemCount: filteredItems.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(filteredItems[index].itemName ?? ''),
          onTap: () {
            close(context, filteredItems[index].itemName ?? '');
          },
        );
      },
    );
  }
}
