import 'dart:convert';
import 'package:http/http.dart' as http;
const default_fromLanguage='English';
const default_toLanguage='Spanish';

// FUNCTION FOR RETREIIVING URL TO IMAGE FILE FOR SPECIFIC LANGUAGE
// PARMS FOR RETREIIVING URL TO IMAGE FILE FOR SPECIFIC



Map<String, String> language_to_country = {
  'af': 'AF',
  'ak': 'GH',
  'am': 'ET',
  'ar': 'SA',
  'as': 'IN',
  'ay': 'BO',
  'az': 'AZ',
  'be': 'BY',
  'bg': 'BG',
  'bho': 'IN',
  'bm': 'ML',
  'bn': 'BD',
  'bs': 'BA',
  'ca': 'ES',
  'ceb': 'PH',
  'ckb': 'IR',
  'co': 'FR',
  'cs': 'CZ',
  'cy': 'CY',
  'da': 'DK',
  'de': 'DE',
  'doi': 'IN',
  'dv': 'MV',
  'ee': 'GH',
  'el': 'GR',
  'en': 'US',
  'eo': 'ES',
  'es': 'ES',
  'et': 'EE',
  'eu': 'ES',
  'fa': 'IR',
  'fi': 'FI',
  'fr': 'FR',
  'fy': 'NL',
  'ga': 'IE',
  'gd': 'GB',
  'gl': 'ES',
  'gn': 'PY',
  'gom': 'IN',
  'gu': 'IN',
  'ha': 'NG',
  'haw': 'US',
  'he': 'IL',
  'hi': 'IN',
  'hmn': 'HM',
  'hr': 'HR',
  'ht': 'HT',
  'hu': 'HU',
  'hy': 'AM',
  'id': 'ID',
  'ig': 'NG',
  'ilo': 'PH',
  'is': 'IS',
  'it': 'IT',
  'iw': 'IL',
  'ja': 'JP',
  'jv': 'ID',
  'jw': 'ID',
  'ka': 'GE',
  'kk': 'KZ',
  'km': 'KH',
  'kn': 'IN',
  'ko': 'KR',
  'kri': 'IN',
  'ku': 'SY',
  'ky': 'KG',
  'la': 'IT',
  'lb': 'LU',
  'lg': 'UG',
  'ln': 'CD',
  'lo': 'LA',
  'lt': 'LT',
  'lus': 'US',
  'lv': 'LV',
  'mai': 'IN',
  'mg': 'MG',
  'mi': 'NZ',
  'mk': 'MK',
  'ml': 'IN',
  'mn': 'MN',
  'mni-Mtei': 'IN',
  'mr': 'IN',
  'ms': 'MY',
  'mt': 'MT',
  'my': 'MM',
  'ne': 'NP',
  'nl': 'NL',
  'no': 'NO',
  'nso': 'ZA',
  'ny': 'MW',
  'om': 'ET',
  'or': 'IN',
  'pa': 'IN',
  'pl': 'PL',
  'ps': 'AF',
  'pt': 'PT',
  'qu': 'PE',
  'ro': 'RO',
  'ru': 'RU',
  'rw': 'RW',
  'sa': 'IN',
  'sd': 'PK',
  'si': 'LK',
  'sk': 'SK',
  'sl': 'SI',
  'sm': 'WS',
  'sn': 'ZW',
  'so': 'SO',
  'sq': 'AL',
  'sr': 'RS',
  'st': 'LS',
  'su': 'ID',
  'sv': 'SE',
  'sw': 'TZ',
  'ta': 'IN',
  'te': 'IN',
  'tg': 'TJ',
  'th': 'TH',
  'ti': 'ER',
  'tk': 'TM',
  'tl': 'PH',
  'tr': 'TR',
  'ts': 'ZA',
  'tt': 'RU',
  'ug': 'CN',
  'uk': 'UA',
  'ur': 'PK',
  'uz': 'UZ',
  'vi': 'VN',
  'xh': 'ZA',
  'yi': 'IL',
  'yo': 'NG',
  'zh': 'CN',
  'zh-CN': 'CN',
  'zh-TW': 'TW',
  'zu': 'ZA',
};





Map<String, String> languageCodes = {
  'Afrikaans': 'af',
  'Akan': 'ak',
  'Amharic': 'am',
  'Arabic': 'ar',
  'Assamese': 'as',
  'Aymara': 'ay',
  'Azerbaijani': 'az',
  'Belarusian': 'be',
  'Bulgarian': 'bg',
  'Bhojpuri': 'bho',
  'Bambara': 'bm',
  'Bengali': 'bn',
  'Bosnian': 'bs',
  'Catalan': 'ca',
  'Cebuano': 'ceb',
  'Central Kurdish': 'ckb',
  'Corsican': 'co',
  'Czech': 'cs',
  'Welsh': 'cy',
  'Danish': 'da',
  'German': 'de',
  'Dogri': 'doi',
  'Divehi': 'dv',
  'Ewe': 'ee',
  'Greek': 'el',
  'English': 'en',
  'Esperanto': 'eo',
  'Spanish': 'es',
  'Estonian': 'et',
  'Basque': 'eu',
  'Persian': 'fa',
  'Finnish': 'fi',
  'French': 'fr',
  'Western Frisian': 'fy',
  'Irish': 'ga',
  'Scottish Gaelic': 'gd',
  'Galician': 'gl',
  'Guarani': 'gn',
  'Goan Konkani': 'gom',
  'Gujarati': 'gu',
  'Hausa': 'ha',
  'Hawaiian': 'haw',
  'Hebrew': 'he',
  'Hindi': 'hi',
  'Hmong': 'hmn',
  'Croatian': 'hr',
  'Haitian Creole': 'ht',
  'Hungarian': 'hu',
  'Armenian': 'hy',
  'Indonesian': 'id',
  'Igbo': 'ig',
  'Iloko': 'ilo',
  'Icelandic': 'is',
  'Italian': 'it',
 
  'Japanese': 'ja',
  'Javanese': 'jv',
  'Georgian': 'ka',
  'Kazakh': 'kk',
  'Khmer': 'km',
  'Kannada': 'kn',
  'Korean': 'ko',
  'Krio': 'kri',
  'Kurdish': 'ku',
  'Kyrgyz': 'ky',
  'Latin': 'la',
  'Luxembourgish': 'lb',
  'Ganda': 'lg',
  'Lingala': 'ln',
  'Lao': 'lo',
  'Lithuanian': 'lt',
  'Mizo': 'lus',
  'Latvian': 'lv',
  'Maithili': 'mai',
  'Malagasy': 'mg',
  'Maori': 'mi',
  'Macedonian': 'mk',
  'Malayalam': 'ml',
  'Mongolian': 'mn',
  'Meitei': 'mni-Mtei',
  'Marathi': 'mr',
  'Malay': 'ms',
  'Maltese': 'mt',
  'Burmese': 'my',
  'Nepali': 'ne',
  'Dutch': 'nl',
  'Norwegian': 'no',
  'Northern Sotho': 'nso',
  'Chichewa': 'ny',
  'Oromo': 'om',
  'Odia': 'or',
  'Punjabi': 'pa',
  'Polish': 'pl',
  'Pashto': 'ps',
  'Portuguese': 'pt',
  'Quechua': 'qu',
  'Romanian': 'ro',
  'Russian': 'ru',
  'Kinyarwanda': 'rw',
  'Sanskrit': 'sa',
  'Sindhi': 'sd',
  'Sinhala': 'si',
  'Slovak': 'sk',
  'Slovenian': 'sl',
  'Samoan': 'sm',
  'Shona': 'sn',
  'Somali': 'so',
  'Albanian': 'sq',
  'Serbian': 'sr',
  'Southern Sotho': 'st',
  'Sundanese': 'su',
  'Swedish': 'sv',
  'Swahili': 'sw',
  'Tamil': 'ta',
  'Telugu': 'te',
  'Tajik': 'tg',
  'Thai': 'th',
  'Tigrinya': 'ti',
  'Turkmen': 'tk',
  'Tagalog': 'tl',
  'Turkish': 'tr',
  'Tsonga': 'ts',
  'Tatar': 'tt',
  'Uyghur': 'ug',
  'Ukrainian': 'uk',
  'Urdu': 'ur',
  'Uzbek': 'uz',
  'Vietnamese': 'vi',
  'Xhosa': 'xh',
  'Yiddish': 'yi',
  'Yoruba': 'yo',
  'Chinese': 'zh',
  'Chinese (Simplified)': 'zh-CN',
  'Chinese (Traditional)': 'zh-TW',
  'Zulu': 'zu',
};
