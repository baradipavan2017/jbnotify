import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jb_notify/src/cubit/push_notices_cubit.dart';
import 'package:jb_notify/src/enums/notice_to.dart';
import 'package:jb_notify/src/model/notice_model.dart';
import 'package:jb_notify/src/repository/notices_repository.dart';

class PushNotice extends StatelessWidget {
  const PushNotice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PushNoticesCubit>(
      create: (context) {
        return PushNoticesCubit(
          noticeRepositories: NoticeRepositories(),
        );
      },
      child: const PushNoticeView(),
    );
  }
}

class PushNoticeView extends StatefulWidget {
  const PushNoticeView({Key? key}) : super(key: key);

  @override
  State<PushNoticeView> createState() => _PushNoticeViewState();
}

class _PushNoticeViewState extends State<PushNoticeView> {
  final database = FirebaseDatabase.instance.ref();

  final titleController = TextEditingController();
  final descController = TextEditingController();
  final urlController = TextEditingController();

  NoticeTo noticeTo = NoticeTo.students;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    BuildContext pushContext = context;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Push Notice'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Radio(
                          value: NoticeTo.students,
                          groupValue: noticeTo,
                          onChanged: (NoticeTo? value) {
                            setState(() {
                              noticeTo = value!;
                            });
                          }),
                      const Text('Students'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                          value: NoticeTo.faculty,
                          groupValue: noticeTo,
                          onChanged: (NoticeTo? value) {
                            setState(() {
                              noticeTo = value!;
                            });
                          }),
                      const Text('Faculty')
                    ],
                  )
                ],
              ),
              TextFormField(
                controller: titleController,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.characters,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter title';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  label: Text('Enter Title'),
                  hintText: 'Enter your notice title',
                ),
              ),
              TextFormField(
                controller: descController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter description';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  label: Text('Enter Description'),
                  hintText: 'Enter your notice description',
                ),
              ),
              TextFormField(
                controller: urlController,
                initialValue: null,
                keyboardType: TextInputType.url,
                decoration: const InputDecoration(
                  label: Text('Enter Url'),
                  hintText: 'Enter your link',
                ),
              ),
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Upload your Document'),
                  ElevatedButton(
                      onPressed: () {}, child: const Text('Select File'))
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    try {
                      if (_formKey.currentState!.validate()) {
                        pushContext.read<PushNoticesCubit>().pushNotice(
                              notice: Notice(
                                title: titleController.value.text,
                                description: descController.value.text,
                                url: urlController.value.text,
                                dateTime: DateTime.now().toString(),
                                documentUrl: urlController.value.text,
                              ),
                              noticeTo: sendNoticeTo(),
                            );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Notice Pushed to Server')),
                        );
                        Navigator.popAndPushNamed(context, '/navigation');
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Unable to push data')),
                        );
                      }
                    } catch (e) {
                      print(e.toString());
                    }

                  },
                  child: const Text('Push Notice'))
            ],
          ),
        ),
      ),
    );
  }

  String sendNoticeTo() {
    if (noticeTo == NoticeTo.students) {
      return '/student';
    } else {
      return '/faculty';
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    urlController.dispose();
    descController.dispose();
    super.dispose();
  }
}
// database.child('/newDatabase').set({
//   'title': titleController.value.text,
//   'description': descController.value.text,
//   'dateTime': DateTime.now().toString(),
//   'url': urlController.value.text,
// });
