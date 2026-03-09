import 'package:flutter/material.dart';
import 'package:maharat_ecommerce/component/color_manger.dart';
import 'package:maharat_ecommerce/component/styles_manager.dart';
import 'package:maharat_ecommerce/model/home/show_products_response_model.dart';

class SizeOptions extends StatelessWidget {
  final List<SizeModel> sizes;
  final SizeModel? selectedSize;
  final Function(SizeModel) onSizeSelected;

  const SizeOptions({
    Key? key,
    required this.sizes,
     this.selectedSize,
    required this.onSizeSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Row(
        children: [
          // Text("Size :${sizes.length}", style: getBoldStyle(color: Colors.black, fontSize: 16)),
          const SizedBox(width: 10),
          Expanded(
            child: Wrap(
              spacing: 10,
              children: sizes.map((size) {
                final isSelected = size == selectedSize;
                return GestureDetector(
                  onTap: () => onSizeSelected(size),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? ColorManager.primary : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? ColorManager.primary : Colors.grey,
                      ),
                    ),
                    child: Text(
                      size.value??"",
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
