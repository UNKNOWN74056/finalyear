import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingWidget extends StatelessWidget {
  const ShimmerLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5, // Number of shimmer items
      shrinkWrap: true,
      itemBuilder: (context, i) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey[300],
              radius: 20,
            ),
            title: Container(
              width: double.infinity,
              height: 16.0,
              color: Colors.grey[300],
            ),
            subtitle: Container(
              width: double.infinity,
              height: 16.0,
              color: Colors.grey[300],
            ),
          ),
        );
      },
    );
  }
}
