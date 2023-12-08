class FoodviewModel {
  List<Data>? data;

  FoodviewModel({this.data});

  FoodviewModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? foodId;
  String? photo;
  String? foodName;
  String? category;
  String? ingredients;
  String? preparationtime;
  String? price;

  Data(
      {this.foodId,
        this.photo,
        this.foodName,
        this.category,
        this.ingredients,
        this.preparationtime,
        this.price});

  Data.fromJson(Map<String, dynamic> json) {
    foodId = json['food_id'];
    photo = json['photo'];
    foodName = json['food_name'];
    category = json['category'];
    ingredients = json['ingredients'];
    preparationtime = json['preparationtime'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['food_id'] = this.foodId;
    data['photo'] = this.photo;
    data['food_name'] = this.foodName;
    data['category'] = this.category;
    data['ingredients'] = this.ingredients;
    data['preparationtime'] = this.preparationtime;
    data['price'] = this.price;
    return data;
  }
}