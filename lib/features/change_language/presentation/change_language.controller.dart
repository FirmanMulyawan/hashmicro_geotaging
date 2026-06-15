part of change_language_lib;

class ChangeLanguageController extends GetxController {
  static const String _languageKey = 'selected_language';

  final languages = [
    {
      'code': 'en_US',
      'name': 'English',
      'nativeName': 'English',
      'flag': 'https://flagcdn.com/w80/us.png',
    },
    {
      'code': 'id_ID',
      'name': 'Indonesian',
      'nativeName': 'Bahasa Indonesia',
      'flag': 'https://flagcdn.com/w80/id.png',
    },
  ];

  var selectedLanguage = 'en_US'.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSavedLanguage();
  }

  Future<void> _loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLanguage = prefs.getString(_languageKey) ?? 'en_US';
    selectedLanguage.value = savedLanguage;
  }

  Future<void> changeLanguage(String languageCode) async {
    selectedLanguage.value = languageCode;

    final parts = languageCode.split('_');
    final locale = Locale(parts[0], parts.length > 1 ? parts[1] : '');

    Get.updateLocale(locale);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, languageCode);
  }
}
