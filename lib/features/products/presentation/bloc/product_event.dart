abstract class ProductEvent {}

class GetProductsByCategoryEvent extends ProductEvent {
  final String category;

  GetProductsByCategoryEvent(this.category);
}
