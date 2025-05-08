import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const _localizedValues = <String, Map<String, String>>{
    'en': {
      'categories': 'Categories',
      'products': 'Products',
      'productDetails': 'Product Details',
      'description': 'Description',
      'brand': 'Brand',
      'category': 'Category',
      'rating': 'Rating',
      'stock': 'Stock',
      'gallery': 'Gallery',
      'noProducts': 'No products found',
      'error': 'Error',
      'back': 'Back',
    },
    'es': {
      'categories': 'Categorías',
      'products': 'Productos',
      'productDetails': 'Detalles del Producto',
      'description': 'Descripción',
      'brand': 'Marca',
      'category': 'Categoría',
      'rating': 'Calificación',
      'stock': 'Stock',
      'gallery': 'Galería',
      'noProducts': 'No se encontraron productos',
      'error': 'Error',
      'back': 'Atrás',
    },
  };

  String get categories =>
      _localizedValues[locale.languageCode]!['categories']!;
  String get products => _localizedValues[locale.languageCode]!['products']!;
  String get productDetails =>
      _localizedValues[locale.languageCode]!['productDetails']!;
  String get description =>
      _localizedValues[locale.languageCode]!['description']!;
  String get brand => _localizedValues[locale.languageCode]!['brand']!;
  String get category => _localizedValues[locale.languageCode]!['category']!;
  String get rating => _localizedValues[locale.languageCode]!['rating']!;
  String get stock => _localizedValues[locale.languageCode]!['stock']!;
  String get gallery => _localizedValues[locale.languageCode]!['gallery']!;
  String get noProducts =>
      _localizedValues[locale.languageCode]!['noProducts']!;
  String get error => _localizedValues[locale.languageCode]!['error']!;
  String get back => _localizedValues[locale.languageCode]!['back']!;
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'es'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
