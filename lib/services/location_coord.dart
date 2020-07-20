import 'package:geolocator/geolocator.dart';

class LocationCoords{
  double Latitude;
  double Longitude;

  Future<void> getCurrentLocation() async{
    try{
      Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      Latitude = position.latitude;
      Longitude = position.longitude;
    }
    catch(e){
      print("Error occurred at location retrieval: $e");
    }
  }
}