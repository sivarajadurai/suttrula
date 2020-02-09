import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:suttrula/PlaceList.dart';

class MainFetchData extends StatefulWidget {
  final String type;
  final String typeName;
  MainFetchData(this.type,this.typeName);
  @override
  _MainFetchDataState createState() => _MainFetchDataState(this.type,this.typeName);
}

class _MainFetchDataState extends State<MainFetchData> {
  final String type;
  final String typeName;

  _MainFetchDataState(this.type,this.typeName);
  List list = List();
  var isLoading = false;
  @override
  void initState() {
    super.initState();
    _fetchData();
    var geolocator = Geolocator();
    var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

    StreamSubscription<Position> positionStream = geolocator.getPositionStream(locationOptions).listen(
            (Position position) {
          print(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString());

        });
  }
  _fetchData() async {
    Position position = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
    print("position : "+position.latitude.toString());
    setState(() {
      isLoading = true;
    });
    final response =
    await http.get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?radius=500&key=AIzaSyAdCVqxD29LleZgiFRJNg_J0nG4YHGTTgU&location="+position.latitude.toString()+","+position.longitude.toString()+"&type="+this.type.toString());
    if (response.statusCode == 200) {
      list = (json.decode(response.body)['results'] as List)
          .map((data) => new Photo.fromJson(data))
          .toList();
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(this.typeName),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),

        ),
        body: isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              print(list[index]);
              return new PlaceList(list[index]);
            }));
  }
}


class Photo {

  final String name;
  final String vicinity;
  final String thumbnailUrl;
  Photo._({this.name, this.vicinity,this.thumbnailUrl});
  factory Photo.fromJson(Map<String, dynamic> json) {
    return new Photo._(
      name: json['name'],
      vicinity:json['vicinity'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }
}