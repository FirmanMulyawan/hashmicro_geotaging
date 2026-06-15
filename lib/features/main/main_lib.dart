library main_lib;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../components/form/app_form.dart';
import '../../components/widget/app_bottom_sheet.dart';
import '../../components/widget/app_snackbar.dart';
import '../../components/widget/show_bottom_sheet.dart';
import '../../domain/core/model/model_response/user_response.dart';
import '../../infrastructure/theme/app_style.dart';
import '../../utils/app_preference/app_preferences.dart';
import '../../utils/app_preference/helper.dart';
import '../../utils/assets/assets_images.dart';
import '../../utils/assets/assets_svg.dart';
import '../../utils/local_storage/entity/outlet_entity.dart';
import '../../utils/local_storage/objectbox.dart';
import '../../utils/network/action_status.dart';
import '../home/home_lib.dart';
import '../setting/setting_lib.dart';

part 'main.screen.dart';
part 'presentation/main.controller.dart';
part 'binding/main_binding.dart';
part 'presentation/widget/add_outlet.screen.dart';
part 'presentation/widget/google_maps_tracking.dart';
