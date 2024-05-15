import 'package:dio/dio.dart';
import 'package:grocery_genie/models/config.dart';
import 'package:guru_provider/guru_provider/keys/state_key.dart';
import 'package:guru_provider/guru_provider/repository.dart';


final StateKey<Dio> dioKey = StateKey<Dio>(
  () => Dio(
    BaseOptions(baseUrl: Repository.instance.read(Config.key).apiUrl),
  ),
);
