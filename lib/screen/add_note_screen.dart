import 'package:flutter/material.dart';
import 'package:note_app/services/auth_services.dart';
import 'package:note_app/widgets/scaffold_message.dart';

import '../services/firestore_service.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(
                height: 35,
              ),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              TextField(
                controller: descriptionController,
                minLines: 5,
                maxLines: 10,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: loading
          ? const CircularProgressIndicator()
          : FloatingActionButton(
              onPressed: () async {
                if (titleController.text == "" ||
                    descriptionController.text == "") {
                  Utils.customMessage(
                      context, "All fields are required!", Colors.redAccent);
                } else {
                  setState(() {
                    loading = true;
                  });
                  await FirestoreService.insertNote(
                    AuthService.auth.currentUser!.uid,
                    titleController.text,
                    descriptionController.text,
                  );
                  setState(() {
                    loading = false;
                  });
                  Navigator.pop(context);
                }
              },
              child: const Icon(Icons.save),
            ),
    );
  }
}
