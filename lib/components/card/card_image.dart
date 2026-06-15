import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../infrastructure/theme/app_style.dart';

class CardImage extends StatelessWidget {
  const CardImage.circle({
    Key? key,
    this.image,
    this.size = 26,
    this.isCircle = true,
  }) : super(key: key);

  const CardImage.rectangle({
    Key? key,
    this.image,
    this.size = 26,
    this.isCircle = false,
  }) : super(key: key);

  final String? image;
  final double size;
  final bool isCircle;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      cacheManager: DefaultCacheManager(),
      imageUrl: image ?? '',
      imageBuilder: (context, imageProvider) {
        return isCircle
            ? _imageCircle(imageProvider)
            : _imageRectangle(imageProvider);
      },
      placeholder: (context, url) => CircleAvatar(
        radius: size.r,
        backgroundColor: Colors.white,
        child: Center(
          child: CupertinoActivityIndicator(color: AppStyle.kSecondaryColor2),
        ),
      ),
      errorWidget: (context, url, error) =>
          isCircle ? _circleError : _rectangleError,
    );
  }

  Widget _imageCircle(ImageProvider<Object> imageProvider) {
    return CircleAvatar(
      radius: size.r,
      backgroundColor: Colors.blueGrey,
      backgroundImage: imageProvider,
    );
  }

  Widget get _circleError {
    return CircleAvatar(
      radius: size.r,
      backgroundColor: AppStyle.kErrorColor.withOpacity(0.2),
      child: Center(
        child: Icon(
          Icons.error,
          color: AppStyle.kErrorColor,
          size: (size - 6).r,
        ),
      ),
    );
  }

  Widget _imageRectangle(ImageProvider<Object> imageProvider) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: Image(
        image: imageProvider,
        width: size.r,
        height: size.r,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget get _rectangleError {
    return Container(
      width: size.r,
      height: size.r,
      decoration: BoxDecoration(
        color: AppStyle.kErrorColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Center(
        child: Icon(
          Icons.error,
          color: AppStyle.kErrorColor,
          size: (size - 12).r,
        ),
      ),
    );
  }
}
