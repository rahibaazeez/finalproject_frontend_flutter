class Orderviewmodelclass {
  List<Data>? data;

  Orderviewmodelclass({this.data});

  Orderviewmodelclass.fromJson(Map<String, dynamic> json) {
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
  String? foodName;
  String? price;
  String? photo;
  String? orderDate;
  String? orderId;

  Data({this.foodName, this.price, this.photo, this.orderDate, this.orderId});

  Data.fromJson(Map<String, dynamic> json) {
    foodName = json['food_name'];
    price = json['price'];
    photo = json['photo'];
    orderDate = json['order_date'];
    orderId = json['order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['food_name'] = this.foodName;
    data['price'] = this.price;
    data['photo'] = this.photo;
    data['order_date'] = this.orderDate;
    data['order_id'] = this.orderId;
    return data;
  }
}
