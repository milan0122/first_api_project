import 'dart:convert';

import "package:flutter/material.dart";
import 'package:status_alert/status_alert.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart'as http;
class SingupPage extends StatefulWidget {
  const SingupPage({super.key});

  @override
  State<SingupPage> createState() => _SingupPageState();
}

class _SingupPageState extends State<SingupPage> {
  @override
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void showSuccessAlert(BuildContext context) {
    StatusAlert.show(
      context,
      duration: Duration(seconds: 2),
      title: 'Account created successfully',
      //subtitle: 'Operation completed successfully!',
      configuration: IconConfiguration(icon: Icons.check),
    );
  }

  Future<void> Register(String email,String password) async{
    try{
      final response = await http.post(
          Uri.parse('https://reqres.in/api/register'),
          body: {
            'email':email,
            'password':password
          }
      );
      var data = jsonDecode(response.body.toString());
      if(response.statusCode==200){
        print("account created successfully");
        showSuccessAlert(context);
      }
      else{
        print('failed');
      }
    }
    catch(e)
    {
      print(e.toString());
    }

    
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Title(color: Colors.black, child:Text("Signup Page")),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
       // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Email",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12)
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12)
                )
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: "Password",
                focusedBorder:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:BorderSide(color: Colors.black)
                ),
                  enabledBorder:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:BorderSide(color: Colors.black)
                  )
              ),

            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            width: 300,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.blueAccent
            ),
            child: InkWell(
              onTap: (){
                Register(emailController.text.toString(),passwordController.text.toString());
              },
              child: Center(child: Text('Sing Up',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),)),
            ),
          )

        ],
      ),
    );
  }
}
