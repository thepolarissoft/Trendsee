import 'package:trendoapp/data/models/category_response.dart';

class CategoryUtils {
  String categoryName = "";
  String getCategoryName(List<CategoryResponse> listCategory) {
    // print("listCategory length-> ${listCategory.length}");
    for (var i = 0; i < listCategory.length; i++) {
      categoryName = categoryName + listCategory[i].name!;
      if (i != listCategory.length - 1) {
        categoryName = categoryName + " and ";
      }
    }
    // print("categoryName-> $categoryName");
    return categoryName;
  }
    int categoryId = 0;
  int getCategoryId(List<CategoryResponse> listCategory) {
    // print("listCategory length-> ${listCategory.length}");
    for (var i = 0; i < listCategory.length; i++) {
      categoryId =  listCategory[i].id!;
    
    }
    // print("categoryName-> $categoryName");
    return categoryId;
  }
}
