import 'package:flutter/material.dart';
import '../../../domain/entities/home_entity.dart';

class CategoryGrid extends StatelessWidget {
  final List<CategoryEntity> categories;
  const CategoryGrid({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) return const SizedBox.shrink();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final cat = categories[index];
        return Column(
          children: [
            Expanded(child: Image.network(cat.image, fit: BoxFit.contain)),
            const SizedBox(height: 4),
            Text(
              cat.name, 
              style: const TextStyle(fontSize: 12), 
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }
}
