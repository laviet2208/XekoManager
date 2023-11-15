import 'package:flutter/material.dart';
import 'package:xekomanagermain/dataClass/Product.dart';

class ItemFood extends StatelessWidget {
  final double width;
  final Product product;
  final Color color;
  const ItemFood({Key? key, required this.width, required this.product, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: width,
      decoration: BoxDecoration(
        color: color,
        border: Border(
          bottom: BorderSide(
            color: Color.fromARGB(255, 240, 240, 240),
            width: 1.0,
          ),
        ),
      ),
    );
  }
}

