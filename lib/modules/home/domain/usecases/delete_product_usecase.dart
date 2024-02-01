import 'package:dartz/dartz.dart';
import 'package:innovins_assignment/core/base_class.dart';
import 'package:innovins_assignment/core/http_error.dart';
import 'package:innovins_assignment/modules/home/data/models/add_product_model.dart';
import 'package:innovins_assignment/modules/home/domain/repositories/home_repositories.dart';

class DeleteProductUsecase
    extends BaseUsecase<AddProductModel, DeleteProductUsecaseParams> {
  DeleteProductUsecase(this.homeRepository);

  final HomeRepository homeRepository;

  @override
  Future<Either<HttpError, AddProductModel>> call(params) async {
    return await homeRepository.deleteProduct(params);
  }
}

class DeleteProductUsecaseParams {
  DeleteProductUsecaseParams({this.userToken, this.id});

  DeleteProductUsecaseParams.fromJson(Map<String, dynamic> json) {
    userToken = json['user_login_token'];
    id = json['id'];
  }
  String? userToken;
  String? id;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_login_token'] = userToken;
    data['id'] = id;
    return data;
  }
}
