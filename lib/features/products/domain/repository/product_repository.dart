import 'package:dartz/dartz.dart';
import 'package:open_store/features/products/domain/entities/Product.dart';

import '../../../../core/error/Failure.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();
}
