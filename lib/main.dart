import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}
// String ?stringResponse;
Map ?mapResponse;
Map ?dataResponse;
List ?listResponse;


class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  Future callapi()async{
    http.Response response;
    response = await http.get(Uri.parse("https://reqres.in/api/users"));
    if(response.statusCode == 200){
      setState(() {
        // stringResponse = response.body;
        mapResponse = json.decode(response.body);
        listResponse = mapResponse?['data'];
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callapi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemBuilder: (context,index){
        return Container(
          child: Column(
            children: [
              Text(listResponse![index]['id'].toString()),
              Text(listResponse![index]['email'].toString()),
              Text(listResponse![index]['first_name'].toString()),
              Text(listResponse![index]['last_name'].toString()),
              Image.network((listResponse![index]['avatar']))

            ],
          ),
        );
      },
        itemCount: listResponse == null? 0: listResponse?.length,
      ),
    );
  }
}