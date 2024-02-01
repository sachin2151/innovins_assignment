import 'package:dartz/dartz.dart';
import 'package:innovins_assignment/core/http_error.dart';
import 'package:innovins_assignment/modules/home/data/models/add_product_model.dart';
import 'package:innovins_assignment/modules/home/data/models/product_list.dart';
import 'package:innovins_assignment/modules/home/domain/usecases/add_product_usecase.dart';
import 'package:innovins_assignment/modules/home/domain/usecases/delete_product_usecase.dart';
import 'package:innovins_assignment/modules/home/domain/usecases/edit_prodcut_usecase.dart';
import 'package:innovins_assignment/modules/home/domain/usecases/home_usecases.dart';

abstract class HomeRepository {
  Future<Either<HttpError, List<ProductListModel>>> fetchProductList(
    HomeUsecaseParams params,
  );

  Future<Either<HttpError, AddProductModel>> addProduct(
    AddProductUsecaseParams params,
  );

  Future<Either<HttpError, AddProductModel>> editProduct(
    EditProductUsecaseParams params,
  );

  Future<Either<HttpError, AddProductModel>> deleteProduct(
    DeleteProductUsecaseParams params,
  );
}
