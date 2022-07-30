import 'package:flutter/material.dart';
import 'package:flutter_kakao_map/flutter_kakao_map.dart';
import 'package:flutter_kakao_map/kakao_maps_flutter_platform_interface.dart';

void main() {
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: MyAppOne(),
  ));
}

class MyAppOne extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyAppOne> {

  var infowindow = new InfoWindow();
  late KakaoMapController mapController;

  MapPoint _visibleRegion = MapPoint(37.5087553, 127.0632877);
  CameraPosition _kInitialPosition =
  CameraPosition(target: MapPoint(37.5087553, 127.0632877), zoom: 5);

  void onMapCreated(KakaoMapController controller) async {
    final MapPoint visibleRegion = await controller.getMapCenterPoint();
    setState(() {
      mapController = controller;
      _visibleRegion = visibleRegion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Flutter KakaoMap example')),
        extendBodyBehindAppBar: true,
        body:
        Container(

          child : Column(
            children: [
              Center(
                  child :
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: KakaoMap(
                          onMapCreated: onMapCreated,
                          initialCameraPosition: _kInitialPosition))
              )
            ],
          ),

        )
    );
  }
}