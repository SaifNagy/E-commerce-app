import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final ProductItemModel productitem;
  const ProductItem({super.key, required this.productitem});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 125,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey.shade200,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CachedNetworkImage(
                  imageUrl: productitem.imgUrl,
                  fit: BoxFit.contain,
                  placeholder:
                      (context, url) => const Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                  errorWidget:
                      (context, url, error) =>
                          const Icon(Icons.error, color: Colors.red),
                ),
              ),
            ),
            Positioned(
              top: 1,
              right: 1,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white54,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.heart),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          productitem.name,
          style: Theme.of(
            context,
          ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w600),
        ),
        Text(
          productitem.category,
          style: Theme.of(
            context,
          ).textTheme.labelMedium!.copyWith(color: Colors.grey),
        ),
        Text(
          '\$ ${productitem.price}',
          style: Theme.of(
            context,
          ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
