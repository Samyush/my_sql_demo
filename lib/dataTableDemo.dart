import 'package:flutter/material.dart';

import 'Employee.dart';
import 'Services.dart';

class DataTableDemo extends StatefulWidget {
  DataTableDemo() : super();
  final String title = 'Flutter Data Table';

  @override
  _DataTableDemoState createState() => _DataTableDemoState();
}

class _DataTableDemoState extends State<DataTableDemo> {
  List<Employee> _employee;
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController
      _firstNameController; //controller for hte First Name TextField
  TextEditingController
      _lastNameController; //controller for hte First Name TextField
  Employee _selectedEmployee;
  bool _isUpdating;
  String _titleProgress;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _employee = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey(); //key to get the context to show a snakBar
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
  }

//  method to update tittle in the APP BAR  Title
  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _showSnackBar(context, message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  createTables() {
    _showProgress('creating table...');
    Services.createTable().then((result) {
      if ('success_good' == result) {
//        table is create successfully
        _showSnackBar(context, result);
        _showProgress(widget.title);
      }
    });
  }

  _addEmployee() {
//
  }

  _getEmployee() {
//
  }

  _updateEmployee() {
//
  }

  _deleteEmployee() {
//
  }

//  method to clear TextField values
  _clearValues() {
    _firstNameController.text = '';
    _lastNameController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_titleProgress), //we show the process in the title
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              createTables();
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _getEmployee();
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _firstNameController,
                decoration: InputDecoration.collapsed(
                  hintText: 'First Name',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _lastNameController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Last Name',
                ),
              ),
            ),
//            adding update button and Cancel button
//          show these button only when updating an employee
            _isUpdating
                ? Row(
                    children: <Widget>[
                      OutlineButton(
                        child: Text("UPDATE"),
                        onPressed: () {
                          _updateEmployee();
                        },
                      ),
                      OutlineButton(
                        child: Text("CANCEL"),
                        onPressed: () {
                          setState(() {
                            _isUpdating = false;
                          });
                          _clearValues();
                        },
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
