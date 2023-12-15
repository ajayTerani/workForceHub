import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RectangleBoxShimmerWidget extends StatelessWidget {
  const RectangleBoxShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var baseColour = Theme.of(context).colorScheme.background;

    return Shimmer.fromColors(
      baseColor: baseColour,
      highlightColor: Colors.grey.withOpacity(.2),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
