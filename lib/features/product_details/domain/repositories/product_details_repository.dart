import 'package:assignment/features/products/data/models/product_model.dart';

abstract class ProductDetailsRepository {
  Future<ProductModel> getProductDetails(int id);
}
