
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';


import 'package:selforder_food/provider/splascreenprovider.dart';



class Splashscreen extends StatelessWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    Provider.of<Splashscreenprovider>(context,listen: false).checkLogin(context);
    //Provider.of<Loginprovider>(context,listen: false).userCrenditails();
    return Scaffold(
      body: Center(
        child: Lottie.asset("assets/Animation - 1700712033224.json",width: 1000,height: 1000),
      ),

    );
  }
}
