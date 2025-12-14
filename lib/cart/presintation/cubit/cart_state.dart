import 'package:delivery_app/cart/domain/address.dart';
import 'package:delivery_app/cart/domain/cart_product.dart';
import 'package:delivery_app/core/domain/product.dart';
import 'package:json_annotation/json_annotation.dart';
part 'cart_state.g.dart';

@JsonSerializable()
class CartState {
  final List<CartProduct> cart;
  final List<Address> addresses;
  final String selectedAddressId;

  const CartState(
      {required this.cart,
      required this.addresses,
      required this.selectedAddressId});

  double get totalPrice {
    final total = cart.fold<double>(
      0.0,
      (sum, item) => sum + item.product.price * item.quantity,
    );

    return double.parse(total.toStringAsFixed(2));
  }

  List<Product> get products => cart.map((c) => c.product).toList();

  CartState copyWith({
    List<CartProduct>? cart,
    List<Address>? addresses,
    String? selectedAddressId,
  }) {
    return CartState(
      cart: cart ?? this.cart,
      addresses: addresses ?? this.addresses,
      selectedAddressId: selectedAddressId ?? this.selectedAddressId,
    );
  }

  Map<String, dynamic> toJson() => _$CartStateToJson(this);

  factory CartState.fromJson(Map<String, dynamic> json) =>
      _$CartStateFromJson(json);
}
