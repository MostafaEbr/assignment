import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:assignment/features/product_details/presentation/bloc/product_details_bloc.dart';
import 'package:assignment/features/product_details/presentation/bloc/product_details_event.dart';
import 'package:assignment/features/product_details/presentation/bloc/product_details_state.dart';
import 'package:assignment/config/l10n/app_localizations.dart';

class ProductDetailsPage extends StatefulWidget {
  final int productId;

  const ProductDetailsPage({super.key, required this.productId});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    context.read<ProductDetailsBloc>().add(
      GetProductDetailsEvent(widget.productId),
    );

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAnimatedContent(Widget child, int index) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, (1 - _controller.value) * 50 * (index + 1)),
          child: Opacity(opacity: _controller.value, child: child),
        );
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.productDetails),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
        builder: (context, state) {
          if (state is ProductDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductDetailsLoaded) {
            final product = state.product;
            return FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                          tag: 'product_${product.id}',
                          child: Image.network(
                            product.thumbnail,
                            width: double.infinity,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildAnimatedContent(
                                Text(
                                  product.title,
                                  style:
                                      Theme.of(
                                        context,
                                      ).textTheme.headlineMedium,
                                ),
                                0,
                              ),
                              const SizedBox(height: 8),
                              _buildAnimatedContent(
                                Row(
                                  children: [
                                    Text(
                                      '\$${product.price.toStringAsFixed(2)}',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.headlineSmall?.copyWith(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    if (product.discountPercentage > 0)
                                      Text(
                                        '${product.discountPercentage}% off',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(color: Colors.red),
                                      ),
                                  ],
                                ),
                                1,
                              ),
                              const SizedBox(height: 16),
                              _buildAnimatedContent(
                                Text(
                                  l10n.description,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                2,
                              ),
                              const SizedBox(height: 8),
                              _buildAnimatedContent(
                                Text(product.description),
                                3,
                              ),
                              const SizedBox(height: 16),
                              _buildAnimatedContent(
                                Text(
                                  '${l10n.brand}: ${product.brand}',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                4,
                              ),
                              const SizedBox(height: 8),
                              _buildAnimatedContent(
                                Text(
                                  '${l10n.category}: ${product.category}',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                5,
                              ),
                              const SizedBox(height: 8),
                              _buildAnimatedContent(
                                Row(
                                  children: [
                                    const Icon(Icons.star, color: Colors.amber),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${l10n.rating}: ${product.rating}',
                                      style:
                                          Theme.of(
                                            context,
                                          ).textTheme.titleMedium,
                                    ),
                                  ],
                                ),
                                6,
                              ),
                              const SizedBox(height: 8),
                              _buildAnimatedContent(
                                Text(
                                  '${l10n.stock}: ${product.stock}',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                7,
                              ),
                              const SizedBox(height: 16),
                              _buildAnimatedContent(
                                Text(
                                  l10n.gallery,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                8,
                              ),
                              const SizedBox(height: 8),
                              _buildAnimatedContent(
                                SizedBox(
                                  height: 100,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: product.images.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          right: 8.0,
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          child: Image.network(
                                            product.images[index],
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                9,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else if (state is ProductDetailsError) {
            return Center(child: Text('${l10n.error}: ${state.message}'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
