


import 'package:flutter/material.dart';

import 'package:provider/provider.dart';


import 'package:selforder_food/ipdata.dart';
import 'package:selforder_food/provider/profileprovider.dart';




class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    Provider.of<Profileprovider>(context,listen: false).getUser(context);
    Provider.of<Profileprovider>(context,listen: false).userCrenditails();
    return Scaffold(

      backgroundColor: const Color(0xFF232227),
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Center(child: Text("Profile",style: Theme.of(context).textTheme.headlineMedium),),
      ),
      body: FutureBuilder(
        future: Provider.of<Profileprovider>(context ,listen: false).getUser(context),
        builder: (context,snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.hasData){
            return Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage("${ipData.ip}/${ipData.image2}/${snapshot.data["data"]["Photo"]}"),
                            fit: BoxFit.fill
                          )
                      ),
                    ),
                    Text(snapshot.data["data"]["Name"],style: const TextStyle(color: Colors.orangeAccent,fontSize: 40),),
                    const SizedBox(
                      height: 50,
                    ),
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 40),
                          child: Icon(Icons.call,color: Colors.orangeAccent,size: 40,),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 60),
                          child: Text("Phonenumber",style: TextStyle(fontSize: 25,color: Colors.orangeAccent),),
                        )
                      ],

                    ),
                    Text(snapshot.data["data"]["Phonenumber"],style: const TextStyle(color: Colors.white,fontSize: 20),),
                    const SizedBox(height:50 ),
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 40),
                          child: Icon(Icons.email_rounded,color: Colors.orangeAccent,size: 40,),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 60),
                          child: Text("Email",style: TextStyle(fontSize: 25,color: Colors.orangeAccent),),
                        )
                      ],

                    ),
                    Text(snapshot.data["data"]["Email"],style: const TextStyle(color: Colors.white,fontSize: 20),),
                  ],
                ),
              ),
            );


          }else{
            return const Center(
              child: Text("Something wrong"),
            );
          }

        }
      ),
      //bottomNavigationBar: HomenavBar(),
    );
  }
}
