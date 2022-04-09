import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: [
        DrawerHeader(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                child: Image.asset('lib/src/assets/images/JBnew.png'),
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
        Card(
          child: ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text(
              'Send Data',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: () {},
          ),
        ),
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
      ]),
    );
  }
}
