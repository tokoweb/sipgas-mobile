import 'dart:io';

import 'package:core/bloc/bloc.dart';
import 'package:core/di/injection_container.dart';
import 'package:core/repository/local/shared/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sipgas/cubit/stock_tube_type_cubit.dart';
import 'package:sipgas/cubit/travel_doc_type_cubit.dart';
import 'package:sipgas/shared/shared.dart';
import 'package:provider/provider.dart';
import 'package:sipgas/ui/pages/pages.dart';
import 'package:sipgas/utils/next_screen.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:data/response/response.dart';
import 'package:jiffy/jiffy.dart';
import 'package:data/dao/tube_dao.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sipgas/cubit/load_tube_type_driver_cubit.dart';
import 'package:sipgas/cubit/stock_tube_type_filling_staf_cubit.dart';
import 'package:carousel_slider/carousel_slider.dart';

// ALert
part 'alert/error_dialog.dart';
part 'alert/flusbar.dart';

// Textfield
part 'textfield/custom_textfield.dart';
part 'textfield/custom_textfield_border.dart';
part 'textfield/custom_textfield_pink.dart';
part 'textfield/custom_textarea.dart';

// Appbar
part 'appbar/custom_appbar.dart';
part 'appbar/custom_appbar_detail.dart';
part 'appbar/custom_appbar_icon.dart';
part 'appbar/custom_appbar_search.dart';
part 'appbar/custom_appbar_travel_doc.dart';
part 'appbar/custom_appbar_detail_tube.dart';

// Button
part 'button/button_primary.dart';
part 'button/custom_botton.dart';
part 'button/custom_button_scan.dart';

// Tube
part 'tube/stock_tube_item.dart';
part 'tube/stock_tube_type.dart';
part 'tube/tube_item.dart';
part 'tube/filter_tube_action.dart';
part 'tube/load_tube_driver_type.dart';
part 'tube/stock_tube_filling_staf_type.dart';
part 'tube/stock_tube_filling_item.dart';

// Travel Doc
part 'travel_doc/travel_doc_item.dart';
part 'travel_doc/travel_doc_type.dart';

// Image
part 'image/image_picker_item.dart';
part 'image/image_fullscreen.dart';
part 'image/image_fullscreen_url.dart';

// Dialog
part 'dialog/alert_dialog.dart';

// Profile
part 'profile/profile_item.dart';

// Inventoru
part 'inventory/inventory_item.dart';

// Scan
part 'scan/scan_item.dart';
part 'scan/scan_stock_tube_item.dart';

// Bottom sheet
part 'bottom_sheet/bottom_sheet.dart';

// Login
part 'login/login_item.dart';

// Notes
part 'notes/note_item.dart';

part 'notif/notif_item.dart';
