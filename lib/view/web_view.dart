import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MovieView extends StatefulWidget {
  MovieView({super.key, required this.url,required this.title});
  final String url,title;

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  late WebViewController webController;

  @override
  void initState(){
    super.initState();
    webController = WebViewController()..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  "${widget.title}",
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
      ),
      body: WebViewWidget(
        controller: webController,

      ),
    );
  }
}
