import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jose_app/core/di/injection.dart';
import 'package:jose_app/features/schedule/presentation/bloc/schedule_bloc.dart';
import 'package:jose_app/features/schedule/presentation/pages/schedule_page.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ScheduleBloc>(create: (_) => getIt<ScheduleBloc>()),
      ],
      child: ShadApp(
        title: 'Schedule App',
        theme: ShadThemeData(
          brightness: Brightness.light,
          colorScheme: const ShadSlateColorScheme.light(),
        ),
        darkTheme: ShadThemeData(
          brightness: Brightness.dark,
          colorScheme: const ShadSlateColorScheme.dark(),
        ),
        themeMode: ThemeMode.system,
        home: const SchedulePage(),
      ),
    );
  }
}
