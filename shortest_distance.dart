// ignore_for_file: prefer_const_constructors
import 'dart:async';
import 'dart:collection';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class ShortestDistance extends StatefulWidget {
  @override
  State<ShortestDistance> createState() => _ShortestDistance();
}

class _ShortestDistance extends State<ShortestDistance> {
  final Completer<GoogleMapController> _controller=Completer();
  LatLng source=LatLng(37.33500926, -122.03272188);
  LatLng destination=LatLng(37.33429383, -122.0660055);
  String googleApiKey='AIzaSyChubH-7zncgfBiRoM6EXSEiNhxMdqx_Nk';
  LocationData? currentLocation;
  List<LatLng>polyLinesCoordinates=[];
  void getPolyPoints() async{
    PolylinePoints polylinePoints=PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey,
        PointLatLng(source.latitude, source.longitude),
        PointLatLng(destination.latitude,destination.longitude),
    );
    if(result.points.isNotEmpty){
      result.points.forEach(
              (PointLatLng point)=>polyLinesCoordinates.add(
                  LatLng(point.latitude, point.longitude)
              )
      );
      // setState(() {
      // });
    }

  }
  void getCurrentLocation()async{
    Location location=Location();

    location.getLocation().then((location) {
      currentLocation=location;
    });
    GoogleMapController googleMapController=await _controller.future;
    location.onLocationChanged.listen((event) {
      currentLocation=event;
      googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(zoom : 13.5,target: LatLng(event!.latitude!,event!.longitude!))));
    });
  }

  @override
  void initState() {
    getCurrentLocation();
    getPolyPoints();
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps Project',style: TextStyle(fontSize: 25,),),
      ),
      body:currentLocation==null?Center(child: Text('Loading')):GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(currentLocation!.latitude!,currentLocation!.longitude!),
          zoom: 13.5,
        ),
        polylines: {
          Polyline(
            polylineId: PolylineId('route'),
            points: polyLinesCoordinates,
            color: Colors.blue,
            width: 10,
          ),
        },
        markers: {
          Marker(
            markerId: MarkerId('Current Location'),
            position: LatLng(currentLocation!.latitude!,currentLocation!.longitude!),

          ),
            Marker(
              markerId: MarkerId('Source Location'),
              position: source,

            ),
          Marker(
            markerId: MarkerId('Destination Location'),
            position: destination,
          ),
          },
        onMapCreated: (mapController){
          _controller.complete(mapController);
        },

      )
    );
  }
}
