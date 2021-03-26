abstract class ApiModel {
  ApiModel();
  ApiModel.fromMap(Map<String, dynamic> map);

  dynamic get pk;

  Map<String, dynamic> toMap();
  void loadMap(Map<String, dynamic> map);

  ApiModel clone();
}
