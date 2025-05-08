import 'package:dio/dio.dart';
import 'package:assignment/features/categories/data/models/category_model.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final Dio dio;

  CategoryRemoteDataSourceImpl(this.dio);

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await dio.get('/products/category-list');
      final List<dynamic> categories = response.data;
      return categories
          .map((category) => CategoryModel(name: category.toString()))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }
  }
} 