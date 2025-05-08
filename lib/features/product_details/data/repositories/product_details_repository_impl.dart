import 'package:assignment/features/product_details/data/datasources/product_details_remote_data_source.dart';
import 'package:assignment/features/products/data/models/product_model.dart';
import 'package:assignment/features/product_details/domain/repositories/product_details_repository.dart';

class ProductDetailsRepositoryImpl implements ProductDetailsRepository {
  final ProductDetailsRemoteDataSource remoteDataSource;

  ProductDetailsRepositoryImpl(this.remoteDataSource);

  @override
  Future<ProductModel> getProductDetails(int id) async {
    try {
      return await remoteDataSource.getProductDetails(id);
    } catch (e) {
      throw Exception('Failed to get product details: $e');
    }
  }
}
