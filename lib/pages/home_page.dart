import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:donut_app_2c_gaxiola/tabs/burger_tab.dart';
import 'package:donut_app_2c_gaxiola/tabs/donut_tab.dart';
import 'package:donut_app_2c_gaxiola/tabs/pancakes_tab.dart';
import 'package:donut_app_2c_gaxiola/tabs/pizza_tab.dart';
import 'package:donut_app_2c_gaxiola/tabs/smoothie_tab.dart';
import 'package:donut_app_2c_gaxiola/utils/my_tab.dart';
import 'package:donut_app_2c_gaxiola/providers/cart_provider.dart';
import 'package:donut_app_2c_gaxiola/profile_page.dart'; // Asegúrate de importar ProfilePage

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> myTabs = [
    const MyTab(iconPath: "lib/icons/donut.png"),
    const MyTab(iconPath: "lib/icons/burger.png"),
    const MyTab(iconPath: "lib/icons/smoothie.png"),
    const MyTab(iconPath: "lib/icons/pancakes.png"),
    const MyTab(iconPath: "lib/icons/pizza.png"),
  ];

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Icon(Icons.menu, color: Colors.grey[800]),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: IconButton(
                icon: const Icon(Icons.person),
                onPressed: () {
                  // Navega a la página de perfil
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfilePage()),
                  );
                },
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 36, vertical: 18),
              child: Row(
                children: [
                  Text("I want to ", style: TextStyle(fontSize: 32)),
                  Text(
                    "Eat",
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
            TabBar(tabs: myTabs),
            Expanded(
              child: TabBarView(
                children: [
                  DonutTab(),
                  BurgerTab(),
                  SmoothieTab(),
                  PancakesTab(),
                  PizzaTab(),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "${cartProvider.itemCount} Items | \$${cartProvider.totalPrice.toStringAsFixed(2)}"),
                  ElevatedButton(
                    onPressed: () {},
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                    child: const Text('View Cart'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
