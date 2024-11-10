import 'package:get/get.dart';
import '../providers/network/api_provider.dart';
import '../models/product/product_model.dart';

class ProductService {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();

  Future<List<Product>> getProducts({
    int? categoryId,
    String? search,
    String? sort,
    Map<String, dynamic>? filters,
    int? page,
    int? limit,
  }) async {
    final response = await _apiProvider.get(
      '/products',
      queryParameters: {
        if (categoryId != null) 'category_id': categoryId,
        if (search != null) 'search': search,
        if (sort != null) 'sort': sort,
        if (filters != null) ...filters,
        if (page != null) 'page': page,
        if (limit != null) 'limit': limit,
      },
    );

    return (response.data['data'] as List)
        .map((json) => Product.fromJson(json))
        .toList();
  }

  Future<Product> getProduct(int id) async {
    final response = await _apiProvider.get('/products/$id');
    return Product.fromJson(response.data);
  }

  Future<List<Product>> getFeaturedProducts() async {
    final response = await _apiProvider.get('/products/featured');
    return (response.data['data'] as List)
        .map((json) => Product.fromJson(json))
        .toList();
  }

  Future<List<Product>> getRelatedProducts(int productId) async {
    final response = await _apiProvider.get('/products/$productId/related');
    return (response.data['data'] as List)
        .map((json) => Product.fromJson(json))
        .toList();
  }

  fetchReviews(int productId) {}
}
