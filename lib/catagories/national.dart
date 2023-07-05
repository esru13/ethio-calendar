import 'dart:convert';

import 'package:ethio_calend/Screens/comment_view.dart';
import 'package:ethio_calend/model/json_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:ethio_calend/screens/map_screen.dart';
import 'package:easy_localization/easy_localization.dart';



Future<List<Description>> ReadJsonData() async {
  final jsondata = await rootBundle.loadString('json/place.json');
  final list = json.decode(jsondata) as List<dynamic>;
  return list.map((e) => Description.fromJson(e)).toList();
}

class National extends StatefulWidget {
  const National({Key? key}) : super(key: key);

  @override
  State<National> createState() => _NationalState();
}

class _NationalState extends State<National> {
  final TextEditingController commentController = TextEditingController();
  Future<void> postComment(String id, String comment) async {
    final url = Uri.parse('https://ethiotours.000webhostapp.com/comments.php');
    final request = http.MultipartRequest('POST', url);
    request.fields.addAll({
      'id': id,
      'comment': comment,
      'name': 'Someone',
    });
    final response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      // Comment posted successfully
      print('Comment posted successfully');
      // Clear the comment text field
      commentController.clear();
      // Fetch and refresh the comments
      // You can call the fetchComments() method here or use any other approach to update the comments list
    } else {
      // Handle any errors
      print('Failed to post comment');
      commentController.clear();
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    commentController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#093A3E'),
      body: FutureBuilder(
        future: ReadJsonData(),
        builder: (context, data) {
          if (data.hasError) {
            return Center(child: Text('${data.error}'));
          }
          else if (data.hasData) {
            var items = data.data as List<Description>;
            return ListView.builder(
              itemCount: items == null ? 0 : items.length,
              itemBuilder: (context, index) {
                return (items[index].category.toString() == 'Wildlife and National Parks')?
                Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(items[index].name.toString()),
                        trailing: IconButton(
                          onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                              return Map(name:items[index].name?.toString() ,longitude: items[index].longitude?.toDouble(), latitude:items[index].latitude.toDouble());
                            }));

                          },
                          icon: Icon(Icons.location_on),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(items[index].description.toString(),
                          style: TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),
                      ),

                      Image.asset('assets/images/${items[index].image.toString()}'),
                      Row(
                        children: [
                          Flexible(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: TextField(
                                maxLines: 1,
                                controller: commentController,
                                decoration: InputDecoration(
                                  hintText: 'write comment'.tr(),
                                  hintStyle: TextStyle(color: Colors.grey),
                                  contentPadding: EdgeInsets.all(10),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: HexColor('#6FC9C4'),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:HexColor('#093A3E'),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: ElevatedButton(
                              onPressed: () {
                                String comment = commentController.text;
                                if (comment.isNotEmpty) {
                                  postComment(items[index].id.toString(),comment);
                                }
                              },
                              child: Text('Post'.tr()),
                              style: ElevatedButton.styleFrom(
                                primary: HexColor('#093A3E'),
                              ),
                            ),
                          ),
                        ],
                      ),

                      Padding(
                        padding: EdgeInsets.fromLTRB(0,0,240,10),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => Comments(id:items[index].id.toString()),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  return SlideTransition(
                                    position: Tween<Offset>(
                                      begin: Offset(1.0, 0.0), // Start the new page from the right side
                                      end: Offset.zero,
                                    ).animate(animation),
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          child: Text('view comments'.tr(),
                            style: TextStyle(
                                color: HexColor('#093A3E'),
                                decoration: TextDecoration.underline
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
                    :Container(child: null,);
              },
            );
          }
          else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
