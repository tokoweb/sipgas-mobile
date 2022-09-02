import 'package:core/bloc/bloc.dart';
import 'package:core/cubit/cubit.dart';
import 'package:core/di/injection_container.dart';
import 'package:core/network/api_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sipgas/cubit/load_tube_type_driver_cubit.dart';
import 'package:sipgas/cubit/page_cubit.dart';
import 'package:sipgas/cubit/stock_tube_type_cubit.dart';
import 'package:sipgas/cubit/stock_tube_type_filling_staf_cubit.dart';
import 'package:sipgas/cubit/travel_doc_type_cubit.dart';
import 'package:sipgas/shared/shared.dart';
import 'package:sipgas/ui/pages/pages.dart';
import 'package:jiffy/jiffy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init(ApiConstant.baseUrlDev);
  await Jiffy.locale("id");

  // await PusherBeams.instance.start(StringConst.beemsToken);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PageCubit()),
        BlocProvider(create: (context) => TravelDocTypeCubit()),
        BlocProvider(create: (context) => StockTubeTypeCubit()),
        BlocProvider(create: (context) => LoadTubeTypeDriverCubit()),
        BlocProvider(create: (context) => StockTubeTypeFillingStafCubit()),
        BlocProvider(
          create: (context) => inject<LoginCubit>(),
        ),
        BlocProvider(
          create: (context) => inject<UpdateProfileCubit>(),
        ),
        BlocProvider(
          create: (context) => inject<ProfileBloc>()
            ..add(FetchProfileEvent())
            ..add(FetchAppSettingEvent()),
        ),
        BlocProvider(
          create: (context) => inject<TravelDocBloc>()
            ..add(FetchFiltersEvent())
            ..add(FetchDropdownDriverEvent()),
        ),
        BlocProvider(
          create: (context) => inject<TubeBloc>()
            ..add(GetListTubeScanEvent())
            ..add(FetchDropdownTubeEvent()),
        ),
        BlocProvider(
          create: (context) => inject<NotifBloc>()
            ..add(FetchSummaryNotifEvent())
            ..add(FetchNotifEvent()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sipgas',
        theme: ThemeData(
          primaryColor: kPrimaryColor,
        ),
        home: const SplashPage(),
      ),
    );
  }
}
