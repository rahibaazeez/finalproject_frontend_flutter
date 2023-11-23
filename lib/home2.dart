import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:selforder_food/MyWidget/new.dart';
import 'package:selforder_food/MyWidget/products.dart';

class Home2 extends StatefulWidget {
  const Home2 ({Key? key}) : super(key: key);

  @override
  State<Home2> createState() => _State();
}

class _State extends State<Home2> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: Column(
          children: [
            Center(
              child: Text("Delivery to ".toUpperCase(),style: TextStyle(
                color: Colors.blue,fontSize: 20
              ),),
            ),
            Text("Calicut",style: TextStyle(color: Colors.green,fontSize: 30),)
          ],
        ),
      ),
      body:SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CarouselSlider(
            options: CarouselOptions(height: 300,autoPlay: true),
            items: [33,2,3,4,5].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                          color: Colors.amber
                      ),
                      child: Text('text $i', style: TextStyle(fontSize: 16.0),)
                  );
                },
              );
            }).toList(),
          ),
            SizedBox(height: 10,),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context,index) {
                    return Products(name: "myfood", price: "100");
                  }
              ),
            ),
            SizedBox(height: 20,),
            New()



          ],
        ),
      )
    );
  }
}


