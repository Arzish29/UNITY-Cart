import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String _communityKey = 'selected_communities';
  static const String _themeKey = 'dark_mode';
  static const String _languageKey = 'language';
  static const String _recentlyViewedKey = 'recently_viewed';

  static Future<void> saveCommunities(List<String> communities) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_communityKey, communities);
  }

  static Future<List<String>?> getCommunities() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_communityKey);
  }

  static Future<bool> hasCommunities() async {
    final prefs = await SharedPreferences.getInstance();
    final communities = prefs.getStringList(_communityKey);
    return communities != null && communities.isNotEmpty;
  }

  static Future<void> saveTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, isDark);
  }

  static Future<bool> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_themeKey) ?? false;
  }

  static Future<void> saveLanguage(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, lang);
  }

  static Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languageKey) ?? 'en';
  }

  static Future<void> addRecentlyViewed(String productId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> viewed = prefs.getStringList(_recentlyViewedKey) ?? [];
    viewed.remove(productId);
    viewed.insert(0, productId);
    if (viewed.length > 10) viewed = viewed.sublist(0, 10);
    await prefs.setStringList(_recentlyViewedKey, viewed);
  }

  static Future<List<String>> getRecentlyViewed() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_recentlyViewedKey) ?? [];
  }

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
