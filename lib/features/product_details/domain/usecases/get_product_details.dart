import 'package:assignment/features/products/data/models/product_model.dart';
import 'package:assignment/features/product_details/domain/repositories/product_details_repository.dart';

class GetProductDetails {
  final ProductDetailsRepository repository;

  GetProductDetails(this.repository);

  Future<ProductModel> call(int id) async {
    return await repository.getProductDetails(id);
  }
}
