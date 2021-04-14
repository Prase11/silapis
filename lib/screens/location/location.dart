import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:silapis/models/model.dart';
import 'package:silapis/widgets/widget.dart';

class Location extends StatefulWidget {
  final LocationModel location;
  final bool withBlueZone;

  Location({Key key, this.location, this.withBlueZone = true})
      : super(key: key);

  @override
  _LocationState createState() {
    return _LocationState();
  }
}

class _LocationState extends State<Location> {
  CameraPosition _initPosition;
  Set<Circle> circles;
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};

  @override
  void initState() {
    _onLoadMap();
    super.initState();
  }

  ///On load map
  void _onLoadMap() {
    MarkerId markerId;
    Marker marker;

    if (widget.location.lat != null) {
      markerId = MarkerId(widget.location.id.toString());
      marker = Marker(
        markerId: markerId,
        position: LatLng(widget.location.lat, widget.location.long),
        infoWindow: InfoWindow(title: widget.location.name),
        onTap: () {},
      );
    }

    setState(() {
      _initPosition = CameraPosition(
        target: LatLng(widget.location.lat ?? -3.2975608,
            widget.location.long ?? 114.5846911),
        zoom: 14.4746,
      );
      if (widget.location.lat != null) {
        _markers[markerId] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCustomAppBar.defaultAppBar(title: 'Lokasi', context: context),
      body: Container(
        child: GoogleMap(
          initialCameraPosition: _initPosition,
          markers: Set<Marker>.of(_markers.values),
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          circles: circles,
        ),
      ),
    );
  }
}
