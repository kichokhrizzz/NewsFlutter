import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app/src/models/category_model.dart';
import 'package:news_app/src/models/news_models.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;


final _API_KEY = '407cbdd6410a44e2aa7c339ad8d51483';

class NewsService with ChangeNotifier {

  List<Article> headlines = [];

  String _selectedCategory = 'business';

  bool _isLoading = true;

  List<Category> categories = [
    Category( FontAwesomeIcons.building, 'business'),
    Category( FontAwesomeIcons.tv, 'entertainment'),
    Category( FontAwesomeIcons.addressCard, 'general'),
    Category( FontAwesomeIcons.hospital, 'health'),
    Category( FontAwesomeIcons.vials, 'science'),
    Category( FontAwesomeIcons.phone, 'technology'),
    Category( FontAwesomeIcons.basketballBall, 'sports'),
  ];

   Map<String, List<Article>?>? categoryArticles = {};

  NewsService() {

    this.geTopHeadlines();

    categories.forEach((item) { 
      this.categoryArticles![item.name] = new List<Article>.empty(growable: true);
    });

    this.getArticlesByCategory(this._selectedCategory);

  }

  bool get isLoading => this._isLoading;

  String get selectedCategory => this._selectedCategory;
  set selectedCategory( String valor ){

    this._selectedCategory = valor;

    this._isLoading = true;
    this.getArticlesByCategory( valor );
    notifyListeners();

  }

    List<Article>? get getArticulosCategoriaSeleccionada => this.categoryArticles![ this.selectedCategory ];


  geTopHeadlines() async {

    //print('cargando headlines...');
    var uri = Uri.https('newsapi.org', '/v2/top-headlines',
        {'country': 'mx', 'apiKey': _API_KEY});

    final resp = await http.get(uri); 

    final newsResponse = newsResponseFromJson(resp.body);

    this.headlines.addAll(newsResponse.articles);
    
    notifyListeners();

  }

  getArticlesByCategory( String category ) async {

    if( this.categoryArticles![category]!.length > 0)
    {
      this._isLoading = false;
      notifyListeners();
      return this.categoryArticles![category];
    }

    var uri = Uri.https('newsapi.org', '/v2/top-headlines',
        {'country': 'mx', 'category':category , 'apiKey': _API_KEY});

    final resp = await http.get(uri);

      final newsResponse = newsResponseFromJson( resp.body );

      this.categoryArticles![category]!.addAll( newsResponse.articles );

      this._isLoading = false;
      notifyListeners();

  }
}