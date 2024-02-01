import 'package:dartz/dartz.dart';
import 'package:innovins_assignment/core/base_class.dart';
import 'package:innovins_assignment/core/http_error.dart';
import 'package:innovins_assignment/modules/home/data/models/product_list.dart';
import 'package:innovins_assignment/modules/home/domain/repositories/home_repositories.dart';

class HomeUsecase
    extends BaseUsecase<List<ProductListModel>, HomeUsecaseParams> {
  HomeUsecase(this.homeRepository);

  final HomeRepository homeRepository;

  @override
  Future<Either<HttpError, List<ProductListModel>>> call(params) async {
    return await homeRepository.fetchProductList(params);
  }
}

class HomeUsecaseParams {
  HomeUsecaseParams({
    this.userToken,
  });

  HomeUsecaseParams.fromJson(Map<String, dynamic> json) {
    userToken = json['user_login_token'];
  }
  String? userToken;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_login_token'] = userToken;
    return data;
  }
}
