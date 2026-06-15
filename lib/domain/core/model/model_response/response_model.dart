class ResponseModel<T extends Serializable> {
  int? code;
  String? status;
  T? data;

  ResponseModel({
    this.code,
    this.status,
    this.data,
  });

  ResponseModel.fromJson(
      Map<String, dynamic> json, Function(Map<String, dynamic>) create) {
    code = json['code'];
    status ??= json['status'];
    if (json['data'] != null) {
      data = create(json['data']);
    }
  }

  ResponseModel.ignoreDataFromJson(Map<String, dynamic> json) {
    code = json['code'];
    status ??= json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['code'] = code;
    json['status'] = status;
    json['data'] = data?.toJson();
    return json;
  }
}

class ListResponseModel<T extends Serializable> {
  int? code;
  String? status;
  List<T>? data;

  ListResponseModel({
    this.code,
    this.status,
    this.data,
  });

  ListResponseModel.fromJson(
      Map<String, dynamic> json, Function(List<dynamic>) build) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = build(json['data']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['code'] = code;
    json['status'] = status;
    json['data'] = data?.toList();
    return json;
  }
}

abstract class Serializable {
  Map<String, dynamic> toJson();
}
