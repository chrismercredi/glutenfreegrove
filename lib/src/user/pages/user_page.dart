import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../user.dart';
// Import the UserProfile widget

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  static const routeName = '/user';

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ProfileRepository>(
      create: (context) => ProfileRepository(),
      child: BlocProvider<ProfileCubit>(
        create: (context) =>
            ProfileCubit(repository: context.read<ProfileRepository>()),
        child: const UserProfile(),
      ),
    );
  }
}
