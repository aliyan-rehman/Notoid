import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/add_note_page.dart';
import 'package:notes_app/db_provider.dart';
import 'package:notes_app/theme_provider.dart';
import 'package:provider/provider.dart';

import 'data/local/db_helper.dart';

class NotesHomePage extends StatefulWidget {
  const NotesHomePage({super.key});

  @override
  State<NotesHomePage> createState() => _NotesHomePageState();
}

class _NotesHomePageState extends State<NotesHomePage> {
  bool isDarkMode = false;

  ///controllers
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<DBProvider>().getInitialNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes", style: TextStyle(color: Color(0xFFE8E2D8))),
        actions: [
          Consumer<ThemeProvider>(
            builder: (ctx, provider, __) {
              return Row(
                children: [
                  Icon(
                    provider.getThemeValue()
                        ? Icons.dark_mode
                        : Icons.light_mode,
                    color: Color(0xFFE8E2D8),
                  ),
                  SizedBox(width: 6),
                  Switch.adaptive(
                    onChanged: (value) {
                      provider.updateTheme(value: value);
                    },
                    value: provider.getThemeValue(),
                    activeColor: Theme.of(context).primaryColor,
                    activeTrackColor: Color(0xFFE8E2D8),
                    inactiveTrackColor: Theme.of(
                      context,
                    ).scaffoldBackgroundColor,
                    inactiveThumbColor: Theme.of(context).primaryColor,
                  ),
                  SizedBox(width: 10),
                ],
              );
            },
          ),
        ],
      ),

      /// all notes viewed here
      body: Consumer<DBProvider>(
        builder: (ctx, provider, __) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          List<Map<String, dynamic>> allNotes = provider.getNotes();

          return allNotes.isNotEmpty
              ? ListView.builder(
                  padding: EdgeInsets.only(bottom: 80),
                  itemCount: allNotes.length,
                  itemBuilder: (_, index) {
                    return ListTile(
                      // leading: Text("${allNotes[index][DBHelper.COLUMN_NOTE_SNO]}"),
                      leading: Text("${index + 1}"),
                      title: Text(
                        allNotes[index][DBHelper.COLUMN_NOTE_TITLE],
                        style: TextStyle(
                          color: context.read<ThemeProvider>().getThemeValue()
                              ? Colors.white
                              : Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        allNotes[index][DBHelper.COLUMN_NOTE_DESC],
                        style: TextStyle(
                          color: context.read<ThemeProvider>().getThemeValue()
                              ? Colors.white.withValues(alpha: 0.5)
                              : Colors.black.withValues(alpha: 0.5),
                          fontSize: 14,
                        ),
                      ),
                      trailing: SizedBox(
                        width: 65,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddNotePage(
                                      isUpdate: true,
                                      title:
                                          allNotes[index][DBHelper
                                              .COLUMN_NOTE_TITLE],
                                      desc:
                                          allNotes[index][DBHelper
                                              .COLUMN_NOTE_DESC],
                                      sno:
                                          allNotes[index][DBHelper
                                              .COLUMN_NOTE_SNO],
                                    ),
                                  ),
                                );
                              },
                              child: Icon(Icons.edit),
                            ),
                            SizedBox(width: 15),
                            InkWell(
                              onTap: () async {
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: Text("Delete  Note"),
                                    content: Text(
                                      "This action cannot be undone.",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(
                                            color:
                                                context
                                                    .read<ThemeProvider>()
                                                    .getThemeValue()
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          context.read<DBProvider>().deleteNote(
                                            allNotes[index][DBHelper
                                                .COLUMN_NOTE_SNO],
                                          );
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Delete",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Icon(Icons.delete, color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "No notes yet",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6F8F72),
                        ),
                      ),
                      Text(
                        "Tap + to add your first note",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          /// note to be added from here
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNotePage()),
          );
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        elevation: 10,
        backgroundColor: context.watch<ThemeProvider>().getThemeValue()
            ? Color(0xFF6F8F72)
            : Theme.of(context).primaryColor,
      ),
    );
  }
}
