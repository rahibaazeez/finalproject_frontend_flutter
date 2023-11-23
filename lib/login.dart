import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:selforder_food/MyWidget/new_navbar.dart';
import 'package:selforder_food/hom3.dart';
import 'package:selforder_food/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'BottomNav.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formkey =GlobalKey();
  var secure=true;
  var result;
  int id=0;
  var data1;
 Future  login()async{
    var data={
      "email":email.text,"password":password.text
    };
    Response response=await post(Uri.parse("http://192.168.98.135/php/self_order/API/get_user_api.php"),body: data);
    print(response.body);
    if(response.statusCode==200){
      var result = jsonDecode(response.body);
      setState(() {
        data1=result;
      });
      print(data1);
      if(result["data"]==null){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Pleas register"),));
      }
      else{
        var data1=result["data"]["id"];
        setState(() {
          id=int.parse(data1);
        });
        userCrenditails();
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>BottomNav()));
      }
    }
  }
  userCrenditails()async{
SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
sharedPreferences.setInt("user", id);
var data=sharedPreferences.getInt("user");
sharedPreferences.setBool('u_log', true);
  }
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFF232227),
        // appBar: AppBar(
        //   backgroundColor: Colors.blue,
        //   title: Text("Login"),
        // ),
        body: Center(
          child: Container(
            height: 500,
            width: 350,
            color: Colors.orangeAccent,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Login", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Color(0xFF232227)),),
                    SizedBox(height: 50,),
                    SizedBox(
                      height: 50,
                      width: 300,
                      child: TextFormField(
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          final RegExp _emailRegex =
                          RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
                          if (value!.isEmpty) {
                            return "please enter your email";
                          } else if (!_emailRegex.hasMatch(value)) {
                            return "Enter a valid email";
                          }
                        },

                        decoration: InputDecoration(
                          label: Text("Email",style: TextStyle(fontSize: 18,color: Colors.white),),
                          border: OutlineInputBorder()
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    SizedBox(
                      height: 50,
                      width: 300,
                      child: TextFormField(
                        controller: password,
                        obscureText: secure,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "please enter password";
                          } else if (value.length < 6) {
                            return "Enter a value of length 6";
                          }
                        },

                        decoration: InputDecoration(
                          suffixIcon: IconButton(onPressed: (){
                            setState(() {
                              secure=!secure;
                            });
                          },icon: secure ?Icon(Icons.visibility_off,color: Colors.white,):Icon(Icons.visibility)),
                          label: Text("Password",style: TextStyle(color: Colors.white,fontSize: 18),),
                          border: OutlineInputBorder()
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    ElevatedButton(onPressed: (){
                      bool validator=formkey.currentState!.validate();
                      if(validator==true) {
                        login();
                      }
                    },
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Color(0xFF232227)),

                          minimumSize: MaterialStatePropertyAll(Size(double.infinity,50))
                        ),
                        child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 18),)),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Do you have an account?",style: TextStyle(color: Colors.white,fontSize: 18),),
                        TextButton(onPressed: (){
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Signup(),));
                        }, child: Text("Sign Up",style: TextStyle(color: Colors.white,fontSize: 18),))
                      ],
                    )

                  ],
                ),
              ),
            ),

          ),
        )
      ),
    );
  }
}
