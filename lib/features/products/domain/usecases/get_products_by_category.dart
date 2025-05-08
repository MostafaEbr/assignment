import 'package:assignment/features/products/data/models/product_model.dart';
import 'package:assignment/features/products/domain/repositories/product_repository.dart';

class GetProductsByCategory {
  final ProductRepository repository;

  GetProductsByCategory(this.repository);

  Future<List<ProductModel>> call(String category) async {
    return await repository.getProductsByCategory(category);
  }
} 