import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatelessWidget {
  final LatLng? selectedLocation;
  final Set<Marker> markers;
  final Function(GoogleMapController) onMapCreated;
  final Function(LatLng) onTap;
  
  const MapWidget({
    super.key,
    required this.selectedLocation,
    required this.markers,
    required this.onMapCreated,
    required this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      key: const ValueKey("google_map"),
      initialCameraPosition: CameraPosition(
        target: selectedLocation ?? const LatLng(0, 0),
        zoom: 17.0,
      ),
      markers: markers,
      onMapCreated: onMapCreated,
      onTap: onTap,
      myLocationEnabled: false,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
    );
  }
}
