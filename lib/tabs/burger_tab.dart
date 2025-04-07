import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importa Provider
import 'package:donut_app_2c_gaxiola/utils/donut_tile.dart';
import 'package:donut_app_2c_gaxiola/providers/cart_provider.dart'; // Importa el proveedor del carrito

class BurgerTab extends StatelessWidget {
  // Lista de hamburguesas
  final List burgersOnSale = [
    [
      "Hamburguesa Sencilla",
      "Burger's",
      "65",
      Colors.blue,
      "lib/images/Burger_sencilla.png"
    ],
    [
      "Hamburguesa DOBLE",
      "Burger's",
      "95",
      Colors.red,
      "lib/images/Burger_doble.png"
    ],
    [
      "Hamburguesa TRIPLE",
      "Burger's",
      "115",
      Colors.pink,
      "lib/images/Burger_triple.png"
    ],
    [
      "Hamburguesa Krispy",
      "Burger's",
      "85",
      Colors.brown,
      "lib/images/Burger_krispy.png"
    ],
    [
      "Hamburguesa/arros",
      "Burger's",
      "85",
      Colors.yellow,
      "lib/images/Burger_onion.png"
    ],
    [
      "Hamburguesa/Tocino",
      "Burger's",
      "85",
      Colors.purple,
      "lib/images/Burger_tocino.png"
    ],
    [
      "Hamburguesa Vegetariana",
      "Burger's",
      "85",
      Colors.orange,
      "lib/images/Burger_vegetarian.png"
    ],
    [
      "Paquete Hamburguesa",
      "Burger's",
      "120",
      Colors.deepOrange,
      "lib/images/Burger_Packet.png"
    ],
  ];

  BurgerTab({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return SingleChildScrollView(
      child: GridView.builder(
        shrinkWrap: true, // Evita conflictos de scroll
        physics:
            const NeverScrollableScrollPhysics(), // Usa solo el scroll padre
        itemCount: burgersOnSale.length,
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Dos hamburguesas por fila
          childAspectRatio: 1 / 1.6, // Ajuste para evitar overflow
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          double price = double.parse(burgersOnSale[index][2]);

          return ClipRRect(
            borderRadius: BorderRadius.circular(12), // Bordes redondeados
            child: DonutTile(
              donutFlavor: burgersOnSale[index][0],
              donutName: burgersOnSale[index][1],
              donutPrice: burgersOnSale[index][2],
              donutColor: burgersOnSale[index][3],
              imageName: burgersOnSale[index][4],
              onTap: () {
                // Agrega la hamburguesa al carrito
                cartProvider.addItem(price);

                // Muestra un SnackBar confirmando la acción
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        '${burgersOnSale[index][0]} añadida al carrito 🛒'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
