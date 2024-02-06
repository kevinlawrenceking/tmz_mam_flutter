class LatLng {
  const LatLng(this.latitude, this.longitude);
  final double latitude;
  final double longitude;

  /// A class representing a geographical location specified in latitude and longitude.
  ///
  /// This class can be used to represent a point on the Earth's surface, with
  /// latitude values ranging from -90 to 90 degrees and longitude values ranging
  /// from -180 to 180 degrees.
  ///
  /// Example usage:
  /// ```dart
  /// final location = LatLng(34.0522, -118.2437); // Los Angeles, CA coordinates
  /// print(location); // Output: LatLng(lat: 34.0522, lng: -118.2437)

  @override
  String toString() => 'LatLng(lat: $latitude, lng: $longitude)';

  String serialize() => '$latitude,$longitude';

  @override
  int get hashCode => latitude.hashCode + longitude.hashCode;

  @override
  bool operator ==(other) =>
      other is LatLng &&
      latitude == other.latitude &&
      longitude == other.longitude;
}
