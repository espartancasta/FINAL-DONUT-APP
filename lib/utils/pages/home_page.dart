import 'package:donut_app_2c_gaxiola/tabs/burger_tab.dart';
import 'package:donut_app_2c_gaxiola/tabs/donut_tab.dart';
import 'package:donut_app_2c_gaxiola/tabs/pancakes_tab.dart';
import 'package:donut_app_2c_gaxiola/tabs/pizza_tab.dart';
import 'package:donut_app_2c_gaxiola/tabs/smoothie_tab.dart';
import 'package:donut_app_2c_gaxiola/utils/my_tab.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> myTabs = [
    const MyTab(iconPath: 'lib/icons/donut.png'),
    const MyTab(iconPath: 'lib/icons/burger.png'),
    const MyTab(iconPath: 'lib/icons/smoothie.png'),
    const MyTab(iconPath: 'lib/icons/pancakes.png'),
    const MyTab(iconPath: 'lib/icons/pizza.png')
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          // Ícono izquierdo
          leading:
              Icon(Icons.menu, color: const Color.fromARGB(255, 104, 103, 103)),
          // Ícono derecho
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 24.0),
              child: Icon(Icons.person),
            ),
          ],
        ),
        body: Column(
          children: [
            // Texto principal
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 18),
              child: Row(
                children: [
                  Text(
                    "I want to",
                    style: TextStyle(fontSize: 32),
                  ),
                  Text(
                    "Eat",
                    style: TextStyle(
                      // Tamaño de letra
                      fontSize: 32,

                      // Negritas
                      fontWeight: FontWeight.bold,

                      // Subrayado
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),

            // Pestañas (tabBar)

            TabBar(tabs: myTabs),
            // Contenido de pestañas
            Expanded(
                child: TabBarView(children: [
              DonutTab(),
              BurgerTab(),
              SmoothieTab(),
              PancakesTab(),
              PizzaTab(),
            ]))
            // Carrito (car)
          ],
        ),
      ),
    );
  }
}
