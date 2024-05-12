import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:kantor_gubernur/constants/colors.dart';
import 'package:kantor_gubernur/constants/strings.dart';
import 'package:kantor_gubernur/rest/api_provider.dart';
import 'package:kantor_gubernur/ui/widget/loading_indicator.dart';
import 'package:latlong2/latlong.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key, required this.address, required this.province});
  final String province;
  final String address;
  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colorPrimary,
          title: Text(widget.province),
        ),
        body: _buildMaps());
  }

  Widget _buildMaps() {
    return FutureBuilder<List<Location>?>(
      future: _apiProvider.getLocation(address: widget.address),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data;
          return FlutterMap(
            options: MapOptions(
              initialCenter:
                  LatLng(data?[0].latitude ?? 0, data?[0].longitude ?? 0),
              initialZoom: 17,
              cameraConstraint: CameraConstraint.contain(
                bounds: LatLngBounds(
                  const LatLng(-90, -180),
                  const LatLng(90, 180),
                ),
              ),
            ),
            children: [
              TileLayer(
                urlTemplate: urlTemplate,
                userAgentPackageName: packageName,
              ),
            ],
          );
        }
        return const LoadingIndicator();
      },
    );
  }
}
