
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selforder_food/provider/feedbackprovider.dart';


import 'BottomNav.dart';


class FeedBack extends StatelessWidget {
 final TextEditingController feedback = TextEditingController();

  FeedBack({super.key});
  // const FeedBack({Key? key}) : super(key: key);

  @override
  

  @override
  Widget build(BuildContext context) {
    
    Provider.of<Feedbackprovider>(context,listen: false).userCrenditails();
    return Scaffold(
      appBar: AppBar(title: const Text('FeedBack'),backgroundColor: Colors.orangeAccent),
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
            const SizedBox(height: 20),
            MaterialButton(
              onPressed: () {
               Provider.of<Feedbackprovider>(context,listen: false).feedBack(feedback: feedback.text, id: Provider.of<Feedbackprovider>(context,listen: false).userId);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const BottomNav(),
                ));
              },
              color: Colors.orangeAccent,
              child: const Text(
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