part of main_lib;

class GoogleMapsTracking extends StatelessWidget {
  final bool showCircle;
  const GoogleMapsTracking({super.key, required this.showCircle});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    late GoogleMapController gmapsControl;
    return GetBuilder<MainPagesController>(
        init: MainPagesController(),
        builder: (ctrl) {
          final latitude = ctrl.latitude;
          final longitude = ctrl.longitude;

          return SizedBox(
            height: Get.height,
            width: Get.width,
            child: !ctrl.isLoading
                ? GoogleMap(
                    // onTap: (latLng) => controller.onTapMaps(latLng),
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    initialCameraPosition: CameraPosition(
                        target: LatLng(latitude, longitude), zoom: 14),
                    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                      Factory<OneSequenceGestureRecognizer>(
                        () => EagerGestureRecognizer(),
                      ),
                    },
                    mapToolbarEnabled: false,
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: false,
                    scrollGesturesEnabled: true,
                    myLocationButtonEnabled: true,
                    onMapCreated: (GoogleMapController controller) {
                      gmapsControl = controller;
                    },
                    markers: ctrl.markers,
                    circles: showCircle == true
                        ? {
                            Circle(
                                circleId: const CircleId('outlet-profile'),
                                center: LatLng(latitude, longitude),
                                radius: 1000,
                                fillColor:
                                    AppStyle.kSecondaryColor.withOpacity(0.1),
                                strokeWidth: 1,
                                strokeColor: AppStyle.kSecondaryColor)
                          }
                        : {},
                  )
                : Center(
                    child: CircularProgressIndicator(
                      color: AppStyle.kSecondaryColor,
                    ),
                  ),
          );
        });
  }
}
