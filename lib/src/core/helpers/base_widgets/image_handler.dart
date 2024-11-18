import 'package:doctors_appointment/src/core/helpers/base_widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/app_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NetworkImageHandler extends StatelessWidget {
  final String url;
  final BoxShape? shape;
  const NetworkImageHandler({super.key,
    required this.url,
    this.shape
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        shape: shape?? BoxShape.rectangle
      ),
      child: Image.network(
        url,
        fit: BoxFit.fill,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return SizedBox(
                width: 10.w,
                height: 10.h,
                child: CircularProgressIndicator(
                    value: loadingProgress.cumulativeBytesLoaded / 3500000
                )
            );
          }
        },
        errorBuilder: (context, error, stackTrace) => MyText(
          text: 'Failed Load Image',
          color: Constants.appColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class CachedNetworkImageHandler extends StatelessWidget {

  final String url;
  final double? height;
  final double? width;

  const CachedNetworkImageHandler({super.key,
    required this.url,
    this.width,
    this.height
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: BoxFit.fill,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) => Center(
        child: MyText(
          text: 'Failed Load Image',
          color: Constants.appColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

