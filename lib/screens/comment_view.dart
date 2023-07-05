import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Comments extends StatefulWidget {
  final String? id;
  const Comments({Key? key ,required this.id}) : super(key: key);

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  List<dynamic> comments = [];
  @override
  void initState() {
    super.initState();
    fetchComments();
  }

  Future<void> fetchComments() async {
    final url = Uri.parse('https://ethiotours.000webhostapp.com/comments.php?id=${widget.id}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        comments = jsonDecode(response.body);
      });
    } else {
      // Handle any errors
      print('Failed to fetch comments');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('#093A3E'),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Comments'),
      ),
      body: ListView.builder(
        itemCount: comments.length,
        itemBuilder: (BuildContext context, int index){
          return Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: Text('${comments[index]['comment']}'),
                  subtitle: Text('commented by: ${comments[index]['name']}'),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
