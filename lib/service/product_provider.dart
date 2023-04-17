import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/product_model.dart';

class ProductApiClient {
  final dio = Dio();
  final String domain = 'api.appworks-school.tw';
  final String apiVersion = '1.0';

  Future<ProductData> getWomen() async {
    Response response;
    response = await dio.get('https://$domain/api/$apiVersion/products/women');
    ProductData productData = ProductData.fromJson(response.data);
    return productData;
  }
}

class ProductRepository {
  final ProductApiClient _productApiClient;

  ProductRepository({ProductApiClient? productApiClient})
      : _productApiClient = productApiClient ?? ProductApiClient();

  Future<ProductData> getWomen() async {
    final women = await _productApiClient.getWomen();
    return women;
  }
}

abstract class ProductEvent {}

class ProductGetEvent extends ProductEvent {}

abstract class ProductEventState {}

class ProductEventInitial extends ProductEventState {}

class ProductEventLoading extends ProductEventState {}

class ProductEventSuccess extends ProductEventState {
  final ProductData data;
  ProductEventSuccess(this.data);
}

class ProductEventFailure extends ProductEventState {}

class ProductBloc extends Bloc<ProductEvent, ProductEventState> {
  ProductBloc(ProductRepository productRepository) : super(ProductEventInitial()) {
    on<ProductGetEvent>((event, emit) async {
      emit(ProductEventLoading());
      ProductData productData = await productRepository.getWomen();
      emit(ProductEventSuccess(productData));
    });
  }
}
