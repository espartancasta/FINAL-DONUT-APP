import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importa Provider
import 'package:donut_app_2c_gaxiola/utils/donut_tile.dart';
import 'package:donut_app_2c_gaxiola/providers/cart_provider.dart'; // Importa el proveedor del carrito

class SmoothieTab extends StatelessWidget {
  // Lista de smoothies
  final List smoothiesOnSale = [
    [
      "Freppe cafe",
      "Frappe's",
      "50",
      Colors.blue,
      "lib/images/Frappe_chocolate.png"
    ],
    [
      "Frappe Capuchino",
      "Frappe's",
      "50",
      Colors.red,
      "lib/images/Frappe_chocolate.png"
    ],
    [
      "Frappe chocolate",
      "Frappe's",
      "50",
      Colors.pink,
      "lib/images/Frappe_chocolate.png"
    ],
    [
      "Frappe de leche",
      "Frappe's",
      "50",
      Colors.brown,
      "lib/images/frappe_vanilla.png"
    ],
    [
      "Frappe vainilla",
      "Frappe's",
      "50",
      Colors.yellow,
      "lib/images/Frappe_vanilla.png"
    ],
    [
      "Frappe Tapioca",
      "Frappe's",
      "70",
      Colors.purple,
      "lib/images/Frappe_vanilla.png"
    ],
    [
      "Frappe unicornio",
      "Frappe's",
      "70",
      Colors.orange,
      "lib/images/Frappe_vanilla.png"
    ],
    [
      "Frappe de macha",
      "Frappe's",
      "70",
      Colors.deepOrange,
      "lib/images/frappe_vanilla.png"
    ],
  ];

  SmoothieTab({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return SingleChildScrollView(
      child: GridView.builder(
        shrinkWrap: true, // Ajusta el tamaño al contenido
        physics:
            const NeverScrollableScrollPhysics(), // Usa solo el scroll padre
        itemCount: smoothiesOnSale.length,
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Dos smoothies por fila
          childAspectRatio: 1 / 1.6, // Más altura para evitar overflow
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          double price = double.parse(smoothiesOnSale[index][2]);

          return ClipRRect(
            borderRadius: BorderRadius.circular(12), // Bordes redondeados
            child: DonutTile(
              donutFlavor: smoothiesOnSale[index][0],
              donutName: smoothiesOnSale[index][1],
              donutPrice: smoothiesOnSale[index][2],
              donutColor: smoothiesOnSale[index][3],
              imageName: smoothiesOnSale[index][4],
              onTap: () {
                // Agrega el smoothie al carrito
                cartProvider.addItem(price);

                // Muestra un SnackBar confirmando la acción
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        '${smoothiesOnSale[index][0]} añadido al carrito 🛒'),
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
