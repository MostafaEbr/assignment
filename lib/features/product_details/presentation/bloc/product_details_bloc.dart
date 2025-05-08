import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:assignment/features/product_details/domain/usecases/get_product_details.dart';
import 'package:assignment/features/product_details/presentation/bloc/product_details_event.dart';
import 'package:assignment/features/product_details/presentation/bloc/product_details_state.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  final GetProductDetails getProductDetails;

  ProductDetailsBloc({required this.getProductDetails})
    : super(ProductDetailsInitial()) {
    on<GetProductDetailsEvent>(_onGetProductDetails);
  }

  Future<void> _onGetProductDetails(
    GetProductDetailsEvent event,
    Emitter<ProductDetailsState> emit,
  ) async {
    emit(ProductDetailsLoading());
    try {
      final product = await getProductDetails(event.productId);
      emit(ProductDetailsLoaded(product));
    } catch (e) {
      emit(ProductDetailsError(e.toString()));
    }
  }
}
