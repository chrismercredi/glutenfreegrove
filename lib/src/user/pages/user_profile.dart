import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../widgets/widgets.dart';
import '../../user/user.dart';

class UserProfile extends StatelessWidget {
  static const routeName = '/user/profile';

  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('user-profile-page'),
      appBar: AppBar(
        title: const Text('User Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Navigate to edit profile page or perform edit action
            },
          ),
          const Gap(8),
        ],
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded || state is ProfileUpdated) {
            final user = state is ProfileLoaded
                ? state.profile
                : (state as ProfileUpdated);
            return _buildProfile(context, state.props.first as ProfileModel);
          } else if (state is ProfileError) {
            return Center(child: Text('Error: ${state.message}'));
          }

          // Default to an initial empty state or placeholder
          return const Center(child: Text('No profile data'));
        },
      ),
    );
  }

  Widget _buildProfile(BuildContext context, ProfileModel user) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const MM(), // Your custom widget
            const Gap(16),
            CircleAvatar(
              backgroundImage: NetworkImage(user.avatarUrl ??
                  'https://via.placeholder.com/150'), // Default or placeholder avatar
              radius: 60,
            ),
            const Gap(16),
            Text(user.username,
                style: Theme.of(context).textTheme.headlineSmall),
            // ... other user details
            ElevatedButton(
              onPressed: () {
                // Perform logout or other action
              },
              style: Theme.of(context).blackSquareButtonStyle(),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
