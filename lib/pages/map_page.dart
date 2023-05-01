import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({
    super.key,
  });

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController _mapController;
  final CameraPosition _appWorksPosition = const CameraPosition(
    target: LatLng(25.0384096, 121.5321433),
    zoom: 15.0,
  );
  final Marker appWorksMarker = Marker(
    markerId: const MarkerId('AppWorks'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
    infoWindow: InfoWindow(
        title: 'AppWorks School',
        snippet: 'Flutter',
        onTap: () {
          print('AppWorks marker info window');
        }),
    position: const LatLng(25.0384096, 121.5321433),
  );

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    controller.setMapStyle(
        "[{\"elementType\":\"geometry\",\"stylers\":[{\"color\":\"#242f3e\"}]},{\"elementType\":\"labels.text.fill\",\"stylers\":[{\"color\":\"#746855\"}]},{\"elementType\":\"labels.text.stroke\",\"stylers\":[{\"color\":\"#242f3e\"}]},{\"featureType\":\"administrative.locality\",\"elementType\":\"labels.text.fill\",\"stylers\":[{\"color\":\"#d59563\"}]},{\"featureType\":\"poi\",\"elementType\":\"labels.text.fill\",\"stylers\":[{\"color\":\"#d59563\"}]},{\"featureType\":\"poi.park\",\"elementType\":\"geometry\",\"stylers\":[{\"color\":\"#263c3f\"}]},{\"featureType\":\"poi.park\",\"elementType\":\"labels.text.fill\",\"stylers\":[{\"color\":\"#6b9a76\"}]},{\"featureType\":\"road\",\"elementType\":\"geometry\",\"stylers\":[{\"color\":\"#38414e\"}]},{\"featureType\":\"road\",\"elementType\":\"geometry.stroke\",\"stylers\":[{\"color\":\"#212a37\"}]},{\"featureType\":\"road\",\"elementType\":\"labels.text.fill\",\"stylers\":[{\"color\":\"#9ca5b3\"}]},{\"featureType\":\"road.highway\",\"elementType\":\"geometry\",\"stylers\":[{\"color\":\"#746855\"}]},{\"featureType\":\"road.highway\",\"elementType\":\"geometry.stroke\",\"stylers\":[{\"color\":\"#1f2835\"}]},{\"featureType\":\"road.highway\",\"elementType\":\"labels.text.fill\",\"stylers\":[{\"color\":\"#f3d19c\"}]},{\"featureType\":\"transit\",\"elementType\":\"geometry\",\"stylers\":[{\"color\":\"#2f3948\"}]},{\"featureType\":\"transit.station\",\"elementType\":\"labels.text.fill\",\"stylers\":[{\"color\":\"#d59563\"}]},{\"featureType\":\"water\",\"elementType\":\"geometry\",\"stylers\":[{\"color\":\"#17263c\"}]},{\"featureType\":\"water\",\"elementType\":\"labels.text.fill\",\"stylers\":[{\"color\":\"#515c6d\"}]},{\"featureType\":\"water\",\"elementType\":\"labels.text.stroke\",\"stylers\":[{\"color\":\"#17263c\"}]}]");

    controller.getLatLng(const ScreenCoordinate(x: 50, y: 50)).then((value) {
      print('getLatLng: ${value.toString()}');
    });
  }

  void _goToAppWorks() {
    _mapController
        .animateCamera(CameraUpdate.newCameraPosition(_appWorksPosition))
        .then((_) {
      _mapController.showMarkerInfoWindow(const MarkerId('AppWorks'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/stylish_logo.png',
          width: 128,
        ),
        actions: [
          IconButton(
            onPressed: () {
              _goToAppWorks();
            },
            icon: const Icon(
              Icons.room,
              color: Colors.grey,
            ),
          ),
        ],
        backgroundColor: const Color(0xFFEEEEEE),
        elevation: 1,
      ),
      body: GoogleMap(
        initialCameraPosition: _appWorksPosition,
        onMapCreated: _onMapCreated,
        // mapType: MapType.hybrid,
        myLocationEnabled: true,
        markers: {appWorksMarker},
        onTap: (latLng) {
          print('GoogleMap onTap: ${latLng.toString()}');
        },
      ),
    );
  }
}
