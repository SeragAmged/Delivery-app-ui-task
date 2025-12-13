// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartState _$CartStateFromJson(Map<String, dynamic> json) => CartState(
      cart: (json['cart'] as List<dynamic>)
          .map((e) => CartProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
      addresses: (json['addresses'] as List<dynamic>)
          .map((e) => Address.fromJson(e as Map<String, dynamic>))
          .toList(),
      selectedAddressId: json['selectedAddressId'] as String,
    );

Map<String, dynamic> _$CartStateToJson(CartState instance) => <String, dynamic>{
      'cart': instance.cart,
      'addresses': instance.addresses,
      'selectedAddressId': instance.selectedAddressId,
    };
