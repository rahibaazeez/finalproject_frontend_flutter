import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selforder_food/cart.dart';
import 'package:selforder_food/hom3.dart';
import 'package:selforder_food/profile.dart';
import 'package:selforder_food/provider/cartprovider.dart';
import 'package:selforder_food/provider/profileprovider.dart';
import 'package:sweet_nav_bar/sweet_nav_bar.dart';

import 'login.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  int mainindex = 0;
  List pages = [Home3(),Cart(),Profile()];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Profileprovider>(context,listen: false).userCrenditails();


  }


  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[mainindex],
        bottomNavigationBar: SweetNavBar(
          currentIndex: mainindex,
          paddingBackgroundColor: Color(0xFF232227),
          items: [
            SweetNavBarItem(
                sweetActive: const Icon(Icons.home),
                sweetIcon: const Icon(
                  Icons.home_outlined,
                ),
                sweetLabel: 'Home',
                sweetBackground: Colors.blue),
            SweetNavBarItem(
                sweetIcon: const Icon(Icons.shopping_cart,),sweetLabel: 'cart' ),
            SweetNavBarItem(
                sweetIcon: const Icon(Icons.person,), sweetLabel: 'profile'),
          ],
          onTap: (index) {
            setState(() {
              mainindex=index;
            });
          },

        )

    );
  }
}