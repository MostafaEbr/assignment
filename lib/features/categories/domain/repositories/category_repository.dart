import 'package:assignment/features/categories/data/models/category_model.dart';

abstract class CategoryRepository {
  Future<List<CategoryModel>> getCategories();
} 