import 'package:cached_network_image/cached_network_image.dart';
import 'package:fake_store/core/theme/app_colors.dart';
import 'package:fake_store/core/utils/spinner_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final bool isInWishlist;
  final VoidCallback onTap;
  final VoidCallback onWishlistTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.isInWishlist,
    required this.onTap,
    required this.onWishlistTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.colorGreyLight,
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.only(bottom: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: product.image,
                width: 85,
                height: 85,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: 85,
                  height: 85,
                  color: AppColors.colorGreyLight,
                  child: const SpinnerView(),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 85,
                  height: 85,
                  color: AppColors.colorGreyLight,
                  child: const Icon(Icons.error),
                ),
              ),
            ),
            const Gap(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    product.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(4),
                  Text(
                    product.category,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.colorGrey,
                      fontSize: 13,
                    ),
                  ),
                  const Gap(8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.black, size: 16),
                      const Gap(4),
                      Text(
                        product.rating.rate.toStringAsFixed(2),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const Gap(8),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(8),
            IconButton(
              icon: Icon(
                isInWishlist ? Icons.favorite : Icons.favorite_border,
                color: isInWishlist ? AppColors.colorRed : AppColors.colorGrey,
                size: 24,
              ),
              onPressed: onWishlistTap,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ),
    );
  }
}
