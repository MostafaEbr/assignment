import 'package:dio/dio.dart';
import 'package:assignment/features/products/data/models/product_model.dart';

abstract class ProductDetailsRemoteDataSource {
  Future<ProductModel> getProductDetails(int id);
}

class ProductDetailsRemoteDataSourceImpl
    implements ProductDetailsRemoteDataSource {
  final Dio dio;

  ProductDetailsRemoteDataSourceImpl(this.dio);

  @override
  Future<ProductModel> getProductDetails(int id) async {
    try {
      final response = await dio.get('/products/$id');
      return ProductModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch product details: $e');
    }
  }
}
