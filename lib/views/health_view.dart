import 'package:flutter/material.dart';

import '../service/hotel_service/health_check.dart';

class HealthView extends StatefulWidget {
  const HealthView({super.key});

  @override
  State<HealthView> createState() => _HealthViewState();
}

class _HealthViewState extends State<HealthView> {
  late Future<Health> futureHealth;
  @override
  void initState(){
    super.initState();
    futureHealth=healthCheck();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: futureHealth,
        builder: (context,snapshot){
          if(snapshot.hasData){
            return Center(child: Text(snapshot.data!.title));
          }
          else if (snapshot.hasError){
            return Center(child: Text("${snapshot.error}"));
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}

