import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:open_store/features/products/presentation/provider/cart_provider.dart';
import 'package:open_store/features/products/presentation/provider/product_providers.dart';
import 'package:open_store/features/products/presentation/widgets/product_card.dart';

import '../../../../l10n/app_localizations.dart';


class ProductsPage extends ConsumerWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsState = ref.watch(productProvider);
    final tr = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(tr.appTitle, style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          Consumer(
            builder: (context, ref, child) {
              final cartItems = ref.watch(cartProvider);
              final itemCount = cartItems.length;

              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    onPressed: () => context.push("/cart"),
                    icon: const Icon(Icons.shopping_cart_outlined, size: 28),
                  ),
                  if (itemCount > 0)
                    Positioned(
                      top: 5,
                      right: 5,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          "$itemCount",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  SizedBox(width: 10),
                ],
              );
            },
          ),
          IconButton(
            onPressed: () => context.push("/settings"),
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: productsState.when(
        data: (products) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(
                product: product,
                onTab: () {
                  context.push('/product_details', extra: product);
                },
              );
            },
          );
        },
        error: (error, stackTrace) => Center(child: Text("Error: $error")),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
