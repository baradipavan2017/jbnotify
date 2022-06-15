import 'package:flutter/material.dart';
import 'package:jb_notify/src/enums/user_type.dart';
import 'package:jb_notify/src/repository/firebase_authentication.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key, required this.userType}) : super(key: key);
  final UserType userType;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: [
        DrawerHeader(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                child: Image.asset('lib/assets/images/JBnew.png'),
                backgroundColor: Colors.transparent,
                radius: 40.0,
              ),
              const Text(
                'JB-Notify',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        ),
        userType == UserType.faculty
            ? ListTile(
                leading: const Icon(Icons.notifications),
                title: const Text(
                  'My Notices',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/my_notice_screen');
                },
              )
            : Container(),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.book_online),
          title: const Text(
            'Prev Question Paper',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          onTap: () {},
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.book),
          title: const Text(
            'Notes',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          onTap: () {},
        ),
        const Divider(),
        userType == UserType.faculty ?
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text(
            'Logout',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          onTap: () {
            AuthenticationServices().logout();
            Navigator.pushReplacementNamed(context, '/welcome_screen');
          },
        ) : Container(),
      ]),
    );
  }
}
