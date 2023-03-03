// ignore_for_file: prefer_const_constructors
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var myMarkers=HashSet<Marker>();
  var markerTitle='Cairo Egypt';
  var markerId='1';
  Set<Polygon> myPolygon() {
    var myPolygon = <LatLng>[];
    // List<LatLng> myPolygon = new List();
    myPolygon.add(LatLng(37.43296265331129, -122.08832357078792));
    myPolygon.add(LatLng(37.43006265331129, -122.08832357078792));
    myPolygon.add(LatLng(37.43006265331129, -122.08332357078792));
    myPolygon.add(LatLng(37.43296265331129, -122.08832357078792));

    Set<Polygon> polygonSet = Set();
    polygonSet.add(Polygon(
        polygonId: PolygonId('MapTest'),
        points: myPolygon,
        strokeColor: Colors.red));

    return polygonSet;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps Project',style: TextStyle(fontSize: 25,),),
      ),
      body: GoogleMap(
        mapType: MapType.normal ,
        initialCameraPosition: CameraPosition(
          target: LatLng(30.0444, 31.2357), //Cairo-Egypt
          zoom: 19.0,
        ),
        onMapCreated: (GoogleMapController googleMapController){
          setState((){
            myMarkers.add(
              Marker(
                markerId: MarkerId(markerId),
                  position: LatLng(30.0444,31.2357) ,
                infoWindow: InfoWindow(
                  title:markerTitle,
                  snippet: 'Cairo is the capital of egypt',
                  onTap: (){
                    print('Marker of cairo is clicked');
                  },
                ),//Cairo-Egypt
              ),
            );
          });
        },
        markers: myMarkers,
        polygons:myPolygon(),

      ),
    );
  }
}
