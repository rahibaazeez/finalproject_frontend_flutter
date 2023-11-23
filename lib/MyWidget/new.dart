import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class New extends StatelessWidget {
  const New({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 4,
          itemBuilder: (context,index) {
            return Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.blue,

                      borderRadius: BorderRadius.circular(10)
                  ),

                  child: Text("hello"),
                ),
                SizedBox(height: 10,)
              ],

            );

          }
      ),
    );
  }
}