import 'lat_lng.dart';

/// A class representing a place with geographical and address information.
///
/// This class encapsulates details about a specific location, including its
/// geographical coordinates (latitude and longitude), name, address, city,
/// state, country, and zip code.
///
/// Example usage:
/// ```dart
/// final place = FFPlace(
///   latLng: LatLng(34.0522, -118.2437), // Los Angeles, CA coordinates
///   name: 'Griffith Observatory',
///   address: '2800 E Observatory Rd',
///   city: 'Los Angeles',
///   state: 'CA',
///   country: 'USA',
///   zipCode: '90027',
/// );
/// print(place); // Output: FFPlace details...
/// ```

class FFPlace {
  const FFPlace({
    this.latLng = const LatLng(0.0, 0.0),
    this.name = '',
    this.address = '',
    this.city = '',
    this.state = '',
    this.country = '',
    this.zipCode = '',
  });

  final LatLng latLng;
  final String name;
  final String address;
  final String city;
  final String state;
  final String country;
  final String zipCode;

  @override
  String toString() => '''FFPlace(
        latLng: $latLng,
        name: $name,
        address: $address,
        city: $city,
        state: $state,
        country: $country,
        zipCode: $zipCode,
      )''';

  @override
  int get hashCode => latLng.hashCode;

  @override
  bool operator ==(other) =>
      other is FFPlace &&
      latLng == other.latLng &&
      name == other.name &&
      address == other.address &&
      city == other.city &&
      state == other.state &&
      country == other.country &&
      zipCode == other.zipCode;
}
