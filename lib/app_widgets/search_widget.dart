import 'package:flutter/material.dart';

class CitySearch extends SearchDelegate<String> {

  final List<String> searchList = [
    'Kolkata, India',
    'Hyderabad, India',
    'New Delhi, India',
    'Kerala, India',
    'Mumbai, India',
    'Khobar, Saudi Arabia',
    'Riyadh, Saudi Arabia',
    'Kuwait City, Kuwait',
    'Abu Dhabi, United Arab Emirates',
    'Dammam, Saudi Arabia',
    'Riyadh, Saudi Arabia',
    'Toronto, Canada',
    'London, United Kingdom',
    'Florida, United States',
    'New York, United States',
    'Tokyo, Japan',
    'Canberra, Australia',
    'Sydney, Australia',
    'Doha, Qatar',
  ];

  List<String> recentSearch = [
  ];

  @override
  // TODO: implement searchFieldLabel
  String get searchFieldLabel => 'Enter Country Name';

  @override
  ThemeData appBarTheme(BuildContext context) {
    // TODO: implement appBarTheme
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
      primaryColor: Colors.black38,
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.blue),
      primaryColorBrightness: Brightness.light,
      primaryTextTheme: theme.textTheme,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    final suggestions = query.isEmpty? searchList.toList()
    :searchList.where((c)=> c.toLowerCase().startsWith(query) || c.toLowerCase().contains(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) =>
          ListTile(
            leading: Icon(Icons.location_city),
            title: RichText(
              text: TextSpan(
                  text: suggestions[index].substring(0, query.length),
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: suggestions[index].substring(query.length),
                        style: TextStyle(color: Colors.grey)
                    )
                  ]
              ),
            ),
            onTap: (){
              query = suggestions[index];
              recentSearch.insert(0, query);
              close(context, query);
            },
          ),
      itemCount: suggestions.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    final suggestions = query.isEmpty ? searchList.toList()
        : searchList.where((c)=> c.toLowerCase().startsWith(query) || c.toLowerCase().contains(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) =>
          ListTile(
            leading: Icon(Icons.location_city),
            title: RichText(
              text: TextSpan(
                  text: suggestions[index].substring(0, query.length),
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: suggestions[index].substring(query.length),
                        style: TextStyle(color: Colors.grey)
                    )
                  ]
              ),
            ),
            onTap: (){
              query = suggestions[index];
              recentSearch.insert(0, query);
              close(context, query);
            },
          ),
      itemCount: suggestions.length,
    );
  }
}