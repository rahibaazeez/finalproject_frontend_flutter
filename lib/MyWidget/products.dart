import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  String name,price;
  Products({required this.name,required this.price});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            color: Colors.blue,
            )
          ),
          Text(widget.name),
          Text(widget.price)
        ],
      ),
    );
  }
}
