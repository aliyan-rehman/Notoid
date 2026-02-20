import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/db_provider.dart';
import 'package:notes_app/theme_provider.dart';
import 'package:notes_app/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class AddNotePage extends StatefulWidget {
  String title;
  String desc;
  int sno;
  bool isUpdate;

  // DBHelper? dbRef = DBHelper.getInstance;

  AddNotePage({
    this.title = "",
    this.desc = "",
    this.sno = 0,
    this.isUpdate = false,
  });

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  void dispose(){
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isUpdate) {
      titleController.text = widget.title;
      descController.text = widget.desc;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isUpdate ? "Update Note" : "New Note",
          style: TextStyle(
            color: Color(0xFFE8E2D8)
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(11.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 21),
                CustomTextField(
                  hint: "Enter Title Here",
                  label: "Title",
                  controller: titleController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Title is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 11),
                CustomTextField(
                  hint: "Enter Description Here",
                  label: "Description",
                  maxLines: 4,
                  controller: descController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Description is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 11),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color:
                                context.watch<ThemeProvider>().getThemeValue()
                                ? Colors.white
                                : Colors.black,
                            width: 1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),
                        onPressed: () async {
                          var title = titleController.text;
                          var desc = descController.text;

                          if (_formKey.currentState!.validate()) {
                            if (widget.isUpdate) {
                              context.read<DBProvider>().updateNote(
                                title,
                                desc,
                                widget.sno,
                              );
                            } else {
                              context.read<DBProvider>().addNote(title, desc);
                            }
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          widget.isUpdate ? "Update Note" : "Save",
                          style: TextStyle(
                            color: context.read<ThemeProvider>().getThemeValue()
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 11),
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: context.read<ThemeProvider>().getThemeValue()
                                ? Colors.white
                                : Colors.black,
                            width: 1,
                          ),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Discard",
                          style: TextStyle(
                            color: context.read<ThemeProvider>().getThemeValue()
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 11),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
