import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'login.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  File? file;
  @override
  bool secure = true;
  XFile? _image;

  pickImageFromgallery() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? xFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      setState(() {
        _image = xFile;
      });
    }
  }
  pickImageFromcamera() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? xFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (xFile != null) {
      setState(() {
        _image = xFile;
      });
    }
  }

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey();

  addUser(BuildContext context ) async {
    final uri=Uri.parse("http://192.168.98.135/php/self_order/API/add_user_api.php");
    var request=http.MultipartRequest("POST",uri);
    request.fields["Name"]=name.text;
    request.fields["Email"]=email.text;
    request.fields["Phonenumber"]=phone.text;
    request.fields["Password"]=password.text;
    var pic=await http.MultipartFile.fromPath("Photo",_image!.path);
    request.files.add(pic);
    var response=await request.send();
    if(response.statusCode==200){
      print("Sucess");
      Fluttertoast.showToast(msg: "Registerd");
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login(),));
    }else{
      Fluttertoast.showToast(msg: "Failed");
    }
  }
  void selectCameraorGallery() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 200,
        child: Row(
          children: [
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                         pickImageFromcamera();
                         Navigator.of(context).pop()
                          ;
                        },
                        child: Icon(
                          Icons.camera_alt,
                          size: 40,
                        )),
                    Text("Camera")
                  ],
                )),
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                          pickImageFromgallery();
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.file_copy,
                          size: 40,
                        )),
                    Text("Gallery")
                  ],
                ))
          ],
        ),
      ),
    );
  }





  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
              height: 700,
              width: 350,
              color: Colors.orangeAccent,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF232227)),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Stack(
                        children: [
                         _image == null
                              ? Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
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
                                      image: FileImage(File(_image!.path))
                                    )


                                  ),
                                ),
                          Positioned(
                              bottom: -10,
                              right: -10,
                              child: IconButton(
                                  onPressed: () {
                                    selectCameraorGallery();
                                  },
                                  icon: Icon(
                                    Icons.add_a_photo,
                                    color: Colors.white,
                                  )))
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 50,
                        width: 300,
                        child: TextFormField(
                          controller: name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "please enter your first name";
                            }
                          },

                          decoration: InputDecoration(
                            label: Text(
                              "Enter your name",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
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
                              label: Text(
                                "Enter your Email ",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              border: OutlineInputBorder()),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
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
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    secure = !secure;
                                  });
                                },
                                icon: Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: Colors.white,
                                ),
                              ),
                              label: Text(
                                "Enter your password",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              border: OutlineInputBorder()),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 50,
                        width: 300,
                        child: TextFormField(
                          controller: phone,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "please enter your phone";
                            } else if (value.length < 10 && value.length > 10) {
                              return "please enter a valid number";
                            }
                          },

                          decoration: InputDecoration(
                              label: Text(
                                "Enter your Phonenumber",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              border: OutlineInputBorder()),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            bool validate = formkey.currentState!.validate();
                            if (validate == true) {
                              addUser(context);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text("")));
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => Login(),
                              ));
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Color(0xFF232227)),
                              minimumSize: MaterialStatePropertyAll(
                                  Size(double.infinity, 50))),
                          child: Text("Sign In")),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account ?",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) => Login(),
                                ));
                              },
                              child: Text(
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
          )),
    );
  }
}
