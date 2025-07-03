class Item{
  String name;
  double price;
  String id;
  Item({this.id="",required this.name,required this.price});

  factory Item.fromJson(Map<String,dynamic> json) => Item(
    id: json['itemId'] ?? '',
    name: json['itemName'],
    price: (json['itemPrice'] as num).toDouble(),
  );
  Map<String,dynamic> toJson()=>{
    "name":name,
    "price":price,
  };
}