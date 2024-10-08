import "dart:convert";
import 'package:first_api/Get_Method/user_api.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart'as http;
class UserApi2 extends StatefulWidget {
  const UserApi2({super.key});

  @override
  State<UserApi2> createState() => _UserApi2State();
}

class _UserApi2State extends State<UserApi2> {
  @override
  var data;
  Future<void>getUserApi2() async{
   final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
   if (response.statusCode == 200){
     data = jsonDecode(response.body.toString());
   }

  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Learning Series4'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: getUserApi2(),
                  builder: (context,snapshot){
                    if(snapshot.connectionState==ConnectionState.waiting){
                      return Text("Loading....");
                    }
                    else{
                      return ListView.builder(
                        itemCount: data.length,
                          itemBuilder: (context,index){
                          return Card(
                            child: Column(
                              children: [
                                ReusbaleRow(title: 'Name', value: data[index]['name'].toString()),
                                ReusbaleRow(title: 'Address', value: data[index]['address']['city'].toString()),
                                ReusbaleRow(title: 'Email', value: data[index]['email'].toString()),
                                ReusbaleRow(title: 'location', value: data[index]['address']['geo']['lat'].toString())


                              ],
                            ),
                          );
                          } );
                    }
                  }))
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



