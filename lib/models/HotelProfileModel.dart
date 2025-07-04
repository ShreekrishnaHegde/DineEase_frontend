class HotelProfileModel{
  final String email;
  String? hotelName;
  String fullname;
  String? address;
  String? hotelId;
  HotelProfileModel({
    required this.email,
    required this.hotelName,
    required this.fullname,
    required this.address,
    this.hotelId,
  });
  factory HotelProfileModel.fromJson(Map<String, dynamic> json) {
    return HotelProfileModel(

      email: json['email'],
      hotelName: json['hotelName']??'',
      fullname: json['fullname'],
      address: json['address']??'',
      hotelId: json['hotelId']??'',
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