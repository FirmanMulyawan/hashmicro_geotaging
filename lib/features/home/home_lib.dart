library home_lib;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hashmicro/utils/extension/responsive_size.dart';
import 'package:image_picker/image_picker.dart';

import '../../components/card/card_image.dart';
import '../../components/widget/app_loading.dart';
import '../../components/widget/app_snackbar.dart';
import '../../components/widget/load_pages.dart';
import '../../components/widget/parent_scaffold.dart';
import '../../components/widget/popup_button.dart';
import '../../components/widget/responsive_layout.dart';
import '../../domain/core/model/model_response/user_response.dart';
import '../../infrastructure/theme/app_style.dart';
import '../../utils/app_preference/app_preferences.dart';
import '../../utils/assets/assets_images.dart';
import '../../utils/local_storage/entity/outlet_entity.dart';
import '../../utils/local_storage/objectbox.dart';
import '../../utils/network/screen_status.dart';
import '../../utils/extension/string_ext.dart';

part 'presentation/home_controller.dart';
part 'binding/home_binding.dart';
part 'home_screen.dart';
part 'presentation/widget/header_home_section.dart';
part 'presentation/widget/list_outlet_section.dart';
