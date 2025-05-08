import 'package:dio/dio.dart';
import 'package:assignment/features/products/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProductsByCategory(String category);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ProductModel>> getProductsByCategory(String category) async {
    try {
      final response = await dio.get('/products/category/$category');
      final List<dynamic> products = response.data['products'];
      return products.map((product) => ProductModel.fromJson(product)).toList();
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }
} 