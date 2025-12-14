import 'dart:developer';

import 'package:delivery_app/cart/presintation/cubit/cart_state.dart';
import 'package:delivery_app/cart/domain/address.dart';
import 'package:delivery_app/cart/domain/cart_product.dart';
import 'package:delivery_app/core/domain/product.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class CartCubit extends HydratedCubit<CartState> {
  CartCubit()
      : super(CartState(
          cart: [],
          addresses: [
            Address(
              id: '1',
              name: 'Mi casa',
              street: 'Dirección de ejemplo',
            ),
            Address(
              id: '2',
              name: 'Mi trabajo',
              street: 'Dirección de ejemplo',
            ),
          ],
          selectedAddressId: '1',
        )) {
    log("CartCubit initialized");
  }

  bool _checKProductInCart(Product product) {
    return state.cart.any((p) => p.product.id == product.id);
  }

  void addProduct(Product product) {
    if (_checKProductInCart(product)) return;

    log(product.toJson().toString());
    emit(state.copyWith(
        cart: state.cart..add(CartProduct(product: product, quantity: 1))));
  }

  void increaseQuantity(CartProduct product) {
    emit(state.copyWith(
        cart: state.cart
            .map((p) => p.product.id == product.product.id
                ? p.copyWith(quantity: p.quantity + 1)
                : p)
            .toList()));
  }

  void decreaseQuantity(CartProduct product) {
    if (product.quantity == 1) return;
    emit(
      state.copyWith(
        cart: state.cart
            .map((p) => p.product.id == product.product.id
                ? p.copyWith(quantity: p.quantity - 1)
                : p)
            .toList(),
      ),
    );
  }

  void removeProduct(CartProduct product) {
    emit(state.copyWith(cart: state.cart..remove(product)));
  }

  void selectAddress(String addressId) {
    emit(state.copyWith(selectedAddressId: addressId));
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return CartState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(state) {
    return state.toJson();
  }
}
