import 'package:flutter/material.dart';
import 'package:news_app/src/services/news_services.dart';
import 'package:news_app/src/theme/tema.dart';
import 'package:news_app/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab1Screen extends StatefulWidget {

  @override
  State<Tab1Screen> createState() => _Tab1ScreenState();
}

class _Tab1ScreenState extends State<Tab1Screen> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {

    //obtener Headlines
    final headlines = Provider.of<NewsService>(context).headlines;
    

    return  Scaffold(
      body: (headlines.length == 0)
          ? Center(
            child: CircularProgressIndicator( color: myTheme.colorScheme.secondary,),
          )
          : ListaNoticias(noticias: (headlines))
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}