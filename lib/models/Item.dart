class Item{
  String name;
  double itemPrice;
  String id;
  Item({this.id="",required this.name,required this.itemPrice});

  factory Item.fromJson(Map<String,dynamic> json) => Item(
    id: json['itemId'] ?? '',
    name: json['itemName'],
    itemPrice: (json['itemPrice'] as num).toDouble(),
  );
  Map<String,dynamic> toJson()=>{
    "itemName":name,
    "itemPrice":itemPrice,
  };
  // @override
  // bool operator ==(Object other) =>
  //     identical(this, other) ||
  //         other is Item &&
  //             runtimeType == other.runtimeType &&
  //             id == other.id;
  //
  // @override
  // int get hashCode => id.hashCode;
}