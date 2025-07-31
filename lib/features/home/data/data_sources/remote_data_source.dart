import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tamasha_assignment/core/constants/constants.dart';
import 'package:tamasha_assignment/core/errors/exceptions.dart';
import 'package:tamasha_assignment/features/home/data/model/country_model.dart';

abstract interface class RemoteDataSource {
  Future<List<CountryModel>> getRemoteData();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  @override
  Future<List<CountryModel>> getRemoteData() async {
    try {
      final response = await http.get(Uri.parse(URL));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
        return jsonData.map<CountryModel>((json) => CountryModel.fromJson(json)).toList();
      } else {
        throw ServerException("Failed to Load Data");
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
