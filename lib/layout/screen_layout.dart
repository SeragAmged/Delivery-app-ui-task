import 'package:delivery_app/cart/presintation/cart_screen.dart';
import 'package:delivery_app/home/presentation/ui/home_screen.dart';
import 'package:delivery_app/layout/bottom_nav_cubit.dart';
import 'package:delivery_app/layout/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenLayout extends StatelessWidget {
  ScreenLayout({super.key});

  final List<Widget> screens = [
    HomeScreen(),
    marketScreen(),
    CartScreen(),
    favScreen(),
    profileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, index) {
        return Scaffold(
          body: IndexedStack(
            index: index,
            children: screens,
          ),
          bottomNavigationBar: CustomBottomBar(
            currentIndex: index,
            onTap: (index) => context.read<BottomNavCubit>().changeTab(index),
          ),
        );
      },
    );
  }


  static Widget marketScreen() => const Center(child: Text("Search Screen"));

  static Widget profileScreen() => const Center(child: Text("Profile Screen"));

  static Widget favScreen() => Center(child: Text("Fav Screen"));
}
