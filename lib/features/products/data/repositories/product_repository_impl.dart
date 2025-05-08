import 'package:assignment/features/products/data/datasources/product_remote_data_source.dart';
import 'package:assignment/features/products/data/models/product_model.dart';
import 'package:assignment/features/products/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ProductModel>> getProductsByCategory(String category) async {
    try {
      return await remoteDataSource.getProductsByCategory(category);
    } catch (e) {
      throw Exception('Failed to get products: $e');
    }
  }
} 