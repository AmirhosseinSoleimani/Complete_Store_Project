enum LanguageType{
  english,
  persian,
}

const String persian = 'fa';
const String english = 'en';

extension LanguageTypeExtension on LanguageType{
  String getValue(){
    switch(this){
      case LanguageType.english:
        return english;
        break;
      case LanguageType.persian:
        return persian;
        break;
    }
  }
}