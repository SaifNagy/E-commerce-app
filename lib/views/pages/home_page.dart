import 'package:ecommerce_app/utils/app_colors.dart';
import 'package:ecommerce_app/view_models/categories_cubit/categories_cubit.dart';
import 'package:ecommerce_app/view_models/home_cubit/home_cubit_cubit.dart';
import 'package:ecommerce_app/views/widgets/category_tab_view.dart';
import 'package:ecommerce_app/views/widgets/home_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabcontroller;

  @override
  void initState() {
    super.initState();
    _tabcontroller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = HomeCubit();
        cubit.getHomeData();
        return cubit;
      },
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              TabBar(
                controller: _tabcontroller,
                unselectedLabelColor: AppColors.grey,
                tabs: [const Tab(text: 'Home'), const Tab(text: 'Category')],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabcontroller,
                  children: [
                    const HomeTabView(),
                    BlocProvider(
                      create: (context) {
                        final cubit = CategoriesCubit();
                        cubit.getCategories();
                        return cubit;
                      },
                      child: const CategoryTabView(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
