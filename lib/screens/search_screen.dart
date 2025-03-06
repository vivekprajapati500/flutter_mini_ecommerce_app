
import 'package:flutter/material.dart';
import 'package:flutter_test_app/screens/product_details_screen.dart';
import 'package:get/get.dart';

import '../controllers/product_controller.dart';

class SearchScreen extends StatelessWidget {
  final productController = Get.find<ProductController>();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Column(
        children: [
          // Search TextField
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: "Search Products",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (query) {
                productController.searchProducts(query);
              },
            ),
          ),

          // List of Filtered Products
          Expanded(
            child: Obx(() {
              if (productController.filteredList.isEmpty) {
                return const Center(child: Text("No products found"));
              }
              return ListView.builder(
                itemCount: productController.filteredList.length,
                itemBuilder: (context, index) {
                  var product = productController.filteredList[index];
                  return ListTile(
                    title: Text(product.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("\$${product.price}", style: const TextStyle(color: Colors.green)),
                      onTap: () {
                        Get.to(() => ProductDetailsScreen(product: product));
                      }
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
