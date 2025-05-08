import 'package:assignment/features/products/data/models/product_model.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> getProductsByCategory(String category);
} 