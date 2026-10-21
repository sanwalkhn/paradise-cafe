import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SmartImage extends StatelessWidget {
  final String path;
  final BoxFit fit;

  const SmartImage({
    super.key,
    required this.path,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    if (path.startsWith('http')) {
      return Image.network(
        path,
        fit: fit,
        width: double.infinity,
        height: double.infinity,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return const Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          );
        },
        errorBuilder: (context, error, stack) => Icon(
          Icons.image_not_supported_outlined,
          color: AppColors.textHint,
        ),
      );
    }
    return Image.asset(path, fit: fit);
  }
}