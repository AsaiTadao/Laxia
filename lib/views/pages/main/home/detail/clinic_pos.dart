import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laxia/common/helper.dart';

class Clinic_Pos extends StatefulWidget {
  final String pos;
  const Clinic_Pos({Key? key, required this.pos}) : super(key: key);

  @override
  State<Clinic_Pos> createState() => _Clinic_PosState();
}

class _Clinic_PosState extends State<Clinic_Pos> {
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(35.6674466, 139.7396131);
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading:IconButton(
                icon: Icon(Icons.arrow_back_ios, size: 22, color: Colors.black),
                onPressed: () => Navigator.pop(context),
                splashColor: Colors.transparent,
            highlightColor: Colors.transparent,  
              ),
        title: Text('湘南美容クリニック 新宿院',
          style: TextStyle(
            fontFamily: Helper.headFontFamily,
            
          fontWeight: FontWeight.w400,
          fontSize: 18,
          color: Helper.titleColor)
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Helper.whiteColor),
        child: Column(children: [
          Expanded(
              child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Expanded(
                  child: Container(
                //google map
                child: GoogleMap(
                  mapType: MapType.normal,
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 15.0,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId('current'),
                      position: _center,
                    )
                  },
                ),
              )),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: SizedBox(
                    width: 160,
                    height: 36,
                    child: GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Helper.mainColor,
                            borderRadius: BorderRadius.circular(18)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "地図アプリで見る",
                            style: TextStyle(
                                
                                color: Helper.whiteColor, fontSize: 13),
                          ),
                        ),
                      ),
                      onTap: () {},
                    ),
                  )),
            ],
          )),
          SafeArea(
            child: Container(
              color: Helper.whiteColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                        flex: 9,
                        child: Text(
                          "東京都新宿区西新宿６丁目５−１ 新宿アイランドタワ 24F",
                          softWrap: true,
                          style: TextStyle(
                            
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Helper.maintxtColor),
                        )),
                    Expanded(
                      flex: 1,
                      child: SvgPicture.asset(
                        "assets/icons/double_map.svg",
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
