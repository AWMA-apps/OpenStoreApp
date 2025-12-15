import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_store/features/products/data/data_source/cart_local_data_source.dart';
import 'package:open_store/features/products/domain/entities/Product.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final cartLocalDataSourceProvider = Provider<CartLocalDataSource>((ref) {
  final prefs=ref.watch(sharedPreferencesProvider);
  return CartLocalDataSource(prefs);
});

class CartNotifier extends Notifier<List<Product>> {
  late CartLocalDataSource _cartLocalDataSource;


  @override
  List<Product> build() {
    _cartLocalDataSource = ref.watch(cartLocalDataSourceProvider);
    return _cartLocalDataSource.getCachedCart();
  }

  void addToCart(Product product) {
    if (!isInCart(product)) state = [...state, product];
    _saveCart(state);
  }

  void removeProduct(Product product) {
    state = state.where((element) => element.id != product.id).toList();
    _saveCart(state);
  }

  bool isInCart(Product product) {
    return state.contains(product);
  }

  void _saveCart(List<Product> products){
    _cartLocalDataSource.saveCart(products);
  }
}

final cartProvider = NotifierProvider<CartNotifier, List<Product>>(
  () => CartNotifier(),
);
