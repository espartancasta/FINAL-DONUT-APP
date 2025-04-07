import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importa Provider
import 'package:donut_app_2c_gaxiola/utils/donut_tile.dart';
import 'package:donut_app_2c_gaxiola/providers/cart_provider.dart'; // Importa el proveedor del carrito

class PancakesTab extends StatelessWidget {
  // Lista de pancakes
  final List pancakesOnSale = [
    [
      "Hot Cake",
      "Pancake's",
      "60",
      Colors.blue,
      "lib/images/pancake_hotcake.png"
    ],
    [
      "Pancake Belga",
      "Pancake's",
      "75",
      Colors.red,
      "lib/images/pancake_belga.png"
    ],
    [
      "Pancake de platano",
      "Pancake's",
      "75",
      Colors.pink,
      "lib/images/pancake_banana.png"
    ],
    [
      "Pancake de helado",
      "Pancake's",
      "75",
      Colors.brown,
      "lib/images/pancake_ice.png"
    ],
    [
      "Pancake de frutos",
      "Pancake's",
      "50",
      Colors.yellow,
      "lib/images/pancake_hotcake.png"
    ],
    [
      "Pancake de cajeta",
      "Pancake's",
      "75",
      Colors.purple,
      "lib/images/pancake_cajeta.png"
    ],
    [
      "Pancake de azucar",
      "Pancake's",
      "60",
      Colors.orange,
      "lib/images/pancake_glas.png"
    ],
    [
      "Pancake champiñon",
      "Pancake's",
      "75",
      Colors.deepOrange,
      "lib/images/pancake_champiñon.png"
    ],
  ];

  PancakesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return GridView.builder(
      itemCount: pancakesOnSale.length,
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Muestra 2 pancakes por fila
        childAspectRatio: 1 / 1.5,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        double price = double.parse(pancakesOnSale[index][2]);

        return DonutTile(
          donutFlavor: pancakesOnSale[index][0],
          donutName: pancakesOnSale[index][1],
          donutPrice: pancakesOnSale[index][2],
          donutColor: pancakesOnSale[index][3],
          imageName: pancakesOnSale[index][4],
          onTap: () {
            // Agrega el pancake al carrito
            cartProvider.addItem(price);

            // Muestra un SnackBar confirmando la acción
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                    Text('${pancakesOnSale[index][0]} añadido al carrito 🛒'),
                duration: const Duration(seconds: 1),
              ),
            );
          },
        );
      },
    );
  }
}
