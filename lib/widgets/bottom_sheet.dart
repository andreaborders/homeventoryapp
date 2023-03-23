import 'package:flutter/material.dart';
import '../models/items.dart';


class BottomSheetWidget extends StatelessWidget {
  final RoomItem roomItem;

  const BottomSheetWidget({Key? key, required this.roomItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            roomItem.imageAsset,
            width: 100,
            height: 100,
          ),
          const SizedBox(height: 20.0),
          Text(
            roomItem.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          Text(
            roomItem.description,
            style: const TextStyle(
              fontSize: 10.0,
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFE5F55),
            ),
            child: const Text('Close Item'),
          ),
        ],
      ),
    );
  }
}