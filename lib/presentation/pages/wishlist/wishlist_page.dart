import 'package:fake_store/core/utils/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fake_store/core/theme/app_colors.dart';
import 'package:fake_store/core/utils/show_top_toast.dart';
import 'package:fake_store/core/utils/spinner_view.dart';
import 'package:fake_store/presentation/widgets/app_button.dart';
import 'package:fake_store/presentation/widgets/wishlist_item_card.dart';
import 'package:fake_store/presentation/pages/wishlist/wishlist_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gap/gap.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  void initState() {
    super.initState();
    context.read<WishlistBloc>().add(LoadWishlist());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      appBar: const CustomAppBar(title: 'Wishlist'),
      body: BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          if (state is WishlistLoading) return const SpinnerView();

          if (state is WishlistError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  const Gap(16),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<WishlistBloc>().add(LoadWishlist()),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is WishlistLoaded) {
            if (state.products.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 100,
                      color: AppColors.colorGreyLight,
                    ),
                    const Gap(16),
                    Text(
                      'Your wishlist is empty',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.colorGrey,
                      ),
                    ),
                    const Gap(8),
                    Text(
                      'Add items you like to your wishlist',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.colorGrey,
                      ),
                    ),
                    const Gap(24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: AppButton(
                        isPrimary: true,
                        text: 'Start Shopping',
                        onPressed: () => context.go('/products'),
                      ),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return WishlistItemCard(
                  product: product,
                  onRemove: () => context.read<WishlistBloc>().add(
                    RemoveFromWishlist(product.id),
                  ),
                  onAddToCart: () {
                    context.read<WishlistBloc>().add(
                      AddToCartFromWishlist(product),
                    );
                    showToastAlert('Added to cart');
                  },
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
