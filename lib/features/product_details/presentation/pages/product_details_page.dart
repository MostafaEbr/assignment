import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:assignment/features/product_details/presentation/bloc/product_details_bloc.dart';
import 'package:assignment/features/product_details/presentation/bloc/product_details_event.dart';
import 'package:assignment/features/product_details/presentation/bloc/product_details_state.dart';
import 'package:assignment/config/l10n/app_localizations.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
  int _currentImageIndex = 0;

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

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
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
                        // Image Carousel
                        Stack(
                          children: [
                            CarouselSlider(
                              options: CarouselOptions(
                                height: 300,
                                viewportFraction: 1.0,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _currentImageIndex = index;
                                  });
                                },
                              ),
                              items: product.images.map((imageUrl) {
                                return Image.network(
                                  imageUrl,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                );
                              }).toList(),
                            ),
                            Positioned(
                              bottom: 16,
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: product.images.asMap().entries.map((entry) {
                                  return Container(
                                    width: 8,
                                    height: 8,
                                    margin: const EdgeInsets.symmetric(horizontal: 4),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _currentImageIndex == entry.key
                                          ? Theme.of(context).primaryColor
                                          : Colors.grey,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title
                              _buildAnimatedContent(
                                Text(
                                  product.title,
                                  style: Theme.of(context).textTheme.headlineMedium,
                                ),
                                0,
                              ),
                              const SizedBox(height: 16),

                              // Price and Discount
                              _buildAnimatedContent(
                                Row(
                                  children: [
                                    Text(
                                      '\$${product.price.toStringAsFixed(2)}',
                                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    if (product.discountPercentage > 0)
                                      Text(
                                        '${product.discountPercentage}% off',
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          color: Colors.red,
                                        ),
                                      ),
                                  ],
                                ),
                                1,
                              ),
                              const SizedBox(height: 16),

                              // Description
                              _buildAnimatedContent(
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      l10n.description,
                                      style: Theme.of(context).textTheme.titleLarge,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(product.description),
                                  ],
                                ),
                                2,
                              ),
                              const SizedBox(height: 16),

                              // Product Details
                              _buildAnimatedContent(
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Product Details',
                                      style: Theme.of(context).textTheme.titleLarge,
                                    ),
                                    const SizedBox(height: 8),
                                    _buildInfoRow(l10n.brand, product.brand),
                                    _buildInfoRow(l10n.category, product.category),
                                    _buildInfoRow('SKU', 'SKU-${product.id}'),
                                    _buildInfoRow(l10n.stock, product.stock.toString()),
                                    Row(
                                      children: [
                                        const Icon(Icons.star, color: Colors.amber),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${l10n.rating}: ${product.rating}',
                                          style: Theme.of(context).textTheme.titleMedium,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                3,
                              ),
                              const SizedBox(height: 16),

                              // Tags
                              _buildAnimatedContent(
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Tags',
                                      style: Theme.of(context).textTheme.titleLarge,
                                    ),
                                    const SizedBox(height: 8),
                                    Wrap(
                                      spacing: 8,
                                      children: [
                                        Chip(label: Text(product.category)),
                                        Chip(label: Text(product.brand)),
                                        // Add more tags as needed
                                      ],
                                    ),
                                  ],
                                ),
                                4,
                              ),
                              const SizedBox(height: 16),

                              // Reviews Section
                              _buildAnimatedContent(
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Reviews',
                                      style: Theme.of(context).textTheme.titleLarge,
                                    ),
                                    const SizedBox(height: 8),
                                    // Placeholder for reviews
                                    const Center(
                                      child: Text('No reviews yet'),
                                    ),
                                  ],
                                ),
                                5,
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