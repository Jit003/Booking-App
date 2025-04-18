class BookingModel {
  final int id;
  final String customerName;
  final String phone;
  final String address;
  final String date;
  final String time;
  final String programDescription;
  final String invoice;
  final String vehicleType;
  final String vehicleVariants;
  final String startingPlace;
  final String endingPlace;
  final String startTime;
  final String endTime;

  BookingModel({
    required this.id,
    required this.customerName,
    required this.phone,
    required this.address,
    required this.date,
    required this.time,
    required this.programDescription,
    required this.invoice,
    required this.vehicleType,
    required this.vehicleVariants,
    required this.startingPlace,
    required this.endingPlace,
    required this.startTime,
    required this.endTime,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      customerName: json['customer_name'],
      phone: json['phone'],
      address: json['address'],
      date: json['date'],
      time: json['time'],
      programDescription: json['program_description'],
      invoice: json['invoice'],
      vehicleType: json['vehicle_type'],
      vehicleVariants: json['vehicle_variants'],
      startingPlace: json['starting_place'],
      endingPlace: json['ending_place'],
      startTime: json['start_time'],
      endTime: json['end_time'],
    );
  }
}
