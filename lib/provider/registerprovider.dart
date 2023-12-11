


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../login.dart';

class Signupprovider extends ChangeNotifier{
  bool secure = true;
  XFile? image;

  pickImageFromgallery() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? xFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (xFile != null) {

        image = xFile;
    }
    notifyListeners();
  }
  pickImageFromcamera() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? xFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (xFile != null) {

        image = xFile;
    }
    notifyListeners();
  }

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey();

  addUser(BuildContext context ) async {
    if(formkey.currentState?.validate()??false){
      final uri=Uri.parse("http://192.168.173.135/php/self_order/API/add_user_api.php");
      var request=http.MultipartRequest("POST",uri);
      request.fields["Name"]=name.text;
      request.fields["Email"]=email.text;
      request.fields["Phonenumber"]=phone.text;
      request.fields["Password"]=password.text;
      var pic=await http.MultipartFile.fromPath("Photo",image!.path);
      request.files.add(pic);
      var response=await request.send();
      if(response.statusCode==200){
        Fluttertoast.showToast(msg: "Registerd");

          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Login()));


      }else{
        Fluttertoast.showToast(msg: "Failed");
      }
    }
    notifyListeners();
  }
  void selectCameraorGallery(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
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
                        child: const Icon(
                          Icons.camera_alt,
                          size: 40,
                        )),
                    const Text("Camera")
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
                        child: const Icon(
                          Icons.file_copy,
                          size: 40,
                        )),
                    const Text("Gallery")
                  ],
                ))
          ],
        ),
      ),
    );
    notifyListeners();
  }



}