import 'package:flutter/material.dart';

class ShipIcon extends StatelessWidget {
  const ShipIcon({super.key, required this.count, required this.type});

  final int count;
  final String type;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 15,
      //TODO: Replace this color with the player's color
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            type,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              decoration: TextDecoration.none,
            ),
          ),
          Text(
            '$count',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}
