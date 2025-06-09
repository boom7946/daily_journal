import 'dart:io';

import 'package:daily_journal/components/image_field.dart';
import 'package:daily_journal/components/popup_button.dart';
import 'package:daily_journal/constants/enum.dart';
import 'package:daily_journal/model/journal_entry.dart';
import 'package:daily_journal/view_model/journal_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AddEditScreen extends StatefulWidget {
  final JournalEntry? entry;

  const AddEditScreen({super.key, this.entry});

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _content;
  File? _image;
  final List<String> availableTags = ['Work', 'Personal', 'Travel', 'Health'];
  List<String> selectedTags = [];
  @override
  void initState() {
    super.initState();
    _title = widget.entry?.title ?? '';
    _content = widget.entry?.content ?? '';
    widget.entry?.tagList?.forEach((tag) {
      if (availableTags.contains(tag)) {
        selectedTags.add(tag);
      }
    });
  }

  void _saveEntry(String type) {
    final journalProvider =
        Provider.of<JournalViewModel>(context, listen: false);
    if (type == JournalStatus.PUBLISHED) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        // If you want to handle the entry creation or update logic, you can do it here
        if (widget.entry == null) {
          journalProvider.addEntry(JournalEntry(
            title: _title,
            content: _content,
            date: DateTime.now(),
            status: type,
            filePath: _image?.path ?? "",
            tagList: selectedTags.isNotEmpty ? selectedTags : [],
          ));
          debugPrint(journalProvider.toString());
        } else {
          // debugPrint('Updating entry with title: $_title');
          journalProvider.updateEntry(widget.entry!, _title, _content,
              status: type,
              tagList: selectedTags.isNotEmpty ? selectedTags : []);
        }

        Navigator.pop(context);
      }
    } else if (type == JournalStatus.DRAFT) {
      _formKey.currentState!.save();
      if (widget.entry == null) {
        journalProvider.addEntry(JournalEntry(
            title: _title,
            content: _content,
            date: DateTime.now(),
            status: type,
            filePath: _image?.path ?? "",
            tagList: selectedTags.isNotEmpty ? selectedTags : []));
        debugPrint(journalProvider.toString());
      }
      Navigator.pop(context);
    } else {
      debugPrint('Saving entry with type: $type');
      _formKey.currentState!.save();
      if (widget.entry == null) {
        journalProvider.addEntry(JournalEntry(
            title: _title,
            content: _content,
            date: DateTime.now(),
            status: type));
      } else {
        journalProvider.updateEntry(widget.entry!, _title, _content,
            tagList: selectedTags.isNotEmpty ? selectedTags : []);
      }

      Navigator.pop(context);
    }
  }

  void setImageSelect(File image) {
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.entry != null;
    return Container(
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.entry != null ? "Edit Journal" : "New Journal",
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 24),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: _title,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: "Title",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                          color: Colors.black, width: 2), // Focused border
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                          color: Colors.black, width: 2), // Default border
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),

                  // inputFormatters: [],
                  validator: (value) => value == null || value.isEmpty
                      ? 'Title is required'
                      : null,
                  onSaved: (value) => _title = value!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: _content,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: "Content",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                          color: Colors.black, width: 2), // Focused border
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                          color: Colors.black, width: 2), // Default border
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  maxLines: 6,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Content is required'
                      : null,
                  onSaved: (value) => _content = value!,
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 8,
                  children: availableTags.map(
                    (tag) {
                      return FilterChip(
                          selectedColor: Colors.blue.shade100,
                          label: Text(tag),
                          onSelected: (isSelected) {
                            setState(() {
                              if (isSelected) {
                                selectedTags.add(tag);
                              } else {
                                selectedTags.remove(tag);
                              }
                            });
                          },
                          selected: selectedTags.contains(tag));
                    },
                  ).toList(),
                ),
                ImageField(
                  onImageSelected: setImageSelect,
                ),
                const SizedBox(
                  height: 16,
                ),
                CreateTaskButton(
                  onPress: _saveEntry,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
