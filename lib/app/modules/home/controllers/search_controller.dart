// ignore_for_file: constant_identifier_names, avoid_print

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/services/product_service.dart';
import '../../../data/models/product/product_model.dart';

class SearchController extends GetxController {
  final ProductService _productService = Get.find<ProductService>();
  final GetStorage _storage = GetStorage();

  static const String SEARCH_HISTORY_KEY = 'search_history';
  static const int MAX_HISTORY_ITEMS = 10;

  final RxString searchQuery = ''.obs;
  final RxList<Product> searchResults = <Product>[].obs;
  final RxList<String> searchHistory = <String>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool showSuggestions = false.obs;

  // Filter states
  final RxDouble minPrice = 0.0.obs;
  final RxDouble maxPrice = 1000.0.obs;
  final RxList<String> selectedCategories = <String>[].obs;
  final RxBool onlyInStock = false.obs;
  final RxString sortBy = 'relevance'.obs;

  Worker? _searchWorker;

  @override
  void onInit() {
    super.onInit();
    _loadSearchHistory();
    _setupSearchDebounce();
  }

  void _setupSearchDebounce() {
    _searchWorker = debounce(
      searchQuery,
      (value) => _performSearch(value),
      time: const Duration(milliseconds: 500),
    );
  }

  @override
  void onClose() {
    _searchWorker?.dispose();
    super.onClose();
  }

  Future<void> _loadSearchHistory() async {
    final history = _storage.read<List<dynamic>>(SEARCH_HISTORY_KEY) ?? [];
    searchHistory.value = history.cast<String>();
  }

  Future<void> _saveSearchHistory() async {
    await _storage.write(SEARCH_HISTORY_KEY, searchHistory.toList());
  }

  void addToSearchHistory(String query) {
    if (query.isEmpty) return;

    searchHistory.remove(query); // Remove if exists
    searchHistory.insert(0, query); // Add to beginning

    if (searchHistory.length > MAX_HISTORY_ITEMS) {
      searchHistory.removeLast();
    }

    _saveSearchHistory();
  }

  void removeFromHistory(String query) {
    searchHistory.remove(query);
    _saveSearchHistory();
  }

  void clearSearchHistory() {
    searchHistory.clear();
    _saveSearchHistory();
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    showSuggestions.value = query.isNotEmpty;
  }

  Map<String, dynamic> get _currentFilters => {
        if (minPrice.value > 0) 'min_price': minPrice.value,
        if (maxPrice.value < 1000) 'max_price': maxPrice.value,
        if (selectedCategories.isNotEmpty) 'categories': selectedCategories,
        if (onlyInStock.value) 'in_stock': true,
        if (sortBy.value != 'relevance') 'sort': sortBy.value,
      };

  Future<void> _performSearch(String query) async {
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    try {
      isLoading.value = true;
      final results = await _productService.getProducts(
        search: query,
        limit: 20,
        filters: _currentFilters,
      );
      searchResults.value = results;
      addToSearchHistory(query);
    } catch (e) {
      print('Search error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void applyFilters() {
    _performSearch(searchQuery.value);
  }

  void resetFilters() {
    minPrice.value = 0.0;
    maxPrice.value = 1000.0;
    selectedCategories.clear();
    onlyInStock.value = false;
    sortBy.value = 'relevance';
    applyFilters();
  }
}
