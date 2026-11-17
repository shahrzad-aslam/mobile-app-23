import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


class RadarScreen extends StatefulWidget {
  const RadarScreen({Key? key}) : super(key: key);

  @override
  State<RadarScreen> createState() => _RadarScreenState();
}

class _RadarScreenState extends State<RadarScreen> {
  bool _isScanning = false;
  double _distanceInFeet = 0.0;
  bool _isWithinRange = false;

  // Used to force the wave animation to restart in a loop
  int _waveKey = 0;

  
  Position? _currentPosition;
  StreamSubscription<Position>? livePositionStream;

  double? _initLat;
  double? _initLong;
  double? _currentLat;
  double? _currentLong;
  

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    livePositionStream?.cancel();
    super.dispose();
  }

  void _showSnakbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.redAccent,
        ),
      );
  }

  Future<void> _getCurrentLocation() async {

    bool enabled = await Geolocator.isLocationServiceEnabled();
    if(!enabled) {
		Geolocator.openAppSettings();
      _showSnakbar("Enable the GPS to use location");
      return;
    }
    LocationPermission per = await Geolocator.checkPermission();
    if(per == LocationPermission.denied) {
      per = await Geolocator.requestPermission();
      if(per == LocationPermission.denied) {
        _showSnakbar("Application need location permissions to work");
        return;
      }
    }

    if(per == LocationPermission.deniedForever) {
      _showSnakbar("Application need location permissions to work");
      return;
    }
    _currentPosition = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.best,
      )
    );

    if(_currentPosition!.isMocked) {
      _showSnakbar("Turn off fake GPS app");
      return;
    }

    setState(() {
      _initLat = _currentPosition?.latitude;
      _initLong = _currentPosition?.longitude;
      _currentLat = _initLat;
      _currentLong = _initLong;
    });
    

  }

  

  void _toggleScan() {
    setState(() {
      _isScanning = !_isScanning;
      if (_isScanning) {
        _waveKey++; // Reset/trigger wave on start
      }
    });

    if (_isScanning) {
		// TODO: Calculate distance to target on each position update
      LocationSettings settings = LocationSettings(
        accuracy: LocationAccuracy.best
      );
      livePositionStream = Geolocator.getPositionStream(locationSettings: settings).listen((Position pos) {
        _currentPosition = pos;
        setState(() {
          _currentLat = pos.latitude;
          _currentLong = pos.longitude;
        });
        _calculateDistance();
      });
      
    } else {
		// TODO: Cancel position stream subscription
      livePositionStream?.cancel();
      
    }
  }

  void _calculateDistance() {
    if(_currentPosition == null || _initLat == null || _initLong == null)
      return;
    double dMeters = Geolocator.distanceBetween(_currentLat!, _currentLong!, _initLat!, _initLong!);
    setState(() {
      _distanceInFeet = dMeters * 3.28;
      _isWithinRange = _distanceInFeet <= 30;
    });
  }

  @override
  Widget build(BuildContext context) {
    final radarColor = _isWithinRange ? Colors.red : Colors.cyanAccent;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Center(
            child: SizedBox(
              width: 240,
              height: 240,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (_isScanning)
                    TweenAnimationBuilder<double>(
                      key: ValueKey(_waveKey), 
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(seconds: 2),
                      builder: (context, value, child) {
                        // Expands size from 80 up to 240 pixels
                        final size = 80.0 + (160.0 * value);
                        // Fades out opacity as it gets bigger
                        final opacity = (1.0 - value).clamp(0.0, 1.0); 

                        return Container(
                          width: size,
                          height: size,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: radarColor.withOpacity(opacity * 0.8),
                              width: 2.5,
                            ),
                          ),
                        );
                      },
                      onEnd: () {
                        if (_isScanning) {
                          setState(() {
                            _waveKey++; 
                          });
                        }
                      },
                    ),
                  // Outer Radar Ring 3
                  Container(
                    width: 240,
                    height: 240,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: radarColor.withOpacity(0.3), width: 2),
                    ),
                  ),
                  // Middle Radar Ring 2
                  Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: radarColor.withOpacity(0.5), width: 2),
                    ),
                  ),
                  // Inner Radar Ring 1
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: radarColor.withOpacity(0.8), width: 2),
                    ),
                  ),
                  // Center User Dot
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: radarColor,
                      boxShadow: [
                        BoxShadow(
                          color: radarColor.withOpacity(0.8),
                          blurRadius: 10,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // --- DISTANCE DISPLAY CARD ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white12),
                ),
                child: Column(
                  children: [
                    Text(
                      'Lat: ${_initLat}',
                      style: TextStyle(
                        color: radarColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Long: ${_initLong}',
                      style: TextStyle(
                        color: radarColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white12),
                ),
                child: Column(
                  children: [
                    Text(
                      'Lat: ${_currentLat}',
                      style: TextStyle(
                        color: radarColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Long: ${_currentLong}',
                      style: TextStyle(
                        color: radarColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white12),
                ),
                child: Text(
                  '${_distanceInFeet.toStringAsFixed(1)} ft',
                  style: TextStyle(
                    color: radarColor,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // --- START/STOP SCAN BUTTON ---
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _toggleScan,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isScanning ? Colors.redAccent : Colors.cyan,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                _isScanning ? 'STOP SCAN' : 'START SCAN',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}