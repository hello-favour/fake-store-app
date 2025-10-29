import 'package:cached_network_image/cached_network_image.dart';
import 'package:fake_store/core/theme/app_colors.dart';
import 'package:fake_store/core/utils/spinner_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../data/models/product_model.dart';

class WishlistItemCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onRemove;
  final VoidCallback onAddToCart;

  const WishlistItemCard({
    super.key,
    required this.product,
    required this.onRemove,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.colorGreyLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: product.image,
              width: 65,
              height: 65,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                width: 65,
                height: 65,
                color: AppColors.colorWhite,
                child: const SpinnerView(),
              ),
              errorWidget: (context, url, error) => Container(
                width: 65,
                height: 65,
                color: AppColors.colorWhite,
                child: const Icon(Icons.error, size: 20),
              ),
            ),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Gap(4),
                          Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  fontSize: 14,
                                  color: AppColors.colorBlack,
                                ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.favorite,
                        color: AppColors.colorRed,
                        size: 22,
                      ),
                      onPressed: onRemove,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const Gap(10),
                SizedBox(
                  width: double.infinity,
                  height: 36,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.colorWhite,
                      foregroundColor: AppColors.colorBlack,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: onAddToCart,
                    child: const Text(
                      'Add to cart',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
