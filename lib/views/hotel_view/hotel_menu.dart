
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: const Text(
            "Add Items",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: List.generate(nameControllers.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: nameControllers[index],
                          decoration: InputDecoration(
                              labelText: "Item Name",
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: priceControllers[index],
                          decoration: InputDecoration(
                              labelText: "Price",
                          ),
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
                  ),
                );
              }),
            ),
          ),
          actions: [
            TextButton.icon(
              onPressed: () {
                addNewField();
                setState(() {});
              },
              icon: const Icon(Icons.add),
              label: Text("Add More"),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                List<Item> items = [];
                for (int i = 0; i < nameControllers.length; i++) {
                  final name = nameControllers[i].text.trim();
                  final price = double.tryParse(priceControllers[i].text) ?? 0.0;
                  if (name.isNotEmpty) {
                    items.add(Item(name: name, itemPrice: price));
                  }
                }
                if (items.isNotEmpty) {
                  await _service.addItems(category.id,items);
                  _refreshCategories();
                  Navigator.pop(context);
                }

              },
              icon: const Icon(Icons.save,color: Colors.white,),
              label: const Text("Save All",style: TextStyle(color: Colors.white),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(
          "Add Category",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
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
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
            ),
            child: Text(
                "Add",
                style: TextStyle(
                  color: Colors.white,
                ),
            ),
          ),
        ],
      )
    );
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xfff8f8f8),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        title: Text("Menu Manager",style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),),
        automaticallyImplyLeading: true,
      ),
      body: FutureBuilder(
        future: _categoriesFuture,
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          if(snapshot.hasError){
            return Center(child: Text(
                "Error Loading Menu",
                style: TextStyle(fontSize: 16, color: Colors.red),
            ),);
          }
          final categories=snapshot.data!;
          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (_,categoryIndex){
              final category=categories[categoryIndex];
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                margin: EdgeInsets.all(10),
                child: Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    title: Text(
                      category.name,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    trailing: Wrap(
                      spacing: 8,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete, color: Color(0xFFE53935)),
                          tooltip: "Delete Category",
                          onPressed: () async {
                            await _service.deleteCategory(category.id);
                            _refreshCategories();
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.add, color: Color(0xFF4CAF50)),
                          tooltip: "Add Item",
                          onPressed: () => _addItemDialog(category),
                        ),
                      ],
                    ),
                    children: category.items.map((item){
                      return ListTile(
                        title: Text(item.name),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "₹${item.itemPrice.toStringAsFixed(0)}",
                              style: const TextStyle(fontWeight: FontWeight.w500),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              tooltip: "Delete Item",
                              onPressed: () async {
                                await _service.deleteItem(category.id, item.id);
                                _refreshCategories();
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
          onPressed: _addCategoryDialog,
          child: Icon(Icons.add),
      ),
    );
  }


}
