

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:selforder_food/BottomNav.dart';
import 'package:selforder_food/MyWidget/singleview_navbar.dart';
import 'package:selforder_food/ipdata.dart';
import 'package:selforder_food/modelclass/singleviewmodelclass.dart';
import 'package:selforder_food/provider/singleviewprovider.dart';

class Singleitemview extends StatelessWidget {
  final String foodId;
 final String price;
const Singleitemview({super.key, required this.foodId,required this.price});
  // Track the quantity of the food item
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(leading: InkWell(onTap: (){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const BottomNav()));
      },
          child: const Icon(Icons.arrow_back,color: Colors.orangeAccent,)),
      backgroundColor: Colors.black,),
      body: FutureBuilder<Singleviewmodelclass>(
          future: Provider.of<Singleviewprovider>(context,listen: false).singleView(foodId,price),
          builder: (context,AsyncSnapshot<Singleviewmodelclass> snapshot) {
            // if(snapshot.connectionState==ConnectionState.waiting){
            //   return Center(
            //     child: CircularProgressIndicator(),
            //   );
            // }

            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data!.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Column(
                      children: [
                        Center(
                          child:ClipRRect(
                            borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
                            child: Image.network(
                              "${ipData.ip}/${ipData.image}/${snapshot.data!.data![index].photo}",
                              height: 400,
                              width: 350,
                              fit: BoxFit.fill,
                            ),
                          ),

                        ),
const SizedBox(height: 20,),
                        Center(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                snapshot.data!.data![index].foodName!,
                                style: GoogleFonts.vinaSans(color: Colors.black,fontSize: 30)
                            ),
                          ),
                        ),
                        const SizedBox(height: 30,),
                        const Text("Ingredients included",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.black),),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              snapshot.data!.data![index].ingredients!,
                              style: GoogleFonts.vinaSans(color: Colors.black,fontSize: 20)
                          ),
                        ),


                      ],
                    ),
                  );

                },);
            }else{
              return const Center(
                child: Text("Something wrong"),
              );
            }
          }
      ),
      bottomNavigationBar: SingleviewNav(fId: foodId, price: price,),
    );
  }
}
