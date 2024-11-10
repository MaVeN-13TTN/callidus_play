import 'package:get/get.dart';
import '../providers/network/api_provider.dart';
import '../models/product/category_model.dart';

class CategoryService {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();

  Future<List<Category>> getCategories() async {
    final response = await _apiProvider.get('/categories');
    return (response.data['data'] as List)
        .map((json) => Category.fromJson(json))
        .toList();
  }

  Future<Category> getCategory(int id) async {
    final response = await _apiProvider.get('/categories/$id');
    return Category.fromJson(response.data);
  }

  Future<List<Category>> getSubcategories(int categoryId) async {
    final response =
        await _apiProvider.get('/categories/$categoryId/subcategories');
    return (response.data['data'] as List)
        .map((json) => Category.fromJson(json))
        .toList();
  }
}
