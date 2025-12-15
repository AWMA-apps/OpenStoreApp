import 'package:go_router/go_router.dart';
import 'package:open_store/core/pages/settings_page.dart';
import 'package:open_store/features/products/domain/entities/Product.dart';
import 'package:open_store/features/products/presentation/pages/cart_page.dart';
import 'package:open_store/features/products/presentation/pages/product_details_page.dart';
import 'package:open_store/features/products/presentation/pages/products_page.dart';

final router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(path: "/", builder: (context, state) => const ProductsPage()),
    GoRoute(
      path: "/product_details",
      builder: (context, state) {
        final product = state.extra as Product;
        return ProductDetailsPage(product: product);
      },
    ),
    GoRoute(path: "/cart", builder: (context, state) => const CartPage()),
    GoRoute(
      path: "/settings",
      builder: (context, state) => const SettingsPage(),
    ),
  ],
);
