part of home_lib;

class HomeController extends GetxController {
  final RxBool isLoading = false.obs;
  UserResponse? getUserData;
  final RxList<LocalOutlet> localOutlet = <LocalOutlet>[].obs;
  BitmapDescriptor? _startMarkerIcon;
  BitmapDescriptor? _endMarkerIcon;
  double latitudeUser = 0.0;
  double longitudeUser = 0.0;

  double latitudeOutlet = 0.0;
  double longitudeOutlet = 0.0;
  Set<Marker> markers = {};
  var screenStatus = (ScreenStatus.success).obs;

  HomeController();

  @override
  void onInit() {
    getUserData = AppPreference().getUserData();
    createStartMarkerImageFromAsset(Get.context!);
    createEndMarkerImageFromAsset(Get.context!);
    initData();
    getListOutlet();

    super.onInit();
  }

  Future<void> createStartMarkerImageFromAsset(BuildContext context) async {
    if (_startMarkerIcon == null) {
      final ImageConfiguration imageConfiguration =
          createLocalImageConfiguration(context, size: const Size.square(52));
      BitmapDescriptor.asset(imageConfiguration, AssetsImage.startMaker)
          .then(updateStartBitmap);
    }
  }

  void updateStartBitmap(BitmapDescriptor bitmap) {
    _startMarkerIcon = bitmap;
    update();
  }

  Future<void> createEndMarkerImageFromAsset(BuildContext context) async {
    if (_endMarkerIcon == null) {
      final ImageConfiguration imageConfiguration =
          createLocalImageConfiguration(context, size: const Size.square(40));
      BitmapDescriptor.asset(imageConfiguration, AssetsImage.endMaker)
          .then(updateEndBitmap);
    }
  }

  void updateEndBitmap(BitmapDescriptor bitmap) {
    _endMarkerIcon = bitmap;
    update();
  }

  Future<void> initData() async {
    isLoading.value = true;
    await initGeolocation();
    await addMaker();
    isLoading.value = false;
  }

  Future<void> getListOutlet() async {
    try {
      isLoading.value = true;
      localOutlet.clear();
      final localStorage = LocalStorage();
      final data =
          await localStorage.getOutletByUserId(userId: getUserData?.id ?? 0);
      localOutlet.assignAll(data);
    } catch (e) {
      Get.snackbar('error'.tr, e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshData() async {
    await Future.delayed(1.seconds, () {
      getListOutlet();
    });
  }

  Future<bool> attendance({required LocalOutlet outletEntry}) async {
    if (outletEntry.clockIn == null) {
      final outletLatitude = double.tryParse(outletEntry.latitude ?? '') ?? 0.0;

      final oultetLongitude =
          double.tryParse(outletEntry.longitude ?? '') ?? 0.0;

      final isNearOutlet = isWithinRadius(
        latitudeUser: latitudeUser,
        longitudeUser: longitudeUser,
        latitudeOutlet: outletLatitude,
        longitudeOutlet: oultetLongitude,
      );

      if (isNearOutlet) {
        final ImagePicker picker = ImagePicker();
        final XFile? imageFile = await picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 30,
        );

        if (imageFile != null) {
          if (isLoading.value) return false;
          try {
            isLoading(true);

            await localStorage.outletClockIn(
                imageUrl: imageFile.path,
                nameOutlet: outletEntry.nameOutlet ?? '',
                userId: outletEntry.userId ?? 0,
                userLatitude: latitudeUser,
                userLongitude: longitudeUser);
            return true;
          } catch (_) {
            return false;
          } finally {
            isLoading(false);
          }
        } else {
          return false;
        }
      } else {
        AppSnackbar.show(
            message: 'Check In Failed', onTop: true, type: SnackType.error);
        return false;
      }
    } else {
      await localStorage.outletClockOut(
        nameOutlet: outletEntry.nameOutlet ?? '',
        userId: outletEntry.userId ?? 0,
      );

      return true;
    }
  }

  Future<void> initGeolocation() async {
    try {
      List<Position> positions = [];

      for (int i = 0; i < 3; i++) {
        final pos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation,
        );

        if (pos.accuracy < 20) {
          positions.add(pos);
        }
      }

      Position finalPosition;

      if (positions.isNotEmpty) {
        positions.sort((a, b) => a.accuracy.compareTo(b.accuracy));
        finalPosition = positions.first;
      } else {
        finalPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
      }

      double newLat = finalPosition.latitude;
      double newLng = finalPosition.longitude;

      double threshold = 0.00001;

      if ((newLat - latitudeUser).abs() > threshold ||
          (newLng - longitudeUser).abs() > threshold) {
        latitudeUser = newLat;
        longitudeUser = newLng;

        update();
      } else {}
    } catch (_) {}
  }

  Future<void> addMaker() async {
    markers.add(Marker(
      markerId: const MarkerId('start-maker'),
      position: LatLng(latitudeUser, longitudeUser),
      infoWindow: const InfoWindow(
        title: 'Starting Point ',
        snippet: 'Start Marker',
      ),
      icon: _startMarkerIcon!,
    ));

    // outlet location
    markers.add(Marker(
      markerId: const MarkerId('end-maker'),
      position: LatLng(latitudeOutlet, longitudeOutlet),
      infoWindow: const InfoWindow(
        title: 'Destination Point ',
        snippet: 'Destination Marker',
      ),
      icon: _endMarkerIcon!,
    ));
  }

  // ============ helper
  bool isWithinRadius({
    required double latitudeUser,
    required double longitudeUser,
    required double latitudeOutlet,
    required double longitudeOutlet,
    double radiusMeter = 50,
  }) {
    final distance = Geolocator.distanceBetween(
      latitudeUser,
      longitudeUser,
      latitudeOutlet,
      longitudeOutlet,
    );
    return distance <= radiusMeter;
  }
}
