import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../resources/res.dart';

class CustomCacheImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final double? borderRadius;
  final double? loaderSize;
  const CustomCacheImage({super.key, required this.imageUrl, this.height, this.width, this.fit, this.borderRadius, this.loaderSize});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: fit ?? BoxFit.cover,
        height: height,
        width: width,
        progressIndicatorBuilder: (context, url, downloadProgress) => Loading(
          size: loaderSize ?? 50,
        ).center,
        errorWidget: (context, url, error) => const Icon(Icons.error).center,
      ),
    );
  }
}
