import 'package:objectbox/objectbox.dart';

@Entity()
class LocalOutlet {
  @Id()
  int? id;
  int? userId;
  String? nameOutlet;
  String? latitude;
  String? longitude;
  String? address;
  String? imageUrl;
  String? clockIn;
  String? clockOut;
  String? userLatitude;
  String? userLongitude;

  LocalOutlet(
      {this.id,
      this.userId,
      this.nameOutlet,
      this.latitude,
      this.longitude,
      this.address,
      this.imageUrl,
      this.clockIn,
      this.clockOut,
      this.userLatitude,
      this.userLongitude});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name_outlet': nameOutlet,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'image_url': imageUrl,
      'clock_in': clockIn,
      'clock_out': clockOut,
      'user_latitude': userLatitude,
      'user_longitude': userLongitude,
    };
  }
}
