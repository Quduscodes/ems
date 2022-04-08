class SpaceData {
  String? sId;
  String? noOfBulb;
  String? noOfFridge;
  String? noOfFan;
  String? noOfAc;
  String? spaceOwner;
  String? type;
  String? noOfTelevision;

  SpaceData(
      {this.noOfBulb,
      this.noOfFridge,
      this.noOfFan,
      this.noOfAc,
      this.type,
      this.sId,
      this.spaceOwner});

  SpaceData.fromJson(Map<String, dynamic> json) {
    noOfBulb = json['noOfBulb'];
    noOfFridge = json['noOfFridge'];
    noOfFan = json['noOfFan'];
    noOfAc = json['noOfAc'];
    spaceOwner = json['spaceOwner'];
    type = json['type'];
    noOfTelevision = json['noOfTelevision'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['noOfBulb'] = noOfBulb;
    data['noOfFridge'] = noOfFridge;
    data['spaceOwner'] = spaceOwner;
    data['noOfFan'] = noOfFan;
    data['noOfAc'] = noOfAc;
    data['noOfTelevision'] = noOfTelevision;
    data['type'] = type;
    data['_id'] = sId;
    return data;
  }
}
