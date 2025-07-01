import 'package:flutter/material.dart';

class HotelProfile extends StatefulWidget {
  const HotelProfile({super.key});

  @override
  State<HotelProfile> createState() => _HotelProfileState();
}

class _HotelProfileState extends State<HotelProfile> {
  bool isEditing=false;
  final _nameController=TextEditingController();
  final _emailController=TextEditingController();
  Widget buildField(String label,TextEditingController controller,bool editable){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: editable ?
              TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: label,
                  border: OutlineInputBorder(),
                ),
              )
          :
            ListTile(
              title: Text(label),
              subtitle: Text(controller.text),
              leading: Icon(Icons.person),
            )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit),
            onPressed: (){
              setState(() {
                isEditing=!isEditing;
              });
              if ( !isEditing){

              }
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 60,
                ),
              ),
              buildField("Name", _nameController, isEditing),
              buildField("Email", _emailController, isEditing),
            ],
          ),
      ),
    );
  }
}
