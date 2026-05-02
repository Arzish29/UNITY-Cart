import 'package:flutter/material.dart';
import '../services/local_storage.dart';
import '../services/mock_data.dart';
import '../models/product.dart';

class CommunityProvider extends ChangeNotifier {
  List<String> _selectedCommunities = [];
  String _activeFilter = 'All';
  String _searchQuery = '';
  final List<String> _wishlist = [];
  List<String> _recentlyViewedIds = [];
  bool _isDarkMode = false;
  String _language = 'en';
  bool _isLoading = true;

  List<String> get selectedCommunities => _selectedCommunities;
  String get activeFilter => _activeFilter;
  String get searchQuery => _searchQuery;
  List<String> get wishlist => _wishlist;
  bool get isDarkMode => _isDarkMode;
  String get language => _language;
  bool get isLoading => _isLoading;

  String get primaryCommunity =>
      _selectedCommunities.isNotEmpty ? _selectedCommunities.first : 'Muslim';

  String get greeting => MockData.getGreeting(primaryCommunity);

  Map<String, String> get festivalInfo =>
      MockData.getFestivalInfo(primaryCommunity);

  List<String> get categories =>
      MockData.getCategoriesForCommunity(primaryCommunity);

  List<Product> get filteredProducts {
    List<Product> products = MockData.allProducts.where((p) {
      return _selectedCommunities.contains(p.community);
    }).toList();

    if (_activeFilter != 'All') {
      products = products.where((p) => p.category == _activeFilter).toList();
    }

    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      products = products
          .where((p) =>
              p.name.toLowerCase().contains(q) ||
              p.category.toLowerCase().contains(q) ||
              p.community.toLowerCase().contains(q))
          .toList();
    }

    return products;
  }

  List<Product> get recentlyViewed {
    return _recentlyViewedIds
        .map((id) {
          try {
            return MockData.allProducts.firstWhere((p) => p.id == id);
          } catch (_) {
            return null;
          }
        })
        .where((p) => p != null)
        .cast<Product>()
        .toList();
  }

  Future<void> init() async {
    _isLoading = true;
    final saved = await LocalStorage.getCommunities();
    if (saved != null && saved.isNotEmpty) {
      _selectedCommunities = saved;
    }
    _isDarkMode = await LocalStorage.getTheme();
    _language = await LocalStorage.getLanguage();
    _recentlyViewedIds = await LocalStorage.getRecentlyViewed();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> setCommunities(List<String> communities) async {
    _selectedCommunities = communities;
    _activeFilter = 'All';
    await LocalStorage.saveCommunities(communities);
    notifyListeners();
  }

  void toggleCommunitySelection(String community) {
    if (_selectedCommunities.contains(community)) {
      if (_selectedCommunities.length > 1) {
        _selectedCommunities.remove(community);
      }
    } else {
      _selectedCommunities.add(community);
    }
    notifyListeners();
  }

  void setFilter(String filter) {
    _activeFilter = filter;
    notifyListeners();
  }

  void setSearch(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  bool isWishlisted(String productId) => _wishlist.contains(productId);

  void toggleWishlist(String productId) {
    if (_wishlist.contains(productId)) {
      _wishlist.remove(productId);
    } else {
      _wishlist.add(productId);
    }
    notifyListeners();
  }

  Future<void> addRecentlyViewed(String productId) async {
    await LocalStorage.addRecentlyViewed(productId);
    _recentlyViewedIds = await LocalStorage.getRecentlyViewed();
    notifyListeners();
  }

  Future<void> toggleDarkMode() async {
    _isDarkMode = !_isDarkMode;
    await LocalStorage.saveTheme(_isDarkMode);
    notifyListeners();
  }

  void setLanguage(String lang) {
    _language = lang;
    LocalStorage.saveLanguage(lang);
    notifyListeners();
  }
}
