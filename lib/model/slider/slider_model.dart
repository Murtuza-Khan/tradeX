class SliderModel {
  int? id;
  String? name;
  String? image;
  bool? status;

  SliderModel({this.id, this.name, this.image, this.status});

  static List<SliderModel> listFromJson(List jsonList) {
    return jsonList.map((e) => SliderModel.fromJson(e)).toList();
  }

  static List<Map<String, dynamic>> listToJson(List<SliderModel> jsonList) {
    return jsonList.map((e) => e.toJson()).toList();
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'status': status,
    };
  }

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      status: json['status'] as bool?,
    );
  }
}
