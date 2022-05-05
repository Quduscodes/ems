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
  String? dateAdded;
  String? location;

  Space({this.appliances, this.sId, this.type, this.spaceOwner, required this.dateAdded, required this.location});

  Space.fromJson(Map<String, dynamic> json) {
    if (json['appliances'] != null) {
      appliances = <Appliances>[];
      json['appliances'].forEach((v) {
        appliances!.add(Appliances.fromJson(v));
      });
    }
    sId = json['_id'];
    dateAdded = json['dateAdded'];
    type = json['type'];
    spaceOwner = json['spaceOwner'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (appliances != null) {
      data['appliances'] = appliances!.map((v) => v.toJson()).toList();
    }
    data['_id'] = sId;
    data['location'] = location;
    data['dateAdded'] = dateAdded;
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
