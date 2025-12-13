import 'package:delivery_app/cart/presintation/cubit/cart_cubit.dart';
import 'package:delivery_app/di/di_config.dart';
import 'package:delivery_app/home/presentation/bloc/home_cubit.dart';
import 'package:delivery_app/layout/bottom_nav_cubit.dart';
import 'package:delivery_app/layout/screen_layout.dart';
import 'package:delivery_app/product_details/presentation/ui/product_details_screen.dart';
import 'package:delivery_app/router/app_routes.dart';
import 'package:delivery_app/router/models/product_details_param.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  AppRouter._();
  static final navigatorKey = GlobalKey<NavigatorState>();

  // Track route stack
  static final List<String> routeStack = [];
  static String route = routeStack.isEmpty ? '/' : routeStack.last;
  static String previousRoute = '';

  static Route onGenerateRoute(RouteSettings settings) {
    // Add route to stack
    if (settings.name != null) {
      previousRoute = route;
      route = settings.name!;
      routeStack.add(settings.name!);
    }

    return _buildRoute(settings);
  }

  static Route _buildRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.root:
        return _createRoute(
          settings,
          _buildAppRoot(),
        );

      case AppRoutes.details:
        return _createRoute(
          settings,
          MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: (settings.arguments as ProductDetailsParam).homeCubit,
              ),
              BlocProvider.value(
                value: (settings.arguments as ProductDetailsParam).cartCubit,
              ),
            ],
            child: ProductDetailsScreen(
                product: (settings.arguments as ProductDetailsParam).product),
          ),
        );

      default:
        return _createRoute(settings, ScreenLayout());
    }
  }

  static MaterialPageRoute _createRoute(RouteSettings settings, Widget screen) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => screen,
    );
  }

  static Widget _buildAppRoot() {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<BottomNavCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<HomeCubit>()
            ..loadCategories()
            ..loadPopularProducts()
            ..loadRecommendedProducts(),
        ),
        BlocProvider(
          create: (context) => getIt<CartCubit>(),
        ),
      ],
      child: ScreenLayout(),
    );
  }

  static void pop(context) {
    if (routeStack.isNotEmpty) {
      routeStack.removeLast();
    }
    previousRoute = route;
    route = routeStack.isEmpty ? '/' : routeStack.last;
    Navigator.pop(context);
  }
}
