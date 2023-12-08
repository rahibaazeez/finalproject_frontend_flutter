import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:selforder_food/cart.dart';
import 'package:selforder_food/hom3.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SingleviewNav extends StatefulWidget {
  String? f_id;
  String price;
  SingleviewNav({required this.f_id,required this.price});

  @override
  State<SingleviewNav> createState() => _SingleviewNavState();
}

class _SingleviewNavState extends State<SingleviewNav> {
  orDer({required fid,required id})async{
    var data={"f_id":fid,"id":id,"date":DateTime.now().toString()};
 Response response=await   post(Uri.parse("http://192.168.173.135/php/self_order/API/order_api.php"),body: data);
 print(response.body);
 if(response.statusCode==200){

 }
  }
  var id;
  Future userCrenditails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var result = await sharedPreferences.getInt("user");
    setState(() {
      id = result.toString();
    });

  }
  @override
  void initState() {
    userCrenditails();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                "Total price",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 5,),
              Text(
                widget.price,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.orange,

              ),
            child: Row(
              children: [InkWell(
                  onTap: (){
                    orDer(fid: widget.f_id, id: id);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Your order is selected")));
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Cart()));
                  },
                  child: Text("Order now",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),))],
            ),
            ),

        ],
      ),
    );
  }
}
