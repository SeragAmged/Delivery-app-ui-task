import 'package:delivery_app/core/presentation/themes/app_theme.dart';
import 'package:delivery_app/di/di_config.dart';
import 'package:delivery_app/router/app_router.dart';
import 'package:delivery_app/router/app_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ScreenUtil.ensureScreenSize();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );
  configureDependencies(Environment.dev);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'delivery app',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          navigatorKey: AppRouter.navigatorKey,
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: AppRoutes.root,
        );
      },
    );
  }
}
