import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../http_helper.dart';
import '../model/movie_model.dart';
import 'item_widget/item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var titleController = TextEditingController();
  bool loading = true;
  bool isSearch = false;
  String movieName = "batman";
  List<MovieModel> items = [];

  getMovies(movieName) async {
    HttpHelper newItem = new HttpHelper();
    await newItem.getData(movieName);
    items = newItem.movieData;

    setState(() {
      loading = false;
    });
  }

  initState() {
    getMovies(movieName );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:isSearch?Container(child: TextFormField(
          autofocus: true,
          controller: titleController,
          onFieldSubmitted: (e){
            setState(() {
              loading = true;
              this.movieName =  titleController.text;
              getMovies(movieName);
              isSearch = false;
            });
            titleController.text = "";
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.search,
            ),
            hintText: "Search",
          ),
        ),

        ) : Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  "$movieName",
                  style: GoogleFonts.germaniaOne(fontSize: 35, color: Colors.red,),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                " Movies",
                style: GoogleFonts.baskervville(fontSize: 28, color: Colors.blue),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isSearch = true;
                });
              },
              icon: Icon(
                Icons.search,
                size: 30,
              ))
        ],
      ),
      body: loading ? Center(child: CircularProgressIndicator()) : ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => MovieItem(
          title: items[index].title,
          urltoimage: items[index].urlToImage,
          year: items[index].year,
          movieName :movieName,
        ),
        separatorBuilder: (context, index) => SizedBox(width: 30),
        itemCount: items.length,
        physics: BouncingScrollPhysics(),
      ),
    );
  }
}
