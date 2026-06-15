library login_library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../components/button/app_button.dart';
import '../../components/custom_painting/painter.dart';
import '../../components/form/app_form_prefix.dart';
import '../../domain/core/interfaces/login_repository.dart';
import '../../domain/core/model/model_requrest/login_request.dart';
import '../../domain/core/model/model_response/user_response.dart';
import '../../infrastructure/navigation/routes.dart';
import '../../infrastructure/theme/app_style.dart';
import '../../utils/app_preference/app_preferences.dart';
import '../../utils/app_preference/helper.dart';
import '../../utils/app_preference/secure_storage.dart';
import '../../utils/assets/assets_images.dart';
import '../../utils/assets/assets_svg.dart';
import '../../utils/network/action_status.dart';
import '../../utils/network/status_response.dart';
import 'repository/login_repository_impl.dart';

// Part Pages
part 'login.screen.dart';
part 'presentation/widget/polygon.dart';
part 'presentation/widget/form.dart';
part 'presentation/login.controller.dart';
part 'binding/login.controller.binding.dart';
