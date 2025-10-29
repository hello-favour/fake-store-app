import 'package:fake_store/core/utils/custom_app_bar.dart';
import 'package:fake_store/presentation/pages/user/user_bloc.dart';
import 'package:fake_store/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:fake_store/core/theme/app_colors.dart';
import 'package:fake_store/core/utils/spinner_view.dart';
import 'package:fake_store/presentation/widgets/product_card.dart';
import 'package:fake_store/presentation/pages/products/product_bloc.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool _hasLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadDataOnce();
  }

  void _loadDataOnce() {
    if (!_hasLoaded) {
      context.read<ProductBloc>().add(LoadProducts());
      context.read<UserBloc>().add(LoadCachedUser());
      context.read<UserBloc>().add(const LoadUser(1));
      _hasLoaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      appBar: CustomAppBar(
        title: 'Welcome,',
        subtitle: BlocBuilder<UserBloc, UserState>(
          builder: (context, userState) {
            if (userState is UserLoaded) {
              return Text(
                userState.user.username,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const SpinnerView();
          }
          if (state is ProductError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  const Gap(16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: AppButton(
                      isPrimary: true,
                      text: 'Retry',
                      onPressed: () =>
                          context.read<ProductBloc>().add(LoadProducts()),
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is ProductLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                final isInWishlist = state.wishlistProductIds.contains(
                  product.id,
                );
                return ProductCard(
                  product: product,
                  isInWishlist: isInWishlist,
                  onTap: () => context.push('/product-detail/${product.id}'),
                  onWishlistTap: () =>
                      context.read<ProductBloc>().add(ToggleWishlist(product)),
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
