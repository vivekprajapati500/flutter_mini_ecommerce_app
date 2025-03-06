
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api_services.dart';
import '../model/product_list_model.dart';

class ProductController extends GetxController {
  var offset = 1.obs;
  final int limit = 10;
  ScrollController scrollController = ScrollController();

  var productList = <ProductListModelItem>[].obs;
  var filteredList = <ProductListModelItem>[].obs;
  var categories = <String>[].obs;
  var selectedCategory = "All".obs;
  var isLoading = false.obs;


  @override
  void onInit() {
    debugPrint("Init -=================>");
    fetchProducts();
    scrollController.addListener(_scrollListener);
    super.onInit();
  }


  void _scrollListener() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
      fetchProducts();
    }
  }

  void fetchProducts() async {
    debugPrint("isLoading first ==> ${isLoading.value}");
    if (isLoading.value) return;

    isLoading.value = true;
    debugPrint("isLoading true ==> ${isLoading.value}");
    var products = await ApiService().getProducts(offset: offset.value, limit: limit);

    debugPrint("products ==> ${products?.length}");
    if (products != null && products.isNotEmpty) {
      productList.addAll(products);
      filteredList.addAll(products);
      offset.value += limit; // Increase offset for next page
    }

    categories.value = ["All"] + products!.map((p) => p.category.name).toSet().toList();
    isLoading.value = false;
  }

/*  void filterByCategory(String category) {
    selectedCategory.value = category;
    if (category == "All") {
      filteredList.value = productList;
    } else {
      filteredList.value = productList.where((p) => p.category.name == category).toList();
    }
  }*/

  void searchProducts(String query) {
    if (query.isEmpty) {
      filteredList.assignAll(productList);
    } else {
      filteredList.assignAll(
        productList.where((product) => product.title.toLowerCase().contains(query.toLowerCase())).toList(),
      );
    }
  }
}
