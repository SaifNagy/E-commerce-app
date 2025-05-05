import 'package:ecommerce_app/models/category_model.dart';
import 'package:flutter/material.dart';

class CategoryTabView extends StatelessWidget {
  const CategoryTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dummyCategories.length,
      itemBuilder: (context, index) {
        final category = dummyCategories[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: InkWell(
            onTap: () {
              
            },
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: dummyCategories[index].bgColor,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Column(
                  children: [
                    Text(
                      category.name,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: category.textColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text('${category.productsCount}',style: Theme.of(context).textTheme.labelLarge!.copyWith(color: category.textColor, fontWeight: FontWeight.w600,),),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
