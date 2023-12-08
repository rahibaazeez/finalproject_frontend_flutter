import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:selforder_food/provider/feedbackprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'BottomNav.dart';


class FeedBack extends StatelessWidget {
  TextEditingController feedback = TextEditingController();
  // const FeedBack({Key? key}) : super(key: key);

  @override
  

  @override
  Widget build(BuildContext context) {
    
    Provider.of<Feedbackprovider>(context,listen: false).userCrenditails();
    return Scaffold(
      appBar: AppBar(title: Text('FeedBack'),backgroundColor: Colors.orangeAccent),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: feedback,
              decoration: InputDecoration(
                  hintText: "What's on your mind ?",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      feedback.clear();
                    },
                    icon: const Icon(Icons.clear),
                  )),
            ),
            SizedBox(height: 20),
            MaterialButton(
              onPressed: () {
               Provider.of<Feedbackprovider>(context,listen: false).feedBack(feedback: feedback.text, id: Provider.of<Feedbackprovider>(context,listen: false).user_id);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => BottomNav(),
                ));
              },
              color: Colors.orangeAccent,
              child: Text(
                'Post',
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}