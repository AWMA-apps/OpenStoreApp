import 'dart:convert';

import 'package:open_store/features/products/data/models/product_model.dart';
import 'package:open_store/features/products/domain/entities/Product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartLocalDataSource {
  final SharedPreferences sharedPreferences;

  CartLocalDataSource(this.sharedPreferences);

  static const String _cachedKey = "CACHED_CART";

  Future<void> saveCart(List<Product> cartItems) async {
    try {
      final List<Map<String, dynamic>> productsMapList = cartItems.map((item) {
        final model = ProductModel(
          id: item.id,
          title: item.title,
          price: item.price,
          description: item.description,
          category: item.category,
          image: item.image,
          rating: item.rating,
        );
        return model.toJSON();
      }).toList();
      final jsonProductMapString = json.encode(productsMapList);
      await sharedPreferences.setString(_cachedKey, jsonProductMapString);
      print("✅ Saved ${cartItems.length} items to local storage");
    } catch (e) {
      print("❌ Error saving cart: $e");
    }
  }

  List<Product> getCachedCart() {
    try {
      final jsonString = sharedPreferences.getString(_cachedKey);

      if (jsonString != null && jsonString.isNotEmpty) {
        final List<dynamic> jsonList = json.decode(jsonString);
        print("📥 Found ${jsonList.length} items in storage");
        return jsonList.map((jsonString) {
          return ProductModel.fromJson(jsonString);
        }).toList();
      } else {
        print("⚠️ No items found in storage (Key is null)");
      }
    } catch (e) {
      print("❌ Error loading cart: $e");
    }
    return [];
  }
}
