import 'package:flutter/material.dart';
import 'package:news_app/src/models/news_models.dart';
import 'package:news_app/src/theme/tema.dart';

class ListaNoticias extends StatelessWidget {

  final List<Article> noticias;

  const ListaNoticias({Key? key,required this.noticias}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: this.noticias.length,
        itemBuilder: (BuildContext context, int index){
          return _Noticia(noticia: this.noticias[index], index: index);
        },
     );
  }
}

class _Noticia extends StatelessWidget {
  
  final Article noticia;
  final int index;

  const _Noticia({Key? key, required this.noticia, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 15),

        _TarjetaTopBar(noticia: noticia, index: index,),
        _TarjetaTitulo(noticia: noticia),
        _TarjetaImagen(noticia: noticia),
        _TarjetaBody(noticia: noticia),
        _TarjetaBotones(),

        SizedBox(height: 15),
        Divider()
      ],
    );
  }
}

class _TarjetaBotones extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        RawMaterialButton(
          onPressed: (){},
          fillColor: myTheme.colorScheme.secondary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)) ,
          child: Icon(Icons.star),
          ),

          RawMaterialButton(
          onPressed: (){},
          fillColor: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)) ,
          child: Icon(Icons.more),
          ),
        ]
      ),
    );
  }
}

class _TarjetaBody extends StatelessWidget {
  
  final Article noticia;

  const _TarjetaBody({Key? key, required this.noticia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: (noticia.description !=null)
        ? Text('${noticia.description}', textAlign: TextAlign.justify ,)
        : Text('')
      ),
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {

  final Article noticia;
  final int index;

  const _TarjetaTopBar({Key? key,required this.noticia, required this.index}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text('${ index + 1}.', style: TextStyle(color: myTheme.colorScheme.secondary ) ,),
          Text('${noticia.source.name}.'),

        ],
      ),

    );
  }
}

class _TarjetaTitulo extends StatelessWidget {

  final Article noticia;


  const _TarjetaTitulo({Key? key,required this.noticia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(noticia.title, style: TextStyle(fontSize: 20, fontWeight:FontWeight.w700 ),),
    );
  }
}

class _TarjetaImagen extends StatelessWidget {
  
  final Article noticia;

  const _TarjetaImagen({Key? key, required this.noticia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(50), bottomRight: Radius.circular(50) ),
          child: Container(
            child: (noticia.urlToImage !=null) 
            ? FadeInImage(
              placeholder: AssetImage('assets/giphy.gif'),
              image: NetworkImage('${noticia.urlToImage}'),
              fit: BoxFit.cover,
            )
            : Image(image: AssetImage('assets/no-image.png'))
          ),
        ),
      ),
    );
  }
}