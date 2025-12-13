import 'package:delivery_app/home/domain/product.dart';
import 'package:json_annotation/json_annotation.dart';
part 'cart_product.g.dart';

@JsonSerializable()
class CartProduct {
  final Product product;
  final int quantity;

  CartProduct({required this.product, required this.quantity});

  factory CartProduct.fromJson(Map<String, dynamic> json) =>
      _$CartProductFromJson(json);
  Map<String, dynamic> toJson() => _$CartProductToJson(this);

  CartProduct copyWith({
    Product? product,
    int? quantity,
  }) {
    return CartProduct(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}
