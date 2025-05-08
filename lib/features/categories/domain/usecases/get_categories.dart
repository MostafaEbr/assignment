import 'package:assignment/features/categories/data/models/category_model.dart';
import 'package:assignment/features/categories/domain/repositories/category_repository.dart';

class GetCategories {
  final CategoryRepository repository;

  GetCategories(this.repository);

  Future<List<CategoryModel>> call() async {
    return await repository.getCategories();
  }
} 