class HotelProfileModel{
  final String email;
  String? hotelName;
  String fullname;
  String? address;

  HotelProfileModel({
    required this.email,
    required this.hotelName,
    required this.fullname,
    required this.address,

  });
  factory HotelProfileModel.fromJson(Map<String, dynamic> json) {
    return HotelProfileModel(

      email: json['email'],
      hotelName: json['hotelName']??'',
      fullname: json['fullname'],
      address: json['address']??'',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'hotelName': hotelName,
      'fullname': fullname,
      'address': address,
    };
  }
}