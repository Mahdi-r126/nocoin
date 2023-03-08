import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:nocoin/models/CryptoModel/AllCryptoModel.dart';
import 'package:nocoin/network/apiProvider.dart';
import 'package:nocoin/network/responseModel.dart';

class CryptoDataProvider extends ChangeNotifier {
  ApiProvider apiProvider = ApiProvider();

  late AllCryptoModel dataFuture;
  late ResponseModel state;
  var response;

  getTopMarketCapData() async {
    state = ResponseModel.loading("is loading...");
    try {
      Response response = await apiProvider.getTopGainerData();

      if (response.statusCode == 200) {
        dataFuture = AllCryptoModel.fromJson(response.data);
        state = ResponseModel.completed(dataFuture);
      } else {
        state = ResponseModel.error("something is wrong...");
      }

      notifyListeners();
    } catch (e) {
      print(e);
      state = ResponseModel.error("Check your internet");
      notifyListeners();
    }
  }

  getTopGainersData() async {
    state = ResponseModel.loading("is loading...");
    try {
      Response response = await apiProvider.getTopLosersData();

      if (response.statusCode == 200) {
        dataFuture = AllCryptoModel.fromJson(response.data);
        state = ResponseModel.completed(dataFuture);
      } else {
        state = ResponseModel.error("something is wrong...");
      }

      notifyListeners();
    } catch (e) {
      print(e);
      state = ResponseModel.error("Check your internet");
      notifyListeners();
    }
  }

  getTopLoosersData() async {
    state = ResponseModel.loading("is loading...");
    try {
      Response response = await apiProvider.getAllCryptoData();

      if (response.statusCode == 200) {
        dataFuture = AllCryptoModel.fromJson(response.data);
        state = ResponseModel.completed(dataFuture);
      } else {
        state = ResponseModel.error("something is wrong...");
      }

      notifyListeners();
    } catch (e) {
      print(e);
      state = ResponseModel.error("Check your internet");
      notifyListeners();
    }
  }
}
