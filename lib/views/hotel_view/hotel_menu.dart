
import 'package:dine_ease/service/hotel_service/menu_service.dart';
import 'package:flutter/material.dart';

import '../../models/Item.dart';
import '../Widgets/category_card.dart';

class HotelMenu extends StatefulWidget {
  const HotelMenu({super.key});

  @override
  State<HotelMenu> createState() => _HotelMenuState();
}

class _HotelMenuState extends State<HotelMenu> {
  final MenuService _service=MenuService();

  final _categoryController=TextEditingController();
  final _itemNameController=TextEditingController();
  final _itemPriceController=TextEditingController();

  void _addItemDialog(int categoryIndex) {
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
              onPressed: () {
                for (int i = 0; i < nameControllers.length; i++) {
                  final name = nameControllers[i].text.trim();
                  final price = double.tryParse(priceControllers[i].text) ?? 0.0;
                  if (name.isNotEmpty) {
                    _service.addItem(categoryIndex, Item(name: name, price: price));
                  }
                }
                setState(() {});
                Navigator.pop(context);
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
            onPressed: (){
              _service.addCategory(_categoryController.text);
              _categoryController.clear();
              setState(() {

              });
              Navigator.pop(context);
            },
            child: Text("Add"),
          ),
        ],
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    final categories=MenuService().getCategories();
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
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (_,catIndex){
          final category=categories[catIndex];
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
                    onPressed: (){
                      _service.deleteCategory(catIndex);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: (){
                      _addItemDialog(catIndex);
                    },
                  )
                ],
              ),
              children: category.items.asMap().entries.map((entry){
                final itemIndex=entry.key;
                final item=entry.value;
                return ListTile(
                  title: Text(item.name),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("₹${item.price.toStringAsFixed(0)}"),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: (){
                          _service.deleteItem(catIndex, itemIndex);
                          setState(() {
                          });
                        },
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }


}
