import 'package:fitnesstracker/decorations.dart';
import 'package:fitnesstracker/entities/client.dart';
import 'package:fitnesstracker/entities/profile.dart';
import 'package:fitnesstracker/entities/trainer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddClientPage<T extends Profile> extends StatefulWidget {
  final List<Client> listOfClientsUnderTrainer;
  final T user;
  AddClientPage({ Key key, this.listOfClientsUnderTrainer, this.user}) : super(key: key);

  @override
  _AddClientPageState createState() => new _AddClientPageState();
}

class _AddClientPageState<T extends Profile> extends State<AddClientPage> {
  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";

  List<Client> names = new List();
  List<Client> filteredNames = new List();

  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Search Client');

  _AddClientPageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this._getNames();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: _buildBar(context),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: _buildList(context),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      backgroundColor: Decorations.accentColour,
      centerTitle: true,
      title: _appBarTitle,
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    if (filteredNames == null) {
      // This is what we show while we're loading
      return new Container();
    }

    if (_searchText.isNotEmpty) {
      List<Client> tempList = new List();
      for(Client client in filteredNames) {
        client.fullName = client.firstName + " " + client.lastName;
        if(client.fullName.toLowerCase().contains(_searchText.toLowerCase()) || client.emailID.contains(_searchText)){
          tempList.add(client);
        }
      }
      filteredNames = tempList;

    }
    return ListView.builder(
      itemCount: names == null ? 0 : filteredNames.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
            title: Text(filteredNames.elementAt(index).firstName + " " + filteredNames.elementAt(index).lastName),
            subtitle: Text(filteredNames.elementAt(index).emailID),
            trailing: filteredNames.elementAt(index).isTrainerAssigned? Icon(Icons.check): Icon(null),
            onTap: () {
              setState(() {
                _addClient(filteredNames, index);
              });
            },
          )
        );
      },
    );
  }

  void _addClient(List<Client> filteredNames, int index) {
    Trainer trainer = widget.user as Trainer;
    if(!(widget.listOfClientsUnderTrainer.contains(filteredNames.elementAt(index)))) {
      //send a post request to the API to set the trainerId field for this client
      trainer.addClient(filteredNames.elementAt(index).emailID);
      filteredNames.elementAt(index).isTrainerAssigned = true;

      key.currentState.showSnackBar(
          SnackBar(
            content: Text(filteredNames.elementAt(index).firstName + " has been added"),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          )
      );
    }
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          style: TextStyle(color: Colors.white, fontSize: 18),
          controller: _filter,
          decoration: Decorations.searchBar
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Search Client');
        filteredNames = names;
        _filter.clear();
      }
    });
  }

  void _getNames() async {
    Trainer trainer = widget.user as Trainer;
    List<Client> tempList = new List();
    // call the API to get a list of all the clients not assigned to this trainer
     tempList = await trainer.getAllUnassignedClients();

     setState(() {
      names = tempList;
      names.shuffle();
      filteredNames = names;
    });
  }
}