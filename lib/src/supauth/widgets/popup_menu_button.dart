import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit.dart';

class AuthPopupMenuButton extends StatelessWidget {
  const AuthPopupMenuButton({
    super.key,
    required this.onSignOut,
    required this.onShowSignIn,
  });

  final void Function(BuildContext context) onSignOut;
  final void Function(BuildContext context) onShowSignIn;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SupabaseAuthCubit, SupabaseAuthState>(
      builder: (context, state) {
        final List<PopupMenuEntry<String>> items = [];

        if (state is SupabaseAuthAuthenticated) {
          // Display user information at the top
          items.add(
            PopupMenuItem<String>(
              enabled: false, // Disable the item to make it non-selectable
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(
                    state.user.email![0].toUpperCase(),
                    maxLines: 1,
                  ),
                ),
                title: Text(
                  state.user.id ?? 'No Name',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  state.user.email ?? 'No Email',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          );
          // Add a divider
          items.add(const PopupMenuDivider());

          // Add sign out item
          items.add(
            const PopupMenuItem(
              value: 'sign_out',
              child: Text('Sign out'),
            ),
          );
          // Add other items if necessary
          items.add(
            const PopupMenuItem(
              value: 'settings',
              child: Text('Settings'),
            ),
          );
        } else if (state is SupabaseAuthUnauthenticated) {
          // Add sign in item
          items.add(
            const PopupMenuItem(
              value: 'sign_in',
              child: Text('Sign in'),
            ),
          );
          // Add other items if necessary
          items.add(
            const PopupMenuItem(
              value: 'help',
              child: Text('Help'),
            ),
          );
        }

        return PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'sign_out') {
              onSignOut(context);
            } else if (value == 'sign_in') {
              onShowSignIn(context);
            }
            // Handle other items if necessary
          },
          itemBuilder: (context) => items,
        );
      },
    );
  }
}
