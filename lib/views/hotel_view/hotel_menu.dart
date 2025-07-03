
import 'package:dine_ease/service/hotel_service/menu_service.dart';
import 'package:flutter/material.dart';

import '../../models/Item.dart';
import '../../models/Category.dart';


class HotelMenu extends StatefulWidget {
  const HotelMenu({super.key});

  @override
  State<HotelMenu> createState() => _HotelMenuState();
}

class _HotelMenuState extends State<HotelMenu> {
  final MenuService _service=MenuService();
  final _categoryController=TextEditingController();

  late Future<List<Category>> _categoriesFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _categoriesFuture=_service.getCategories();
  }
  void _refreshCategories(){
    setState(() {
      _categoriesFuture=_service.getCategories();
    });
  }
  void _addItemDialog(Category category) {
    List<TextEditingController> nameControllers = [TextEditingController()];
    List<TextEditingController> priceControllers = [TextEditingController()];

    void addNewField() {
      nameControllers.add(TextEditingController());
      priceControllers.add(TextEditingController());
      setState(() {});
    }

    void removeField(int index) {
      nameControllers.removeAt(index);
      priceControllers.removeAt(index);
      setState(() {});
    }
    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text("Add Multiple Items"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(nameControllers.length, (index) {
                return Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: nameControllers[index],
                        decoration: InputDecoration(labelText: "Item Name"),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: priceControllers[index],
                        decoration: InputDecoration(labelText: "Price"),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: nameControllers.length > 1
                          ? () {
                        removeField(index);
                        setState(() {});
                      }
                          : null,
                    )
                  ],
                );
              }),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                addNewField();
                setState(() {});
              },
              child: Text("Add More"),
            ),
            TextButton(
              onPressed: () async {
                List<Item> items = [];
                for (int i = 0; i < nameControllers.length; i++) {
                  final name = nameControllers[i].text.trim();
                  final price = double.tryParse(priceControllers[i].text) ?? 0.0;
                  if (name.isNotEmpty) {
                    items.add(Item(name: name, price: price));
                  }
                }
                if (items.isNotEmpty) {
                  await _service.addItems(category.id,items);
                  _refreshCategories();
                  Navigator.pop(context);
                }

              },
              child: Text("Save All"),
            )
          ],
        ),
      ),
    );
  }
  void _addCategoryDialog(){
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Add Category"),
        content: TextField(
          controller: _categoryController,
          decoration: InputDecoration(labelText: "Category Name"),
        ),
        actions: [
          TextButton(
            onPressed: () async{
               await _service.addCategory(_categoryController.text);
              _categoryController.clear();
              Navigator.pop(context);
               _refreshCategories();
            },
            child: Text("Add"),
          ),
        ],
      )
    );
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Menu Manager"),
        actions: [
          IconButton(
            onPressed: _addCategoryDialog,
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: FutureBuilder(
        future: _categoriesFuture,
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          if(snapshot.hasError){
            return Center(child: Text("Error Loading Menu"),);
          }
          final categories=snapshot.data!;
          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (_,categoryIndex){
              final category=categories[categoryIndex];
              return Card(
                margin: EdgeInsets.all(10),
                child: ExpansionTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          category.name,
                          style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete,color: Colors.red,),
                        onPressed: () async{
                          await _service.deleteCategory(category.id);
                          _refreshCategories();
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: (){
                          _addItemDialog(category);
                        },
                      )
                    ],
                  ),
                  children: category.items.map((item){
                    return ListTile(
                      title: Text(item.name),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("₹${item.price.toStringAsFixed(0)}"),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: ()async{
                               await _service.deleteItem(category.id, item.id);
                               _refreshCategories();
                            },
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          );
        },
      ),
    );
  }


}
