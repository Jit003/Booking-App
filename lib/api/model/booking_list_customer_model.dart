class BookingModel {
  int? status;
  List<bookingModel>? data;
  String? message;

  BookingModel({this.status, this.data, this.message});

  BookingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <bookingModel>[];
      json['data'].forEach((v) {
        data!.add(new bookingModel.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class bookingModel {
  int? id;
  Null? clientsId;
  int? customerId;
  String? vehicleVariants;
  String? vehicleType;
  String? date;
  String? time;
  String? customerName;
  String? phone;
  String? address;
  String? pendingAmount;
  String? fullAmount;
  String? advanceAmount;
  String? reciveAmount;
  String? programDescription;
  String? invoice;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? invoiceDate;
  Null? vehicalType;
  String? startingPlace;
  String? endingPlace;
  String? startTime;
  String? endTime;

  bookingModel(
      {this.id,
        this.clientsId,
        this.customerId,
        this.vehicleVariants,
        this.vehicleType,
        this.date,
        this.time,
        this.customerName,
        this.phone,
        this.address,
        this.pendingAmount,
        this.fullAmount,
        this.advanceAmount,
        this.reciveAmount,
        this.programDescription,
        this.invoice,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.invoiceDate,
        this.vehicalType,
        this.startingPlace,
        this.endingPlace,
        this.startTime,
        this.endTime});

  bookingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientsId = json['clients_id'];
    customerId = json['customer_id'];
    vehicleVariants = json['vehicle_variants'];
    vehicleType = json['vehicle_type'];
    date = json['date'];
    time = json['time'];
    customerName = json['customer_name'];
    phone = json['phone'];
    address = json['address'];
    pendingAmount = json['pending_amount'];
    fullAmount = json['full_amount'];
    advanceAmount = json['advance_amount'];
    reciveAmount = json['recive_amount'];
    programDescription = json['program_description'];
    invoice = json['invoice'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    invoiceDate = json['invoice_date'];
    vehicalType = json['vehical_type'];
    startingPlace = json['starting_place'];
    endingPlace = json['ending_place'];
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['clients_id'] = this.clientsId;
    data['customer_id'] = this.customerId;
    data['vehicle_variants'] = this.vehicleVariants;
    data['vehicle_type'] = this.vehicleType;
    data['date'] = this.date;
    data['time'] = this.time;
    data['customer_name'] = this.customerName;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['pending_amount'] = this.pendingAmount;
    data['full_amount'] = this.fullAmount;
    data['advance_amount'] = this.advanceAmount;
    data['recive_amount'] = this.reciveAmount;
    data['program_description'] = this.programDescription;
    data['invoice'] = this.invoice;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['invoice_date'] = this.invoiceDate;
    data['vehical_type'] = this.vehicalType;
    data['starting_place'] = this.startingPlace;
    data['ending_place'] = this.endingPlace;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    return data;
  }
}