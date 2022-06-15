import 'package:flutter/material.dart';
import 'package:jb_notify/src/widgets/alert_dialog.dart';
import 'package:jiffy/jiffy.dart';
import 'package:url_launcher/url_launcher.dart';

class MyNoticeListTile extends StatelessWidget {
  const MyNoticeListTile({
    Key? key,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.url,
    required this.docUrl,
  }) : super(key: key);

  final String title;
  final String description;
  final String url;
  final String docUrl;
  final String dateTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                const CustomAlertDialog());
                      },
                      child: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ))
                ],
              ),
              const SizedBox(
                height: 3.0,
              ),
              Text(Jiffy(dateTime).yMMMdjm),
              const SizedBox(height: 5.0),
              Text(
                description,
                style: const TextStyle(fontSize: 17.0),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              url == ""
                  ? Container()
                  : TextButton.icon(
                      onPressed: () {
                        _launchUrl(context, url);
                      },
                      icon: const Icon(Icons.link),
                      label: const Text('Open Link'),
                    ),
              docUrl == ""
                  ? Container()
                  : TextButton.icon(
                      onPressed: () {
                        _launchUrl(context, docUrl);
                      },
                      icon: const Icon(Icons.pageview),
                      label: const Text("Open Document"),
                    )
            ],
          ),
          // const SizedBox(height: 8.0),
          const Divider()
        ],
      ),
    );
  }

  void _launchUrl(BuildContext context, String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to launch url'),
        ),
      );
    }
  }
}
