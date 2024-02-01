import 'package:dartz/dartz.dart';
import 'package:innovins_assignment/core/base_class.dart';
import 'package:innovins_assignment/core/http_error.dart';
import 'package:innovins_assignment/modules/home/data/models/add_product_model.dart';
import 'package:innovins_assignment/modules/home/domain/repositories/home_repositories.dart';

class EditProductUsecase
    extends BaseUsecase<AddProductModel, EditProductUsecaseParams> {
  EditProductUsecase(this.homeRepository);

  final HomeRepository homeRepository;

  @override
  Future<Either<HttpError, AddProductModel>> call(params) async {
    return await homeRepository.editProduct(params);
  }
}

class EditProductUsecaseParams {
  EditProductUsecaseParams(
      {this.userToken,
      this.name,
      this.moq,
      this.price,
      this.discountedPrice,
      this.id});

  EditProductUsecaseParams.fromJson(Map<String, dynamic> json) {
    userToken = json['user_login_token'];
    name = json['name'];
    moq = json['moq'];
    price = json['price'];
    discountedPrice = json['discounted_price'];
    id = json['id'];
  }
  String? userToken;
  String? name;
  String? moq;
  String? price;
  String? discountedPrice;
  String? id;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_login_token'] = userToken;
    data['name'] = name;
    data['moq'] = moq;
    data['price'] = price;
    data['discounted_price'] = discountedPrice;
    data['id'] = id;
    return data;
  }
}
