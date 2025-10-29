import 'package:fake_store/core/utils/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fake_store/core/theme/app_colors.dart';
import 'package:fake_store/core/utils/show_top_toast.dart';
import 'package:fake_store/core/utils/spinner_view.dart';
import 'package:fake_store/presentation/widgets/app_button.dart';
import 'package:fake_store/presentation/widgets/cart_item_card.dart';
import 'package:go_router/go_router.dart';
import 'package:gap/gap.dart';
import 'cart_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(LoadCart());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      appBar: const CustomAppBar(title: 'Cart'),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoaded) {
            if (state.items.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.shopping_cart_outlined,
                      size: 100,
                      color: AppColors.colorGrey,
                    ),
                    const Gap(16),
                    Text(
                      'Your cart is empty',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.colorGrey,
                      ),
                    ),
                    const Gap(8),
                    Text(
                      'Add items to get started',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.colorGrey,
                      ),
                    ),
                    const Gap(24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: AppButton(
                        isPrimary: true,
                        text: 'Continue Shopping',
                        onPressed: () => context.go('/products'),
                      ),
                    ),
                  ],
                ),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      final item = state.items[index];
                      return CartItemCard(
                        item: item,
                        onRemove: () => context.read<CartBloc>().add(
                          RemoveFromCart(item.product.id),
                        ),
                        onQuantityChanged: (quantity) =>
                            context.read<CartBloc>().add(
                              UpdateQuantity(
                                productId: item.product.id,
                                quantity: quantity,
                              ),
                            ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.colorWhite,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.colorGrey.withOpacity(0.2),
                        blurRadius: 5,
                        offset: const Offset(0, -3),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cart total',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              '\$${state.total.toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Gap(16),
                        Expanded(
                          child: SizedBox(
                            height: 56,
                            child: ElevatedButton(
                              onPressed: () =>
                                  showToastAlert('Checkout coming soon!'),
                              child: const Text('Checkout'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return const SpinnerView();
        },
      ),
    );
  }
}
