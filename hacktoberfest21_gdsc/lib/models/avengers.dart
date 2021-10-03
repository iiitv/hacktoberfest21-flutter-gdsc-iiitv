class DataHub {
  List<Data> data = [];
  DataHub({required this.data});

  DataHub.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? batch;
  String? imgURL;
  String? linkedinURL;
  String? githubURL;
  String? twitterURL;
  Data(
      {this.id,
      this.name,
      this.batch,
      this.imgURL,
      this.linkedinURL,
      this.githubURL,
      this.twitterURL});

  // Data copyWith({
  //   int id,
  //   String? name,
  //   String? batch,
  //   String? imgURL,
  //   String? linkedinURL,
  //   String? githubURL,
  // }) {
  //   return Data(
  //     id: id ?? this.id,
  //     name: name ?? this.name,
  //     batch: batch ?? this.batch,
  //     imgURL: imgURL ?? this.imgURL,
  //     linkedinURL: linkedinURL ?? this.linkedinURL,
  //     githubURL: githubURL ?? this.githubURL,
  //   );
  // }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'batch': batch,
      'imgURL': imgURL,
      'linkedinURL': linkedinURL,
      'githubURL': githubURL,
      'twitterURL': twitterURL
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
        id: map['id'],
        name: map['name'],
        batch: map['batch'],
        imgURL: map['imgURL'],
        linkedinURL: map['linkedinURL'],
        githubURL: map['githubURL'],
        twitterURL: map['twitterURL']);
  }

  // String toJson() => json.encode(toMap());

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    batch = json['batch'];
    imgURL = json['imgURL'];
    githubURL = json['githubURL'];
    linkedinURL = json['linkedinURL'];
    twitterURL = json['twitterURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['imgURL'] = imgURL;
    data['githubURL'] = githubURL;
    data['batch'] = batch;
    data['linkedinURL'] = linkedinURL;
    data['twitterURL'] = twitterURL;

    return data;
  }

  // @override
  // String toString() {
  //   return 'Data(id: $id, name: $name, batch: $batch, imgURL: $imgURL, linkedinURL: $linkedinURL, githubURL: $githubURL)';
  // }

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;

  //   return other is Data &&
  //       other.id == id &&
  //       other.name == name &&
  //       other.batch == batch &&
  //       other.imgURL == imgURL &&
  //       other.linkedinURL == linkedinURL &&
  //       other.githubURL == githubURL;
  // }

  // @override
  // int get hashCode {
  //   return id.hashCode ^
  //       name.hashCode ^
  //       batch.hashCode ^
  //       imgURL.hashCode ^
  //       linkedinURL.hashCode ^
  //       githubURL.hashCode;
  // }
}
