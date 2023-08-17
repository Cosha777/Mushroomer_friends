import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mushroom_friends/screens/auth_screen/data/repositories/firebase_auth_service.dart';
import 'package:mushroom_friends/screens/settings_screen/data/data_base_service.dart';
import 'package:mushroom_friends/screens/settings_screen/data/local_data_source.dart';
import 'package:mushroom_friends/screens/settings_screen/ui/bloc/settings_screen_bloc.dart';
import 'package:mushroom_friends/screens/settings_screen/ui/widgets/search_friends_widget.dart';
import 'package:mushroom_friends/screens/settings_screen/ui/widgets/settings_widget.dart';
import 'package:mushroom_friends/generated/l10n.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  static final List<Widget> _widgetOptions = <Widget>[
    const SearchFriendWidget(),
    SettingsWidget(LocalDataSourceSharedPref()),
  ];

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsScreenBloc>(
      create: (context) =>
          SettingsScreenBloc(SettingsFireStoreService(), FireBaseAuthService()),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: const BackButton(color: Colors.white),
            title: Text(S.of(context).appBarTitle),
            actions: const [_LogOutButton()],
          ),
          body: SettingsScreen._widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(
                  icon: const Icon(Icons.people),
                  label:
                      S.of(context).bottomNavigationBarItemLabelSearchFriend),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.settings),
                  label: S.of(context).bottomNavigationBarItemLabelSettings),
            ],
          ),
        ),
      ),
    );
  }
}

class _LogOutButton extends StatelessWidget {
  const _LogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SettingsScreenBloc>();
    return IconButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return _DialogWidget(bloc: bloc);
            });
      },
      icon: const Icon(
        Icons.logout_sharp,
        color: Colors.white,
      ),
    );
  }
}

class _DialogWidget extends StatelessWidget {
  const _DialogWidget({super.key, required this.bloc});

  final SettingsScreenBloc bloc;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        S.of(context).logOutAlertDialogTitle,
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(
            onPressed: () {
              bloc.add(LogOutAcceptClick());
            },
            child: Text(S.of(context).logOutAlertDialogAccept,
                style: const TextStyle(color: Colors.blue))),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(S.of(context).logOutAlertDialogCancel,
                style: const TextStyle(color: Colors.redAccent))),
      ],
    );
  }
}
