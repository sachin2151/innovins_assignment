class ProductListModel {
  String? id;
  String? name;
  String? moq;
  String? price;
  String? discountedPrice;
  bool? isCart;

  ProductListModel(
      {this.id,
      this.name,
      this.moq,
      this.price,
      this.discountedPrice,
      this.isCart = false});

  ProductListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    moq = json['moq'];
    price = json['price'];
    discountedPrice = json['discounted_price'];
    isCart = json['cart'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['moq'] = moq;
    data['price'] = price;
    data['cart'] = isCart;
    data['discounted_price'] = discountedPrice;
    return data;
  }
}
