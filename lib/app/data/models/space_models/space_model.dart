class SpaceModel {
  String? id;
  String? uid;
  bool? isPrivate;
  String? name;

  SpaceModel({this.id, this.uid, this.isPrivate, this.name});

  // Factory constructor for creating a new instance from a map
  factory SpaceModel.fromJson(Map<String, dynamic> json) {
    return SpaceModel(
      id: json['id'] as String,
      uid: json['uid'] as String,
      isPrivate: json['isPrivate'].toString() == 'true',
      name: json['name'] as String,
    );
  }

  factory SpaceModel.fromMap(Map<String, dynamic> map) {
    return SpaceModel(
      id: map['id'] as String,
      uid: map['uid'] as String,
      isPrivate: map['isPrivate'].toString() == 'true',
      name: map['name'] as String,
      // etc.
    );
  }

  // Converts the instance to a map
  Map<String, dynamic> toJson() {
    return {'id': id, 'uid': uid, 'isPrivate': isPrivate, 'name': name};
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'uid': uid, 'isPrivate': isPrivate, 'name': name};
  }

  // Creates a copy of the current object with new values
  SpaceModel copyWith({
    String? id,
    String? uid,
    bool? isPrivate,
    String? name,
  }) {
    return SpaceModel(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      isPrivate: isPrivate ?? this.isPrivate,
      name: name ?? this.name,
    );
  }

  @override
  String toString() =>
      'SpaceModel(id: $id, isPrivate: $isPrivate, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SpaceModel &&
        other.id == id &&
        other.isPrivate == isPrivate &&
        other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ isPrivate.hashCode ^ name.hashCode;
}
