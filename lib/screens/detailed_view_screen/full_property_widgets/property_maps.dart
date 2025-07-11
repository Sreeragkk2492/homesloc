import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PropertyMapSection extends StatelessWidget {
  final double latitude;
  final double longitude;
  final String propertyName;

  const PropertyMapSection({
    Key? key,
    required this.latitude,
    required this.longitude,
    required this.propertyName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LatLng propertyLatLng = LatLng(latitude, longitude);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              Icon(Icons.location_on, color: Colors.red, size: 28),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  propertyName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 220,
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: propertyLatLng,
                    zoom: 15,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId('property'),
                      position: propertyLatLng,
                    ),
                  },
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
                  onTap: (_) {
                    // Optionally handle map tap
                  },
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Optionally open external map or expand map
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                    elevation: 4,
                  ),
                  child: Text("Click here to use map"),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}