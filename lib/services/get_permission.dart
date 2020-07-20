import 'package:flutter/services.dart';
import 'package:location/location.dart';


Future<void> checkForLocation() async{
  Location loc = Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  //checking if the user has allowed location permission.
  _permissionGranted = await loc.hasPermission();
  if(_permissionGranted == PermissionStatus.denied){
    _permissionGranted = await loc.requestPermission();
    if(_permissionGranted != PermissionStatus.granted)
    {
      SystemNavigator.pop();
    }
  }

  //checking if the user has location enabled/turned ON.
  _serviceEnabled = await loc.serviceEnabled();
  if(!_serviceEnabled){
    _serviceEnabled = await loc.requestService();
    if(!_serviceEnabled){
      SystemNavigator.pop();
    }
  }
}
