class ApplianceModel {
  Space? space;

  ApplianceModel({this.space});

  ApplianceModel.fromJson(Map<String, dynamic> json) {
    space = json['space'] != null ? Space.fromJson(json['space']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (space != null) {
      data['space'] = space!.toJson();
    }
    return data;
  }
}

class Space {
  List<Appliances>? appliances;
  String? sId;
  String? type;
  String? spaceOwner;

  Space({this.appliances, this.sId, this.type, this.spaceOwner});

  Space.fromJson(Map<String, dynamic> json) {
    if (json['appliances'] != null) {
      appliances = <Appliances>[];
      json['appliances'].forEach((v) {
        appliances!.add(Appliances.fromJson(v));
      });
    }
    sId = json['_id'];
    type = json['type'];
    spaceOwner = json['spaceOwner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (appliances != null) {
      data['appliances'] = appliances!.map((v) => v.toJson()).toList();
    }
    data['_id'] = sId;
    data['type'] = type;
    data['spaceOwner'] = spaceOwner;
    return data;
  }
}

class Appliances {
  String? applianceName;
  String? rating;
  String? sId;
  String? quantity;

  Appliances({this.applianceName, this.rating, this.sId});

  Appliances.fromJson(Map<String, dynamic> json) {
    applianceName = json['applianceName'];
    rating = json['rating'];
    quantity = json['quantity'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['applianceName'] = applianceName;
    data['rating'] = rating;
    data['quantity'] = quantity;
    data['_id'] = sId;
    return data;
  }
}
