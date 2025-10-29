import 'package:fake_store/core/theme/app_colors.dart';
import 'package:fake_store/data/models/cart_item_model.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gap/gap.dart';
import 'quantity_button.dart';

class CartItemCard extends StatelessWidget {
  final CartItemModel item;
  final VoidCallback onRemove;
  final Function(int) onQuantityChanged;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onRemove,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item.product.id.toString()),
      direction: DismissDirection.endToStart,
      behavior: HitTestBehavior.opaque,
      onDismissed: (direction) {
        onRemove();
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: AppColors.colorDelete,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete, color: Colors.white, size: 28),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: item.product.image,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey[200],
                  child: const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey[200],
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
                  Text(
                    item.product.title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(8),
                  Row(
                    children: [
                      QuantityButton(
                        icon: Icons.remove_circle_outline,
                        onPressed: item.quantity > 1
                            ? () {
                                onQuantityChanged(item.quantity - 1);
                              }
                            : () {},
                      ),
                      QuantityButton(
                        child: Text(
                          '${item.quantity}',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                        ),
                      ),
                      QuantityButton(
                        icon: Icons.add_circle_outline,
                        onPressed: () => onQuantityChanged(item.quantity + 1),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Price
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                '\$${item.totalPrice.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
