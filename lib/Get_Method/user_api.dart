import 'dart:convert';
import 'package:first_api/Models/UserModel.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart'as http;
class UserApi extends StatefulWidget {
  const UserApi({super.key});

  @override
  State<UserApi> createState() => _UserApiState();
}

class _UserApiState extends State<UserApi> {
  @override
  List<UserModel> userList = [];
  Future<List<UserModel>> getUserApi() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var userData = jsonDecode(response.body.toString());

    if(response.statusCode==200){
      for (Map i in userData){
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    }
    else{
      return userList;
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Learning Series3'),
      ),
      body: Column(
        children: [
          FutureBuilder(future: getUserApi(),
              builder: (context,snapshot){
                  if(!snapshot.hasData){
                    return Center(child: CircularProgressIndicator(
                      strokeAlign: BorderSide.strokeAlignCenter,
                      strokeWidth: 4.0,
                    ));
                  }
                  else{
                    return Expanded(
                      child: ListView.builder(
                        itemCount: 5,
                          itemBuilder:(context,index){
                          return Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  //mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: CircleAvatar(
                                          radius:40,
                                          child:Icon(Icons.person)
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Text(userList[index].username.toString()),
                                    Text(userList[index].email.toString())
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Text("Personal Information",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                                Divider(),
                                ReusbaleRow(title: 'Name', value:userList[index].name.toString() ),
                                ReusbaleRow(title: 'Email', value:userList[index].email.toString() ),
                                ReusbaleRow(title: 'Contact', value:userList[index].address!.city.toString() ),
                                ReusbaleRow(title: 'Address', value:userList[index].phone.toString() )



                              ],
                            ),
                          );
                          } ),
                    );
                  }

              })
        ],
        
      ),
    );
  }
}
class ReusbaleRow extends StatelessWidget {
  String title , value;
  ReusbaleRow({required this.title, required this.value,super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Center(child: Text(value))
        ],
      ),
    );
  }
}



