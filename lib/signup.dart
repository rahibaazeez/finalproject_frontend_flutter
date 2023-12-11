
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:selforder_food/provider/loginprovider.dart';
import 'package:selforder_food/provider/registerprovider.dart';

import 'login.dart';

class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          backgroundColor: const Color(0xFF232227),
          // appBar: AppBar(
          //   backgroundColor: Colors.blue,
          //   title: Text("Login"),
          // ),
          body: SingleChildScrollView(
            child: Center(
              child: Container(
                height: 750,
                width: 350,

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),

                  color: Colors.orangeAccent
                ),

                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: Provider.of<Signupprovider>(context,listen: false).formkey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Create your new account",
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF232227)),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Stack(
                          children: [
                            Provider.of<Signupprovider>(context,listen: false).image == null
                                ? Container(
                                    height: 100,
                                    width: 100,
                                    decoration: const BoxDecoration(
                                        color: Color(0xFF232227),
                                        shape: BoxShape.circle),
                                  )
                                : Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: FileImage(File(Provider.of<Signupprovider>(context,listen: false).image!.path))
                                      )


                                    ),
                                  ),
                            Positioned(
                                bottom: -10,
                                right: -10,
                                child: IconButton(
                                    onPressed: () {
                                      Provider.of<Signupprovider>(context,listen: false).selectCameraorGallery(context);
                                    },
                                    icon: const Icon(
                                      Icons.add_a_photo,
                                      color: Colors.white,
                                    )))
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 50,
                          width: 300,
                          child: TextFormField(
                            controller: Provider.of<Signupprovider>(context,listen: false).name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "please enter your first name";
                              }
                              return null;
                            },

                            decoration: const InputDecoration(
                              label: Text(
                                "Enter your name",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 18),
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 50,
                          width: 300,
                          child: TextFormField(
                            controller: Provider.of<Signupprovider>(context,listen: false).email,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              final RegExp emailRegex =
                              RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
                              if (value!.isEmpty) {
                                return "please enter your email";
                              } else if (!emailRegex.hasMatch(value)) {
                                return "Enter a valid email";
                              }
                              return null;
                            },

                            decoration: const InputDecoration(
                                label: Text(
                                  "Enter your Email ",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                border: OutlineInputBorder()),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 50,
                          width: 300,
                          child: TextFormField(
                            controller: Provider.of<Signupprovider>(context,listen: false).password,
                            obscureText: Provider.of<Signupprovider>(context,listen: false).secure,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "please enter password";
                              } else if (value.length < 6) {
                                return "Enter a value of length 6";
                              }
                              return null;
                            },

                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {

                                      Provider.of<Loginprovider>(context,listen: false).security();

                                  },
                                  icon: Provider.of<Loginprovider>(context,listen: false).secure==false?const Icon(Icons.visibility,color: Colors.white,):const Icon(Icons.visibility_off)
                                ),
                                label: const Text(
                                  "Enter your password",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                border: const OutlineInputBorder()),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 50,
                          width: 300,
                          child: TextFormField(
                            controller: Provider.of<Signupprovider>(context,listen: false).phone,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "please enter your phone";
                              } else if (value.length < 10 && value.length > 10) {
                                return "please enter a valid number";
                              }
                              return null;
                            },

                            decoration: const InputDecoration(
                                label: Text(
                                  "Enter your Phonenumber",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                border: OutlineInputBorder()),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              bool validate = Provider.of<Signupprovider>(context,listen: false).formkey.currentState!.validate();
                              if (validate) {
                                Provider.of<Signupprovider>(context,listen: false).addUser(context);
                              }else{
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(content: Text("no data")));
                              }
                            },style:ElevatedButton.styleFrom(backgroundColor: const Color(0xFF232227),side: BorderSide.none,shape: const StadiumBorder()),
                            child: const Text("Sign In")),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account ?",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                    builder: (context) => const Login(),
                                  ));
                                },
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}


