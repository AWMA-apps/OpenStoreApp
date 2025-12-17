import 'package:open_store/features/products/data/models/product_model.dart';

import '../../../../core/network/DioClient.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getAllProducts();
}

class ProductRemoteDataSourceImpl extends ProductRemoteDataSource {
  final DioClient dioClient;

  ProductRemoteDataSourceImpl(this.dioClient);

  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final response = await dioClient.dio.get("/products");
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((e) => ProductModel.fromJson(e)).toList();
      } else {
        throw UnimplementedError();
      }
    } catch (e) {
      rethrow;
    }
  }
}
