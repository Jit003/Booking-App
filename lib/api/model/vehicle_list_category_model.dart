class VechileListCategory {
  String? vehicle;
  List<Categories>? categories;

  VechileListCategory({this.vehicle, this.categories});

  VechileListCategory.fromJson(Map<String, dynamic> json) {
    vehicle = json['vehicle'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vehicle'] = this.vehicle;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  String? category;
  String? price;
  String? description;

  Categories({this.category, this.price, this.description});

  Categories.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    price = json['price'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['price'] = this.price;
    data['description'] = this.description;
    return data;
  }
}