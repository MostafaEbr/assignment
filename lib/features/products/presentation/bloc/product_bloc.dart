import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:assignment/features/products/domain/usecases/get_products_by_category.dart';
import 'package:assignment/features/products/presentation/bloc/product_event.dart';
import 'package:assignment/features/products/presentation/bloc/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsByCategory getProductsByCategory;

  ProductBloc({required this.getProductsByCategory}) : super(ProductInitial()) {
    on<GetProductsByCategoryEvent>(_onGetProductsByCategory);
  }

  Future<void> _onGetProductsByCategory(
    GetProductsByCategoryEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final products = await getProductsByCategory(event.category);
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
