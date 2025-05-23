import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:recyceling_app/widgets/location_detalis_widget.dart';

import '../models/bin_model.dart';
import '../services/db_helper.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  List<Bin> _bins = [];
  LocationData? _currentLocation;
  TextEditingController _searchController = TextEditingController();
  int? selectedBinId;

  @override
  void initState() {
    super.initState();
    _initialize();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _initialize() async {
    await _getCurrentLocation();
    await _loadBins();
    await _updateMarkers();
  }

  Future<void> _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    final loc = await location.getLocation();
    setState(() => _currentLocation = loc);
  }

  Future<void> _loadBins() async {
    final bins = await DBHelper().getAllBins();
    setState(() => _bins = bins);
  }

  Future<BitmapDescriptor> _bitmapFromAsset(String path,
      {int width = 400}) async {
    return await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(width.toDouble(), width.toDouble())),
      path,
    );
  }

  Future<void> _updateMarkers() async {
    final userIcon =
        await _bitmapFromAsset('assets/images/user_location.png', width: 400);

    Set<Marker> newMarkers = {};

    for (var bin in _bins) {
      final binIcon = await _bitmapFromAsset(
        bin.id == selectedBinId
            ? 'assets/images/binmarker_selected.png'
            : 'assets/images/binmarker.png',
        width: 400,
      );

      newMarkers.add(
        Marker(
          markerId: MarkerId(bin.id.toString()),
          position: LatLng(bin.latitude, bin.longitude),
          icon: binIcon,
          onTap: () {
            setState(() => selectedBinId = bin.id);
            _showBinDetails(bin);
            _updateMarkers();
          },
        ),
      );
    }

    if (_currentLocation != null) {
      newMarkers.add(
        Marker(
          markerId: MarkerId('user_location'),
          position:
              LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
          icon: userIcon,
          infoWindow: InfoWindow(title: 'Sizning joylashuvingiz'),
        ),
      );
    }

    setState(() => _markers = newMarkers);
  }

  void _showBinDetails(Bin bin) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => LocationDetailsWidget(bin: bin),
    );
  }

  void _onSearchChanged() async {
    String query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) {
      await _updateMarkers();
      return;
    }

    final filteredBins =
        _bins.where((bin) => bin.name.toLowerCase().contains(query)).toList();

    if (filteredBins.isNotEmpty) {
      final firstMatchedBin = filteredBins.first;

      setState(() {
        selectedBinId = firstMatchedBin.id;
      });

      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(firstMatchedBin.latitude, firstMatchedBin.longitude),
          16,
        ),
      );

      await _updateMarkers();
    }
  }

  void _showNearestBin() {
    if (_currentLocation == null || _bins.isEmpty) return;

    Bin? nearest;
    double shortestDistance = double.infinity;

    for (var bin in _bins) {
      final distance = _calculateDistance(
        _currentLocation!.latitude!,
        _currentLocation!.longitude!,
        bin.latitude,
        bin.longitude,
      );
      if (distance < shortestDistance) {
        shortestDistance = distance;
        nearest = bin;
      }
    }

    if (nearest != null) {
      setState(() => selectedBinId = nearest!.id);
      _mapController?.animateCamera(CameraUpdate.newLatLng(
        LatLng(nearest.latitude, nearest.longitude),
      ));
      _showBinDetails(nearest);
      _updateMarkers();
    }
  }

  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const R = 6371;
    final dLat = _deg2rad(lat2 - lat1);
    final dLon = _deg2rad(lon2 - lon1);
    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_deg2rad(lat1)) *
            cos(_deg2rad(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c;
  }

  double _deg2rad(double deg) => deg * (pi / 180);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(45),
          ),
        ),
        title: Text(
          'BIN LOCATOR',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: _currentLocation == null
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      _currentLocation!.latitude!,
                      _currentLocation!.longitude!,
                    ),
                    zoom: 14,
                  ),
                  markers: _markers,
                  onMapCreated: (controller) {
                    _mapController = controller;
                    _updateMarkers();
                  },
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                ),
                Positioned(
                  top: 40,
                  left: 16,
                  right: 16,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'EX) STATE COLLEGE, PA',
                            hintStyle: TextStyle(color: Color(0xFFB5BDC2)),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Color(0xFF70B458),
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Colors.green,
                                width: 1,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            if (value.isEmpty) {
                              setState(() {});
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 16.0),
                      GestureDetector(
                        onTap: _onSearchChanged,
                        child: Container(
                          width: 49,
                          height: 49,
                          decoration: BoxDecoration(
                            color: Color(0xFF70B458),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 24,
                  left: 50,
                  right: 50,
                  child: ElevatedButton(
                    onPressed: _showNearestBin,
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        textStyle: TextStyle(fontSize: 16),
                        backgroundColor: Color(0xFF70B458)),
                    child: Text(
                      'LOCATE NEAREST',
                      style: TextStyle(color: Colors.white, fontSize: 26),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
