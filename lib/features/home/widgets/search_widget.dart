import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchWidget extends StatefulWidget {
  final Function(String, String) onAddFlashcard;

  const SearchWidget({required this.onAddFlashcard, Key? key})
      : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController _searchController = TextEditingController();
  String _searchResult = '';
  bool _isLoading = false;

  Future<void> _searchWord() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(
      Uri.parse(
          'https://api.dictionaryapi.dev/api/v2/entries/en/${_searchController.text}'),
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      print('data: ${data} ');
      final String meaning =
          data[0]['meanings'][0]['definitions'][0]['definition'];
      print('meaning: ${meaning}');

      setState(() {
        _searchResult = meaning;
        _isLoading = false;
      });
    } else {
      setState(() {
        _searchResult = 'Word not found';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Search Word'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Search Word',
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: _searchWord,
              ),
            ),
          ),
          SizedBox(height: 10),
          _isLoading
              ? CircularProgressIndicator()
              : _searchResult.isNotEmpty
                  ? Column(
                      children: [
                        Text(
                          _searchResult,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            widget.onAddFlashcard(
                                _searchController.text, _searchResult);
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: Text('Add to Flashcards'),
                        ),
                      ],
                    )
                  : Container(),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
