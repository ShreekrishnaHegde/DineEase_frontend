class CustomerProfileModel{
  final String email;
  String fullname;
  String? customerId;
  CustomerProfileModel({
    required this.email,
    required this.fullname,
    this.customerId,
  });
  factory CustomerProfileModel.fromJson(Map<String, dynamic> json) {
    return CustomerProfileModel(
      email: json['email'],
      fullname: json['fullname'],
      customerId: json['hotelId']??'',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'fullname': fullname,
    };
  }
}