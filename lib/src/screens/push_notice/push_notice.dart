import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jb_notify/src/cubit/firebase_sign_in_cubit.dart';
import 'package:jb_notify/src/cubit/push_notices_cubit.dart';
import 'package:jb_notify/src/enums/notice_to.dart';
import 'package:jb_notify/src/model/notice_model.dart';
import 'package:jb_notify/src/repository/firebase_authentication.dart';
import 'package:jb_notify/src/repository/notices_repository.dart';
import 'package:path/path.dart' as p;

class PushNotice extends StatelessWidget {
  const PushNotice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PushNoticesCubit>(
          create: (context) {
            return PushNoticesCubit(
              noticeRepositories: NoticeRepositories(),
            );
          },
        ),
        BlocProvider<FirebaseSignInCubit>(create: (context) {
          return FirebaseSignInCubit(
            authServices: AuthenticationServices(),
          );
        })
      ],
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
  Future? databaseURL;
  String documentUrl = '';
   String fileName = '';

  String uid = '';
  NoticeTo noticeTo = NoticeTo.students;

  final _formKey = GlobalKey<FormState>();

  final FirebaseAuth auth = FirebaseAuth.instance;

  String getUID() {
    final User user = auth.currentUser!;
    final uid = user.uid;
    return uid;
  }

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
                    onPressed: () {
                      uploadFile();
                    },
                    child: const Text('Select File'),
                  )
                ],
              ),
              fileName.isEmpty ? Container() : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(fileName,),
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
                                documentUrl: documentUrl,
                                uid: getUID(),
                              ),
                              noticeTo: sendNoticeTo(),
                            );
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(
                        //       content: Text(
                        //           'Notice Pushed to ${sendNoticeTo()} Server ')),
                        // );
                        Fluttertoast.showToast(
                          msg: 'Notice Pushed to ${sendNoticeTo()} Server ',
                          textColor: Colors.white,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 2,
                        );
                        Navigator.of(context).pop();
                      } else {
                        Fluttertoast.showToast(
                          msg: 'Unable to push data',
                          textColor: Colors.white,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 2,
                        );

                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   const SnackBar(content: Text('Unable to push data')),
                        // );
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

  Future uploadFile() async {
    try {
      final pickFile =
          await FilePicker.platform.pickFiles(allowMultiple: false);
      if (pickFile == null) return;
      final filePath = pickFile.files.single.path;
      File file = File(filePath!);

      //Pushing file to firestore
      if (file == null) return;
      fileName = p.basename(file.path);
      setState(() {});
      final destination = 'files/$fileName';

      UploadTask? task =
          NoticeRepositories.uploadFile(destination: destination, file: file);

      final snapShot = await task!.whenComplete(() {});
      databaseURL = snapShot.ref.getDownloadURL();

      databaseURL?.then((value) {
        String? value1 = value;
        documentUrl = value1!;
      });
    } catch (e) {
      print('upload file error ${e.toString()}');
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
