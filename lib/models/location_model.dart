final String locationTable = 'location';

class LocationNotes {
  static final List<String> values = [
    locationId,
    location,
  ];
  static final String locationId = 'locationId';
  static final String location = 'location';
}

class Location {
  int? locationId;
  String? location;

  Location({
    this.locationId,
    this.location,
  });

  Location.fromMap(dynamic obj) {
    this.location = obj['location'];
    this.locationId = obj['locationId'];
  }
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'location': location,
      'locationId': locationId,
    };
    return map;
  }
}
