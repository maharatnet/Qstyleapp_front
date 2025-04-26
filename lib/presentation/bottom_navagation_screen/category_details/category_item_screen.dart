import 'package:flutter/material.dart';
import 'package:maharat_ecommerce/component/color_manger.dart';
import 'package:maharat_ecommerce/component/component.dart';
import 'package:maharat_ecommerce/component/constant.dart';
import 'package:maharat_ecommerce/component/font_manager.dart';
import 'package:maharat_ecommerce/component/styles_manager.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/category_details/category_details_screen.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/home_screen/components/search_field.dart';
class CategoryItemScreen extends StatefulWidget {
  const CategoryItemScreen({Key? key}) : super(key: key);

  @override
  State<CategoryItemScreen> createState() => _CategoryItemScreenState();
}

class _CategoryItemScreenState extends State<CategoryItemScreen> {
  String searchQuery = "";
  String selectedFilter = "All";
  List<CategoryHomeModel> filteredList = dataListItems;
  List<String> selectedFilters = []; // للحفاظ على الاختيارات المتعددة

  // فلترة حسب السعر أو الخصومات أو البراندات
  void updateFilters(String query) {
    setState(() {
      filteredList = dataListItems
          .where((item) {
        bool matchesSearch = item.name.toLowerCase().contains(query.toLowerCase());

        // تحقق من الفلاتر
        bool matchesFilter = true;
        if (selectedFilters.contains("Highest Price") && item.price <= 100) {
          matchesFilter = false;
        }
        if (selectedFilters.contains("Lowest Price") && item.price >= 200) {
          matchesFilter = false;
        }
        if (selectedFilters.contains("Discounted") && item.discount <= 0) {
          matchesFilter = false;
        }
        if (selectedFilters.contains("Brand A") && item.brand != "Brand A") {
          matchesFilter = false;
        }

        return matchesSearch && matchesFilter;
      })
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Category Items',style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s18),)),
      body: Column(
        children: [
          // سيرش بار
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child:SearchField(onChanged: (query) => updateFilters(query,)),
            // TextField(
            //   onChanged: (query) => updateFilters(query,),
            //   decoration: InputDecoration(
            //     hintText: 'ابحث عن منتج...',
            //     prefixIcon: Icon(Icons.search),
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(12),
            //     ),
            //   ),
            // ),
          ),
          const SizedBox(height: 10),

          // فلاتر
          // فلاتر متعددة مع شكل دائري
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Wrap(
              children: [
                // فلتر السعر الأعلى
                filterChip('أعلى سعر', 'Highest Price'),
                // فلتر السعر الأقل
                filterChip('أقل سعر', 'Lowest Price'),
                // فلتر الخصم
                filterChip(' خصم', 'Discounted'),
                // فلتر البراندات
                filterChip('Brand A', 'Brand A'),

              ],
            ),
          ),
          const SizedBox(height: 10),

          // عرض المنتجات باستخدام GridView
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 عناصر في الصف الواحد
                crossAxisSpacing: 10, // المسافة بين الأعمدة
                mainAxisSpacing: 10, // المسافة بين الصفوف
                childAspectRatio: 0.8, // عرض العنصر بنسبة معينة
                // childAspectRatio: 0.75, // عرض العنصر بنسبة معينة
              ),
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final e = filteredList[index];
                return GestureDetector(
                  onTap: () {
                    navigateTo(context, CategoryDetailsScreen());
                    // الانتقال لتفاصيل المنتج
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: kSecondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        AspectRatio(
                          aspectRatio: 1.25,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: Image.asset(e.image),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          e.name,
                          style: getBoldStyle(color: Colors.black, fontSize: FontSize.s16),
                        ),
                        if (e.discount > 0)
                          Text(
                            'خصم ${e.discount}%',
                            style: TextStyle(color: Colors.red),
                          ),
                        Text(
                          '${e.price} جنيه',
                          style: getBoldStyle(color: Colors.black, fontSize: FontSize.s14),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  // دالة لعرض الفلاتر بشكل دائري
  Widget filterChip(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
      child: FilterChip(
        label: Text(label),
        selected: selectedFilters.contains(value),
        onSelected: (bool selected) {
          setState(() {
            if (selected) {
              selectedFilters.add(value);
            } else {
              selectedFilters.remove(value);
            }
          });
          updateFilters(searchQuery);
        },
        selectedColor: ColorManager.primary, // لون الخلفية عند التحديد
        labelStyle: getBoldStyle(
          color: selectedFilters.contains(value) ? Colors.white : Colors.black,
        ),
        backgroundColor: Colors.grey.shade200, // لون الخلفية عند عدم التحديد
        // backgroundColor: Colors.grey.shade200, // لون الخلفية عند عدم التحديد
        shape: StadiumBorder(),
      ),
    );
  }
}

class CategoryHomeModel {
  String name;
  String? brand;
  String image;
  double price;
  double discount;

  CategoryHomeModel({
    required this.name,
     this.brand,
    required this.image,
    required this.price,
    required this.discount,
  });
}


List<CategoryHomeModel> dataListItems = [
  CategoryHomeModel(
    name: "تيشيرت",
    image: "assets/images/ps4_console_white_1.png",
    price: 100, // مثال للسعر
    discount: 10, // مثال للخصم
    brand: "Brand A",

  ),
  CategoryHomeModel(
    name: "بنطلون",
    image: "assets/images/ps4_console_white_2.png",
    price: 150,
    discount: 0,
    brand: "Brand A",
  ),
  CategoryHomeModel(
    name: "ساعة",
    image: "assets/images/ps4_console_white_3.png",
    price: 200,
    discount: 5,
    brand: "Brand C",
  ),
  CategoryHomeModel(
    name: "حذاء",
    image: "assets/images/ps4_console_white_4.png",
    price: 250,
    discount: 20,
    brand: "Brand A",
  ),
  CategoryHomeModel(
    name: "ملابس",
    image: "assets/images/ps4_console_white_4.png",
    price: 90,
    discount: 15,
    brand: "Brand A",
  ),
];
