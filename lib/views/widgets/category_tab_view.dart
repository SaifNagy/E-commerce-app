import 'package:ecommerce_app/view_models/categories_cubit/categories_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryTabView extends StatelessWidget {
  const CategoryTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CategoriesCubit>(context);
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is CategoriesLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (state is CategoriesError) {
          return Center(child: Text(state.message));
        } else if (state is CategoriesLoaded) {
          return ListView.builder(
            itemCount: state.categories.length,
            itemBuilder: (context, index) {
              final category = state.categories[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: InkWell(
                  onTap: () {},
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: category.bgColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Column(
                        children: [
                          Text(
                            category.name,
                            style: Theme.of(
                              context,
                            ).textTheme.titleLarge!.copyWith(
                              color: category.textColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${category.productsCount}',
                            style: Theme.of(
                              context,
                            ).textTheme.labelLarge!.copyWith(
                              color: category.textColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
        return const Center(child: Text('No categories available'));
      },
    );
  }
}
