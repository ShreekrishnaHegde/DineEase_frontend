import 'dart:convert';

import 'package:http/http.dart' as http;

class Health{
  final String title;
  const Health({required this.title});
  factory Health.fromJson(Map<String,dynamic> json){

    return switch (json){
      {'title': String title} => Health(title: title),
    _=> throw const FormatException("Failed to load the message")
    };
  }
}

Future<Health> healthCheck() async{
  final response= await http.get(Uri.parse('https://dineeasebackend-production.up.railway.app/health-check'));
  print("Raw JSON responses: ${response.body}");
  if(response.statusCode==200){
    return Health.fromJson(jsonDecode(response.body) as Map<String,dynamic>);
  }
  else{
    throw Exception("Failed");
  }
}
