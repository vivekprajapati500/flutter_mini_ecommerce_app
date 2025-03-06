// Screens
import 'package:flutter/material.dart';
import 'package:flutter_test_app/screens/product_details_screen.dart';
import 'package:get/get.dart';

import '../controllers/product_controller.dart';

class HomeScreen extends StatelessWidget {
  final productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Products')),
      body: Obx(() {
        if (productController.productList.isEmpty &&
            productController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            controller: productController.scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 items per row
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.8, // Aspect ratio similar to the reference image
            ),
            itemCount: productController.productList.length + 1,
            itemBuilder: (context, index) {

              if (index == productController.productList.length) {
                return productController.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : const SizedBox.shrink();
              }


              var product = productController.productList[index];
              return  Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 2,
                child: InkWell(
                  onTap: () {
                    Get.to(() => ProductDetailsScreen(product: product));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Image

                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(
                            10)),
                        child:
                        FadeInImage.assetNetwork(
                          placeholder: "assets/no_image.jpg", // Temporary local asset during loading
                          image: product.images.isNotEmpty ? product.images[0] : "",
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 120,
                              width: double.infinity,
                              color: Colors.grey[300], // Background color for icon
                              child: Icon(Icons.image_not_supported, size: 40, color: Colors.grey[700]), // Fallback icon
                            );
                          },
                        ),
                      ),

                      // Product Title
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          product.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),

                      // Product Price
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "\$${product.price}",
                          style: const TextStyle(color: Colors.green, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
