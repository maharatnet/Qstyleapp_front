import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoryGridShimmerWidget extends StatelessWidget {
  const CategoryGridShimmerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: 6, // عدد العناصر الوهمية
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 1.25,
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          color: Colors.grey.shade300,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.remove_red_eye, color: Colors.grey.shade400),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 14,
                            width: 80,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 10,
                            width: 50,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 12,
                            width: 60,
                            color: Colors.grey.shade300,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
