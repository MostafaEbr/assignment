import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:assignment/features/categories/presentation/pages/categories_page.dart';
import 'package:assignment/features/products/presentation/pages/products_page.dart';
import 'package:assignment/features/product_details/presentation/pages/product_details_page.dart';

final router = GoRouter(
  initialLocation: '/categories',
  routes: [
    GoRoute(
      path: '/categories',
      name: 'categories',
      builder: (context, state) => const CategoriesPage(),
    ),
    GoRoute(
      path: '/products/:category',
      name: 'products',
      builder:
          (context, state) =>
              ProductsPage(category: state.pathParameters['category']!),
    ),
    GoRoute(
      path: '/product/:id',
      name: 'product_details',
      builder:
          (context, state) => ProductDetailsPage(
            productId: int.parse(state.pathParameters['id']!),
          ),
    ),
  ],
  errorBuilder:
      (context, state) => Scaffold(
        body: Center(
          child: Text(
            'Error: ${state.error}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
);
