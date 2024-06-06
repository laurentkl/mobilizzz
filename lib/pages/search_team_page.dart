import 'package:flutter/material.dart';

class SearchTeamPage extends StatefulWidget {
  const SearchTeamPage({Key? key}) : super(key: key);

  @override
  _SearchTeamPageState createState() => _SearchTeamPageState();
}

class _SearchTeamPageState extends State<SearchTeamPage> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Team'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search team...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Search Results for: $_searchQuery',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10, // Replace this with your actual search results count
                itemBuilder: (context, index) {
                  // Replace this with your search result item widget
                  return ListTile(
                    title: Text('Search Result ${index + 1}'),
                    subtitle: Text('Description of search result ${index + 1}'),
                    onTap: () {
                      // Handle tap on search result
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
