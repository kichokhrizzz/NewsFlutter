

import 'package:flutter/material.dart';
import 'package:news_app/src/models/category_model.dart';
import 'package:news_app/src/services/news_services.dart';
import 'package:news_app/src/theme/tema.dart';
import 'package:news_app/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _ListaCategorias(),
            
            Expanded(
              child: ListaNoticias(noticias: newsService.getArticulosCategoriaSeleccionada!,)
            )

          ],
        ),
      ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final categories = Provider.of<NewsService>(context).categories;

    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length ,
        itemBuilder: (BuildContext context, int index){

          final cName = categories[index].name;

          return Container(
            width: 110,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  _CategoryButton(categoria: categories[index]),
                  SizedBox(height: 5),
                  Text( '${cName[0].toUpperCase()}${cName.substring(1)}' )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  
  final Category categoria;

  const _CategoryButton({Key? key, required this.categoria}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);


    return GestureDetector(
      onTap: (){
        newsService.selectedCategory =  categoria.name;
       },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white
        ),
        child: Icon(
          categoria.icon,
          color:(newsService.selectedCategory == this.categoria.name) 
          ? myTheme.colorScheme.secondary
          : Colors.black54
        ),
      ),
    );
  }
}