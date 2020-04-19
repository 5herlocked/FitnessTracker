import 'package:fitnesstracker/decorations.dart';
import 'package:fitnesstracker/entities/client.dart';
import 'package:fitnesstracker/entities/testEntities.dart';
import 'package:flutter/material.dart';

class AddClientPage extends StatefulWidget {
  List<Client> listOfClientsUnderTrainer;
  AddClientPage({ Key key, this.listOfClientsUnderTrainer}) : super(key: key);

  @override
  __AddClientPageState createState() => new __AddClientPageState();
}

class __AddClientPageState extends State<AddClientPage> {
  // final formKey = new GlobalKey<FormState>();
  // final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  List<Client> names = new List();
  List<Client> filteredNames = new List();
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Search Client');

  __AddClientPageState() {
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
    this._getNames();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: _buildList(),
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

  Widget _buildList() {
    if (_searchText.isNotEmpty) {
      List<Client> tempList = new List();
      for(Client client in filteredNames) {
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
            title: Text(filteredNames.elementAt(index).fullName),
            onTap: () {
              _addClient(filteredNames, index);
            },
          )
        );
      },
    );
  }


  void _addClient(List<Client> filteredNames, int index) {
    if(!(widget.listOfClientsUnderTrainer.contains(filteredNames.elementAt(index))))
      widget.listOfClientsUnderTrainer.add(filteredNames.elementAt(index));

    //send a post request to the API to set the trainerId field for this client

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
    List tempList = new List();
    // call the API to get a list of all the clients not assigned to this trainer
    // getAllUnassignedClients()
    tempList = TestEntities.testClientListAll;
    setState(() {
      names = tempList;
      names.shuffle();
      filteredNames = names;
    });
  }
}