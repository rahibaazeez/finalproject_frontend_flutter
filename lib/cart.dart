


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selforder_food/ipdata.dart';
import 'package:selforder_food/modelclass/orderviewmodelclass.dart';
import 'package:selforder_food/provider/cartprovider.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<Cartprovider>(context,listen: false).userCrenditails();
    Provider.of<Cartprovider>(context,listen: false).cartList();

    return Scaffold(
      backgroundColor: const Color(0xFF232227),
      appBar: AppBar(
        backgroundColor: const Color(0xFF232227),
        title: const Text("Cart",style: TextStyle(color: Colors.orangeAccent,fontSize: 25),),
      ),
      body:
      FutureBuilder<Orderviewmodelclass>(
          future:  Provider.of<Cartprovider>(context,listen: false).cartList(),
          builder: (context, AsyncSnapshot<Orderviewmodelclass> snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }if(snapshot.hasData){
              if(snapshot.data!.data==null){
                return const Center(child: Text("No data"),);
              }
              return ListView.builder(

                  itemCount: snapshot.data!.data!.length,
                  itemBuilder: (context,index) {
                    return Padding(
                      padding: const EdgeInsets.all(15),
                      child: ListTile(
                        tileColor: Colors.orangeAccent,
                        textColor: Colors.black,

                        title: Text(snapshot.data!.data![index].foodName.toString()),
                        subtitle: Text(snapshot.data!.data![index].orderDate.toString()),
                        leading: CircleAvatar(
                          backgroundColor: Colors.black,
                          backgroundImage: NetworkImage('${ipData.ip}/${ipData.image}/${snapshot.data!.data![index].photo}'),

                        ),



                        trailing: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black
                          ),

                          onPressed: (){
                          Provider.of<Cartprovider>(context,listen: false).removeOrder(id:snapshot.data!.data![index].orderId);
                         },child:const Text("Remove",style: TextStyle(color: Colors.orangeAccent),),),
                      ),
                    );
                  }
              );
            }else{
              return const Center(
                child:Text("Something went wrong") ,
              );
            }

          }
          ),


    );
  }
}
