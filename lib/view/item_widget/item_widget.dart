import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../web_view.dart';

class MovieItem extends StatelessWidget {
  const MovieItem(
      {super.key, required this.title, required this.year, required this.urltoimage,required this.movieName});
  final String title, urltoimage, year,movieName;

  @override
  Widget build(BuildContext context) {
    String name = '';
    for(int i=0;i<=title.length-1;i++){
      if(title[i] == ' '){
        name += '-';
      }else {
        name += title[i];
      }
    }
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieView(url: "https://123moviesd.com/$name/",title: movieName,)));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:45.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                urltoimage,fit: BoxFit.fitWidth,
                height: 382,
                width: 300,
              ),
            ),
          ),
          Container(
              width: 300,
              child: Center(
                child: Text(
                  title,
                  style: GoogleFonts.koHo(fontSize: 23),
                  overflow: TextOverflow.ellipsis,
                ),
              )),
          Text(
            "'$year'",
            style: GoogleFonts.euphoriaScript(fontSize: 32),
          ),
        ],
      ),
    );
  }
}
