import 'package:get/get.dart';

class AppTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'home': 'Home',
      'Title': "Title",
      'artis': 'Artis'
    },
    'km_KH': {
      'home': 'ទំព័រដើម',
      'Title': 'ចំណងជើង',
      'artis': 'អ្នកនិពន្ធ'
    },
    'zh_CN': {
      'home': '家',
      'Title': '標題',
      'artis': '艺术家'
    },
  };
}