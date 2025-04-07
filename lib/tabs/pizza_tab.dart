import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importa Provider
import 'package:donut_app_2c_gaxiola/utils/donut_tile.dart';
import 'package:donut_app_2c_gaxiola/providers/cart_provider.dart'; // Importa el proveedor del carrito

class PizzaTab extends StatelessWidget {
  // Lista de pizzas
  final List pizzasOnSale = [
    [
      "Pizza Margarita",
      "Pizza's",
      "135",
      Colors.blue,
      "lib/images/pizza_margarita.png"
    ],
    [
      "Pizza Peperoni",
      "Pizza's",
      "135",
      Colors.red,
      "lib/images/pizza_peperoni.png"
    ],
    [
      "Pizza Hawaiana",
      "Pizza's",
      "150",
      Colors.pink,
      "lib/images/pizza_hawaiana.png"
    ],
    [
      "Pizza honolulu",
      "Pizza's",
      "150",
      Colors.brown,
      "lib/images/pizza_honolulu.png"
    ],
    [
      "Pizza surtida",
      "Pizza's",
      "150",
      Colors.yellow,
      "lib/images/pizza_surtida.png"
    ],
    [
      "Pizza Cheese",
      "Pizza's",
      "150",
      Colors.purple,
      "lib/images/Pizza_cheese.png"
    ],
    [
      "Pizza Vegetariana",
      "Pizza's",
      "150",
      Colors.orange,
      "lib/images/pizza_vegetarian.png"
    ],
    [
      "Pizza Italiana",
      "Pizza's",
      "150",
      Colors.deepOrange,
      "lib/images/pizza_italiana.png"
    ],
  ];

  PizzaTab({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return GridView.builder(
      itemCount: pizzasOnSale.length,
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Muestra 2 pizzas por fila
        childAspectRatio: 1 / 1.5,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        double price = double.parse(pizzasOnSale[index][2]);

        return DonutTile(
          donutFlavor: pizzasOnSale[index][0],
          donutName: pizzasOnSale[index][1],
          donutPrice: pizzasOnSale[index][2],
          donutColor: pizzasOnSale[index][3],
          imageName: pizzasOnSale[index][4],
          onTap: () {
            // Agrega la pizza al carrito
            cartProvider.addItem(price);

            // Muestra un SnackBar confirmando la acción
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                    Text('${pizzasOnSale[index][0]} añadida al carrito 🛒'),
                duration: const Duration(seconds: 1),
              ),
            );
          },
        );
      },
    );
  }
}
