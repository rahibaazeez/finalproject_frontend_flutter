import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:selforder_food/cart.dart';
import 'package:selforder_food/hom3.dart';
import 'package:selforder_food/login.dart';
import 'package:selforder_food/profile.dart';

class HomenavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: 60,
      decoration: BoxDecoration(color: Color(0xFF232227), boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.4),
          spreadRadius: 1,
          blurRadius: 8,
        )
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Home3()));
            },
            child: Icon(

              Icons.home,
              color: Colors.white,
              size: 25,
            ),
          ),

          InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Cart()));
            },
            child: Icon(Icons.shopping_cart,color: Colors.white,size: 35,),
          ),
          InkWell(
            onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Profile()));
            },
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 30,
            ),
          ),



        ],
      ),
    );
  }
}
