import 'package:complete_advanced_project/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String prefsKeyLang = 'Prefs_Key_Lang';

class AppPreferences{
  SharedPreferences sharedPreferences;
  AppPreferences(this.sharedPreferences);

  Future<String> getAppLanguage() async{
    String? language = sharedPreferences.getString(prefsKeyLang);
    if(language != null && language.isNotEmpty){
      return language;
    }else{
      return LanguageType.english.getValue();
    }
  }
}