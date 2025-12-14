// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:delivery_app/cart/presintation/cubit/cart_cubit.dart' as _i480;
import 'package:delivery_app/core/data/assets/asset_loader.dart' as _i207;
import 'package:delivery_app/home/data/assets/asset_products_data_source.dart'
    as _i96;
import 'package:delivery_app/home/data/home_products_repo.dart' as _i181;
import 'package:delivery_app/home/domain/home_products_data_source.dart'
    as _i558;
import 'package:delivery_app/home/presentation/bloc/home_cubit.dart' as _i644;
import 'package:delivery_app/layout/bottom_nav_cubit.dart' as _i591;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

const String _dev = 'dev';

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i591.BottomNavCubit>(() => _i591.BottomNavCubit());
    gh.factory<_i480.CartCubit>(() => _i480.CartCubit());
    gh.singleton<_i207.AssetLoader>(() => _i207.AssetLoader());
    gh.singleton<_i558.HomeProductsDataSource>(
      () => _i96.AssetProductsDataSource(assetLoader: gh<_i207.AssetLoader>()),
      instanceName: 'assets',
      registerFor: {_dev},
    );
    gh.lazySingleton<_i181.HomeProductsRepo>(() => _i181.HomeProductsRepo(
        localDataSource:
            gh<_i558.HomeProductsDataSource>(instanceName: 'assets')));
    gh.factory<_i644.HomeCubit>(
        () => _i644.HomeCubit(gh<_i181.HomeProductsRepo>()));
    return this;
  }
}
