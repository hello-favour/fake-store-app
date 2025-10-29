import 'package:fake_store/core/theme/app_colors.dart';
import 'package:fake_store/core/utils/show_top_toast.dart';
import 'package:fake_store/core/utils/spinner_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../products/product_bloc.dart';

class ProductDetailPage extends StatefulWidget {
  final String productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(
      LoadProductDetail(int.parse(widget.productId)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      appBar: AppBar(
        backgroundColor: AppColors.colorWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.colorBlack),
          onPressed: () => context.pop(),
        ),
        actions: [
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductDetailLoaded) {
                return IconButton(
                  icon: Icon(
                    state.isInWishlist ? Icons.favorite : Icons.favorite_border,
                    color: state.isInWishlist
                        ? AppColors.colorRed
                        : AppColors.colorBlack,
                  ),
                  onPressed: () {
                    context.read<ProductBloc>().add(
                      ToggleWishlist(state.product),
                    );
                  },
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductDetailLoading) {
            return const SpinnerView();
          }

          if (state is ProductError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  const Gap(16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ProductBloc>().add(
                        LoadProductDetail(int.parse(widget.productId)),
                      );
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is ProductDetailLoaded) {
            final product = state.product;

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 400,
                          color: AppColors.colorGreyLight.withOpacity(0.5),
                          child: Center(
                            child: CachedNetworkImage(
                              imageUrl: product.image,
                              height: 300,
                              fit: BoxFit.contain,
                              placeholder: (context, url) =>
                                  const SpinnerView(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error, size: 48),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                style: Theme.of(context).textTheme.headlineSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22,
                                      color: AppColors.colorBlack,
                                    ),
                              ),
                              const Gap(8),
                              Text(
                                product.category,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: AppColors.colorGrey,
                                      fontSize: 14,
                                    ),
                              ),
                              const Gap(12),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: AppColors.colorBlack,
                                    size: 18,
                                  ),
                                  const Gap(4),
                                  Text(
                                    product.rating.rate.toStringAsFixed(2),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                  ),
                                  const Gap(4),
                                  Text(
                                    '|${product.rating.count} Reviews',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: AppColors.colorGrey,
                                          fontSize: 14,
                                        ),
                                  ),
                                ],
                              ),
                              const Gap(24),
                              Text(
                                product.description,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: AppColors.colorGrey,
                                      height: 1.6,
                                      fontSize: 14,
                                    ),
                              ),
                              const Gap(24),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(color: AppColors.colorYellow),
                  child: SafeArea(
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Price',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    fontSize: 13,
                                    color: AppColors.colorBlack,
                                  ),
                            ),
                            const Gap(4),
                            Text(
                              '\$${product.price.toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: AppColors.colorBlack,
                                  ),
                            ),
                          ],
                        ),
                        const Gap(16),
                        Expanded(
                          child: SizedBox(
                            height: 56,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.colorBlack,
                                foregroundColor: AppColors.colorWhite,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                                disabledBackgroundColor: AppColors.colorBlack,
                              ),
                              onPressed: state.isInCart
                                  ? null
                                  : () {
                                      context.read<ProductBloc>().add(
                                        AddToCart(product),
                                      );
                                      showToastAlert('Added to cart');
                                    },
                              child: Text(
                                state.isInCart ? 'In Cart' : 'Add to cart',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
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

          return const SizedBox();
        },
      ),
    );
  }
}
