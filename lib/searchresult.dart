
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:selforder_food/ipdata.dart';
import 'package:selforder_food/modelclass/searchresultmodelclass.dart';
import 'package:selforder_food/provider/searchresultprovider.dart';


import 'MyWidget/singleview_navbar.dart';


class Searchresult extends StatefulWidget {
  final String foodId;
 final String price;
  const Searchresult ({super.key, required this.foodId,required this.price});

  @override
  State<Searchresult> createState() => _SearchresultState();
}

class _SearchresultState extends State<Searchresult> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(leading: InkWell(onTap: (){
        Navigator.pop(context);
      },
          child: const Icon(Icons.arrow_back,color: Colors.orangeAccent,)),
        backgroundColor: Colors.black,),
      body: FutureBuilder<Searchresultmodelclass>(
          future: Provider.of<Searchresultprovider>(context,listen: false).searchView(widget.foodId,widget.price),
          builder: (context,AsyncSnapshot<Searchresultmodelclass> snapshot) {
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
                          child: Image.network("${ipData.ip}/${ipData.image}/${snapshot.data!.data![index].photo}",
                            height: 400,
                            width: 350,


                            fit: BoxFit.fill,
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Center(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                snapshot.data!.data![index].foodName!,
                                style: GoogleFonts.vinaSans(color: Colors.black,fontSize: 20)
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
      bottomNavigationBar: SingleviewNav(fId:widget.foodId, price: widget.price),
    );
  }
}
