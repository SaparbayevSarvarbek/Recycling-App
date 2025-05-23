import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
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
    _updateMarkers();
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

    location.onLocationChanged.listen((loc) {
      setState(() => _currentLocation = loc);
      _updateMarkers();
      if (_mapController != null) {
        _mapController!.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(loc.latitude!, loc.longitude!),
          ),
        );
      }
    });
  }

  Future<void> _loadBins() async {
    final bins = await DBHelper().getAllBins();
    setState(() => _bins = bins);
  }

  void _updateMarkers() {
    final userIcon =
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
    final binIcon =
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);

    Set<Marker> newMarkers = _bins.map((bin) {
      return Marker(
        markerId: MarkerId(bin.id.toString()),
        position: LatLng(bin.latitude, bin.longitude),
        icon: binIcon,
        onTap: () => _showBinDetails(bin),
      );
    }).toSet();

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
      builder: (_) => DraggableScrollableSheet(
        expand: false,
        builder: (_, controller) => Padding(
          padding: EdgeInsets.all(16),
          child: ListView(
            controller: controller,
            children: [
              Text(bin.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Image.asset(bin.imagePath, height: 150),
              SizedBox(height: 8),
              Text(bin.description),
              SizedBox(height: 16),
              Text('Yo‘riqnomalar:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ...bin.instructions.map((instr) => ListTile(
                    leading:
                        Image.asset(instr.imagePath, width: 40, height: 40),
                    title: Text(instr.name),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void _onSearchChanged() {
    String query = _searchController.text.trim().toLowerCase();

    final filteredBins =
        _bins.where((bin) => bin.name.toLowerCase().contains(query)).toList();

    final binIcon =
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
    final userIcon =
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);

    Set<Marker> searchMarkers = filteredBins.map((bin) {
      return Marker(
        markerId: MarkerId(bin.id.toString()),
        position: LatLng(bin.latitude, bin.longitude),
        icon: binIcon,
        onTap: () => _showBinDetails(bin),
      );
    }).toSet();

    if (_currentLocation != null) {
      searchMarkers.add(
        Marker(
          markerId: MarkerId('user_location'),
          position:
              LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
          icon: userIcon,
          infoWindow: InfoWindow(title: 'Sizning joylashuvingiz'),
        ),
      );
    }

    setState(() => _markers = searchMarkers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chiqindi Qutilari'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Qidirish...',
                prefixIcon: Icon(Icons.search),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: _currentLocation == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    _currentLocation!.latitude!, _currentLocation!.longitude!),
                zoom: 14,
              ),
              markers: _markers,
              onMapCreated: (controller) {
                _mapController = controller;
                _updateMarkers();
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
    );
  }
}
