part of main_lib;

class MainPagesController extends GetxController {
  var selectedIndex = 0;
  TextEditingController addNameController = TextEditingController();
  bool isNameOutletAvailable = false;
  UserResponse? getUserData;

  double latitude = 0.0;
  double longitude = 0.0;
  Set<Marker> markers = {}; //markers for google map
  bool isLoading = false;
  BitmapDescriptor? _startMarkerIcon;
  String address = "";
  String posCode = "";
  String label = "";
  var actionStatus = ActionStatus.initalize;

  List<Widget> listPages = [
    const HomeScreen(),
    Container(),
    const SettingScreen(),
  ];

  @override
  void onInit() {
    getUserData = AppPreference().getUserData();
    createStartMarkerImageFromAsset(Get.context!);
    initData();
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

  Future<void> initData() async {
    isLoading = true;
    update();
    await initGeolocation();
    await getAddressFromCoordinates(latitude, longitude);
    await addMaker();
    isLoading = false;
    update();
  }

  void updateStartBitmap(BitmapDescriptor bitmap) {
    _startMarkerIcon = bitmap;
    update();
  }

  void changeTabIndex(int index) {
    if (index == 1) {
      addOutlet();
    } else {
      selectedIndex = index;
      update();
    }
  }

  void addOutlet() {
    CustomBottomSheet.show(
        child: const AddOutletScreen(),
        onCompleted: () {
          isNameOutletAvailable = false;
          addNameController.clear();
          update();
        });
  }

  void onChangeNameOutlet(String value) {
    if (value.isEmpty) {
      isNameOutletAvailable = false;
    } else {
      isNameOutletAvailable = true;
    }
    update();
  }

  Future<void> submitAddOutlet() async {
    try {
      actionStatus = ActionStatus.loading;
      Get.closeAllSnackbars();
      final isExists = await localStorage.isOutletNameExists(
        userId: getUserData!.id!,
        nameOutlet: addNameController.text.trim(),
      );
      if (isExists) {
        AppSnackbar.show(
            message: 'outlet_exist'.tr, onTop: true, type: SnackType.error);
      } else {
        var body = LocalOutlet(
            userId: getUserData?.id,
            latitude: latitude.toString(),
            longitude: longitude.toString(),
            nameOutlet: addNameController.text.trim().toLowerCase(),
            address: address);

        await localStorage.insertLocalOutlet(body);
        if (Get.isRegistered<HomeController>()) {
          Get.find<HomeController>().getListOutlet();
        }
        actionStatus = ActionStatus.success;
        Get.back();
      }
    } catch (_) {
    } finally {
      actionStatus = ActionStatus.success;
    }
  }

  Future<bool> showExitDialog() async {
    final result = await AlertModel.showAlert(
        title: 'exit'.tr,
        message: 'exit_app_confirmation'.tr,
        mainColor: AppStyle.progressBarBottomBlue,
        hoverColor: AppStyle.progressBarTopBlue,
        buttonText: 'yes'.tr,
        onPressed: () => Get.back(result: true));

    return result ?? false;
  }

  // ===================== Google Maps
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

      if ((newLat - latitude).abs() > threshold ||
          (newLng - longitude).abs() > threshold) {
        latitude = newLat;
        longitude = newLng;

        update();
      } else {}
    } catch (_) {}
  }

  Future<void> getAddressFromCoordinates(double lat, double long) async {
    try {
      final List<Placemark> placemarks = await placemarkFromCoordinates(
        lat,
        long,
      );

      if (placemarks.isNotEmpty) {
        final Placemark placemark = placemarks[0];
        posCode = placemark.postalCode ?? "";
        label =
            "${placemark.thoroughfare == '' ? placemark.locality : placemark.thoroughfare}";

        address = [
          placemark.street,
          placemark.subLocality,
          placemark.locality,
          placemark.thoroughfare,
          placemark.subAdministrativeArea,
          placemark.administrativeArea,
          placemark.postalCode,
        ].where((e) => e != null && e.isNotEmpty).join(', ');
        update();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> addMaker() async {
    markers.add(Marker(
      markerId: const MarkerId('start-maker'),
      position: LatLng(latitude, longitude),
      infoWindow: const InfoWindow(
        title: 'Starting Point ',
        snippet: 'Start Marker',
      ),
      icon: _startMarkerIcon!,
    ));
  }
}
