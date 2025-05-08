import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:assignment/features/categories/presentation/bloc/category_bloc.dart';
import 'package:shimmer/shimmer.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryInitial) {
            context.read<CategoryBloc>().add(GetCategoriesEvent());
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoryLoading) {
            return _buildShimmerLoading();
          } else if (state is CategoryError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${state.message}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<CategoryBloc>().add(GetCategoriesEvent());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (state is CategoryLoaded) {
            return SafeArea(
              child: _buildCategoriesList(context, state.categories),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return ListView.builder(
      itemCount: 10,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 100,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      },
    );
  }

  IconData _getCategoryIcon(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'electronics':
        return Icons.devices;
      case 'clothing':
        return Icons.shopping_bag;
      case 'books':
        return Icons.book;
      case 'food':
        return Icons.restaurant;
      case 'beauty':
        return Icons.face;
      case 'sports':
        return Icons.sports_basketball;
      case 'home':
        return Icons.home;
      case 'toys':
        return Icons.toys;
      default:
        return Icons.category;
    }
  }

  Color _getCategoryColor(String categoryName) {
    final colors = {
      'electronics': [Colors.blue, Colors.blue.shade700],
      'clothing': [Colors.purple, Colors.purple.shade700],
      'books': [Colors.brown, Colors.brown.shade700],
      'food': [Colors.orange, Colors.orange.shade700],
      'beauty': [Colors.pink, Colors.pink.shade700],
      'sports': [Colors.green, Colors.green.shade700],
      'home': [Colors.teal, Colors.teal.shade700],
      'toys': [Colors.amber, Colors.amber.shade700],
    };

    final defaultColors = [Colors.grey, Colors.grey.shade700];
    return colors[categoryName.toLowerCase()]?[0] ?? defaultColors[0];
  }

  Widget _buildCategoriesList(BuildContext context, List<dynamic> categories) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        final categoryName = category.name.toString();
        final categoryColor = _getCategoryColor(categoryName);

        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: InkWell(
            onTap: () {
              context.push('/products/${category.name}');
            },
            borderRadius: BorderRadius.circular(16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [categoryColor, categoryColor.withOpacity(0.8)],
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    categoryName.toUpperCase(),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
