import 'package:get/get.dart';
import '../../../data/services/category_service.dart';
import '../../../data/services/product_service.dart';
import '../../../data/models/product/category_model.dart';
import '../../../data/models/product/product_model.dart';
import '../../../routes/app_pages.dart';

class CategoriesController extends GetxController {
  final CategoryService _categoryService = Get.find<CategoryService>();
  final ProductService _productService = Get.find<ProductService>();

  // States
  final RxBool isLoading = false.obs;
  final RxList<Category> categories = <Category>[].obs;
  final RxList<Product> categoryProducts = <Product>[].obs;
  final Rx<Category?> selectedCategory = Rx<Category?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchCategories();

    // Check if category was passed as argument
    if (Get.arguments != null && Get.arguments is Category) {
      selectedCategory.value = Get.arguments as Category;
      fetchCategoryProducts();
    }
  }

  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;
      final result = await _categoryService.getCategories();
      categories.value = result;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load categories',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCategoryProducts() async {
    if (selectedCategory.value == null) return;

    try {
      isLoading.value = true;
      final result = await _productService.getProducts(
        filters: {'category_id': selectedCategory.value!.id},
      );
      categoryProducts.value = result;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load category products',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void selectCategory(Category category) {
    selectedCategory.value = category;
    fetchCategoryProducts();
  }

  void navigateToProduct(Product product) {
    Get.toNamed(Routes.PRODUCT_DETAIL, arguments: product);
  }
}
