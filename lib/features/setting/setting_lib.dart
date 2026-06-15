library setting_lib;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../components/card/card_image.dart';
import '../../components/widget/app_bottom_sheet.dart';
import '../../components/widget/show_bottom_sheet.dart';
import '../../domain/core/interfaces/user_repository.dart';
import '../../domain/core/model/model_response/user_profile_response.dart';
import '../../domain/core/model/model_response/user_response.dart';
import '../../infrastructure/dal/daos/provider/endpoint/endpoint.dart';
import '../../infrastructure/dal/daos/provider/remote/remote_provider.dart';
import '../../infrastructure/navigation/routes.dart';
import '../../infrastructure/theme/app_style.dart';
import '../../utils/app_preference/app_preferences.dart';
import '../../utils/app_preference/helper.dart';
import '../../utils/app_preference/secure_storage.dart';
import '../../utils/assets/assets_images.dart';
import '../../utils/assets/assets_svg.dart';
import '../../utils/network/code_response.dart';
import '../../utils/network/custom_exception.dart';
import '../../utils/network/data_state.dart';
import '../../utils/network/status_response.dart';

part 'setting.screen.dart';
part 'presentation/widget/app_bar_setting.dart';
part 'repository/setting_repository_impl.dart';
part 'presentation/widget/profile.dart';
part 'presentation/widget/settings.dart';
part 'presentation/setting.controller.dart';
part 'presentation/widget/detail_user.dart';
