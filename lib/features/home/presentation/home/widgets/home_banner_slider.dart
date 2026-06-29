import 'package:flutter/material.dart';

import '../../../domain/entities/home_entity.dart';

class HomeBannerSlider extends StatelessWidget {
  final List<BannerEntity> banners;
  const HomeBannerSlider({super.key, required this.banners});

  @override
  Widget build(BuildContext context) {
    if (banners.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 200,
      child: PageView.builder(
        itemCount: banners.length,
        itemBuilder: (context, index) {
          return Image.network(banners[index].image, fit: BoxFit.cover);
        },
      ),
    );
  }
}
