// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'package:selforder_food/ipdata.dart';
//
// class Sample1 extends StatefulWidget {
//   const Sample1({Key? key}) : super(key: key);
//
//   @override
//   State<Sample1> createState() => _Sample1State();
// }
//
// class _Sample1State extends State<Sample1> {
//   TextEditingController searchdata=TextEditingController();
//   var searchValue= "";
//   Future searching()async{
//     var data={"a":searchValue};
//     Response response=await post(Uri.parse("http://192.168.98.135/php/self_order/API/search_api.php"),body: data);
//     if(response.statusCode==200){
//       var result=jsonDecode(response.body);
//
//       return result;
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Search"),
//         backgroundColor:Colors.orangeAccent,
//       ),
//       body: ListView(
//         children: [
//           TextField(
//             controller: searchdata,
//             decoration: InputDecoration(
//                 suffixIcon: IconButton(onPressed: (){
//                   searchValue=searchdata.text;
//                   setState(() {
//
//                   });
//
//                 },icon: Icon(Icons.search_off),),
//                 border: OutlineInputBorder()
//             ),
//           ),
//           SizedBox(
//             height: 650,
//             child: FutureBuilder(
//                 future:searching() ,
//                 builder: (context,snapshot) {
//                   // if(snapshot.connectionState==ConnectionState.waiting){
//                   //   return Center(
//                   //     child: CircularProgressIndicator(),
//                   //   );
//                   //}
//                   if(snapshot.hasData){
//                     if(snapshot.data["data"]==null){
//                       return Center(
//                         child: Text("no data"),
//                       );
//                     }else{
//                       return ListView.builder(
//                           itemCount: snapshot.data["data"].length,
//                           itemBuilder: (context,index) {
//                             return ListTile(
//                               leading: Container(
//                                 height: 100,
//                                 width: 100,
//                                 decoration: BoxDecoration(
//                                     color: Colors.orangeAccent,
//                                     shape: BoxShape.circle,
//                                     image: DecorationImage(
//                                         image: NetworkImage("${ipData.ip}/${ipData.image}/${snapshot.data["data"][index]["photo"]}"),
//                                         fit: BoxFit.fill
//                                     )
//                                 ),
//                               ),
//                               title: Text(snapshot.data["data"][index]["food_name"]),
//                               subtitle: Text(snapshot.data["data"][index]["price"]),
//                               trailing: Icon(Icons.more_vert_outlined),
//                             );
//                           }
//                       );
//
//                     }}else{
//                     return Center(
//                       child: Text("no data"),
//                     );
//                   }
//                 }
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
