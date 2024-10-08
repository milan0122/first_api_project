import "dart:convert";

import "package:flutter/material.dart";
import 'package:first_api/Models/ProductModel.dart';
import 'package:http/http.dart'as http;
class ComplexApi extends StatefulWidget {
  const ComplexApi({super.key});

  @override
  State<ComplexApi> createState() => _ComplexApiState();
}

class _ComplexApiState extends State<ComplexApi> {
  List<Product> pList =[];
  Future<Product>getProductApi() async{
   final response =  await http.get(Uri.parse('https://webhook.site/70d584a0-6f22-4b74-8f74-99d73260bd48'));
   var data = jsonDecode(response.body.toString());
   if(response.statusCode==200){
     return Product.fromJson(data);
   }
   else{
     return Product.fromJson(data);
   }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API Learning Series 5"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
                child: FutureBuilder(
                    future: getProductApi(),
                    builder: (context,snapshot){
                      if(snapshot.hasData){
                        return ListView.builder(
                            itemCount: snapshot.data!.data!.length,
                            itemBuilder: (context,index){
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    title: Text(snapshot.data!.data![index].shop!.name.toString()),

                                    subtitle: Text(snapshot.data!.data![index].shop!.shopemail!.toString()),
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(snapshot.data!.data![index].shop!.image!.toString()),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height:MediaQuery.of(context).size.height * .3,
                                      width:MediaQuery.of(context).size.width * 1,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                          itemCount:snapshot.data!.data![index].images!.length,
                                          itemBuilder:(context,position){
                                            return Container(
                                                height:MediaQuery.of(context).size.height * .25,
                                                width:MediaQuery.of(context).size.width * .5,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15),
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                      image: NetworkImage(snapshot.data!.data![index].images![position].url.toString()))
                                                ),
                                            );
                                          })
                                    ),
                                  ),
                                  Icon(snapshot.data!.data![index].inWishlist! == false ? Icons.favorite: Icons.favorite_outlined),
                                ],
                              );

                            });
                      }
                      else{
                        return Text("Loading......");
                      }

                    })
            )
          ],

        ),
      ),
    );
  }
}
