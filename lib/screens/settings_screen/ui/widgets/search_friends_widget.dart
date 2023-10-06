import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mushroom_friends/screens/settings_screen/domain/friend_model.dart';
import 'package:mushroom_friends/screens/settings_screen/ui/bloc/settings_screen_bloc.dart';
import 'package:mushroom_friends/generated/l10n.dart';

class SearchFriendWidget extends StatelessWidget {
  const SearchFriendWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      child: Column(
        children: [
          _TextFieldWidget(),
          SizedBox(height: 30),
          _FriendList(),
        ],
      ),
    );
  }
}

class _TextFieldWidget extends StatefulWidget {
  const _TextFieldWidget({super.key});

  @override
  State<_TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<_TextFieldWidget> {
  final TextEditingController _iDController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _iDController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(20, 56, 64, 1),
        border: Border.all(),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          _IdTextField(iDController: _iDController),
          _NameTextField(
              nameController: _nameController, iDController: _iDController)
        ],
      ),
    );
  }
}

class _NameTextField extends StatelessWidget {
  const _NameTextField({
    super.key,
    required TextEditingController nameController,
    required TextEditingController iDController,
  })  : _nameController = nameController,
        _iDController = iDController;

  final TextEditingController _nameController;
  final TextEditingController _iDController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextField(
        controller: _nameController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(5),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(22)),
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(22)),
            borderSide: BorderSide(color: Colors.blue, width: 4),
          ),
          filled: true,
          fillColor: Colors.white70,
          hintText: S.of(context).textFieldHintFriendName,
          hintStyle: const TextStyle(color: Colors.grey),
          suffixIcon: ElevatedButton(
            style: const ButtonStyle(
              side: MaterialStatePropertyAll(
                BorderSide(
                  color: Colors.orangeAccent,
                  width: 5,
                ),
              ),
            ),
            onPressed: () {
              context.read<SettingsScreenBloc>().add(AddFriendToFriendList(
                  friendModel: FriendModel(
                      id: _iDController.text,
                      name: _nameController.text,
                      isShowed: true)));
              _iDController.clear();
              _nameController.clear();
            },
            child: Text(S.of(context).addFriendButtonTitle),
          ),
        ),
      ),
    );
  }
}

class _IdTextField extends StatelessWidget {
  const _IdTextField({
    super.key,
    required TextEditingController iDController,
  }) : _iDController = iDController;

  final TextEditingController _iDController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextField(
        controller: _iDController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(5),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(23)),
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(23)),
            borderSide: BorderSide(color: Colors.blue, width: 4),
          ),
          filled: true,
          fillColor: Colors.white70,
          hintText: S.of(context).textFieldHintFriendId,
          hintStyle: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}

class _FriendList extends StatelessWidget {
  const _FriendList({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsScreenBloc bloc = context.read<SettingsScreenBloc>();

    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(20, 56, 64, 1),
          border: Border.all(),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: BlocBuilder<SettingsScreenBloc, SettingsScreenState>(
          builder: (context, state) {
            if (state is SettingsScreenInitial) {
              bloc.add(LoadFriendList());
              return const Center(
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (state is Loaded) {
              return ListView.separated(
                itemCount: state.friendList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                    onDismissed: (direction) {
                      bloc.add(DeleteFriendFromFriendList(
                          id: state.friendList[index].id));
                    },
                    key: UniqueKey(),
                    child: ListTile(
                      title: Text(
                        state.friendList[index].name,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      subtitle: Text(state.friendList[index].id,
                          style: Theme.of(context).textTheme.titleSmall,
                          overflow: TextOverflow.ellipsis),
                      leading: Checkbox(
                        value: state.friendList[index].isShowed ? true : false,
                        onChanged: (bool? value) {
                          bloc.add(CheckboxClick(index: index));
                        },
                        checkColor: Colors.white,
                        activeColor: Colors.blue,
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Container(height: 2, color: Colors.orangeAccent);
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
