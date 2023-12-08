import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:selforder_food/hom3.dart';
import 'package:selforder_food/provider/loginprovider.dart';
import 'package:selforder_food/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'BottomNav.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override


  Widget build(BuildContext context) {
   // Provider.of<Loginprovider>(context,listen: false).userCrenditails();
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor:Colors.black12,
        // appBar: AppBar(
        //   backgroundColor: Colors.blue,
        //   title: Text("Login"),
        // ),
        body: Center(
          child: Container(
            height: 500,
            width: 350,

            decoration: BoxDecoration(
              color: Colors.orangeAccent,
                borderRadius: BorderRadius.circular(20.0),

            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: Provider.of<Loginprovider>(context,listen: false).formkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Login", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Color(0xFF232227)),),
                    SizedBox(height: 50,),
                    SizedBox(
                      height: 50,
                      width: 300,
                      child: TextFormField(
                        controller: Provider.of<Loginprovider>(context,listen: false).email,
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
                        controller: Provider.of<Loginprovider>(context,listen: false).password,
                        obscureText:  Provider.of<Loginprovider>(context,listen: false).secure,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "please enter password";
                          } else if (value.length < 6) {
                            return "Enter a value of length 6";
                          }
                        },

                        decoration: InputDecoration(
                          suffixIcon: IconButton(onPressed: (){

                              Provider.of<Loginprovider>(context,listen: false).secure=!Provider.of<Loginprovider>(context,listen: false).secure;

                          },icon:Provider.of<Loginprovider>(context,listen: false).secure?Icon(Icons.visibility_off,color: Colors.white,):Icon(Icons.visibility)),
                          label: Text("Password",style: TextStyle(color: Colors.white,fontSize: 18),),
                          border: OutlineInputBorder()
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    ElevatedButton(onPressed: (){
                      bool validator=Provider.of<Loginprovider>(context,listen: false).formkey.currentState!.validate();
                      if(validator==true) {
                        Provider.of<Loginprovider>(context,listen: false).logIn(email: Provider.of<Loginprovider>(context,listen: false).email.text, password: Provider.of<Loginprovider>(context,listen: false).password.text, context:context );
                      }
                      Provider.of< Loginprovider>(context,listen: false).clear();
                    },
                        style:ElevatedButton.styleFrom(backgroundColor: Color(0xFF232227),side: BorderSide.none,shape: const StadiumBorder()),
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
