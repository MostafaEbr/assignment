abstract class ProductDetailsEvent {}

class GetProductDetailsEvent extends ProductDetailsEvent {
  final int productId;

  GetProductDetailsEvent(this.productId);
}
