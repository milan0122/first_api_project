import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class PhotosApi extends StatefulWidget {
  const PhotosApi({super.key});

  @override
  State<PhotosApi> createState() => _PhotosApiState();
}

class _PhotosApiState extends State<PhotosApi> {
  @override
  List<Photos> photoList = [];
  Future<List<Photos>> getPhotos() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode==200){
      for (Map i in data){
      Photos photos = Photos(title: i['title'], url: i['url'],id: i['id'],thumbnailUrl: i['thumbnailUrl']);
      photoList.add(photos);

      }
      return photoList;
    }
    else{
      return photoList;
    }
}
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Learning API with Custom Model"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body:Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPhotos(),
                builder: (context, snapshot){
                  return ListView.builder(
                    itemCount: photoList.length,
                      itemBuilder: (context,index){
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(photoList[index].url.toString()),
                      ),
                      title: Text("Id: " + photoList[index].id.toString()),
                      subtitle: Text("Notes: " + photoList[index].title.toString()),
                      // trailing: CircleAvatar(
                      //   backgroundImage: NetworkImage(photoList[index].url.toString()),
                      // ),

                    );

                  });
                }),
          )

        ],
      )
    );
  }
}
class Photos{
  String title, url,thumbnailUrl;
  int id;
  Photos({required this.title,required this.url,required this.id, required this.thumbnailUrl});

}
