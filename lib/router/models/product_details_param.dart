import 'package:delivery_app/cart/presintation/cubit/cart_cubit.dart';
import 'package:delivery_app/core/domain/product.dart';
import 'package:delivery_app/home/presentation/bloc/home_cubit.dart';

class ProductDetailsParam {
  final Product product;
  final HomeCubit homeCubit;
  final CartCubit cartCubit;

  ProductDetailsParam({
    required this.product,
    required this.homeCubit,
    required this.cartCubit,
  });
}
