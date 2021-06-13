import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final String plant;

  const DetailsScreen({Key key, this.plant}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String _details = '';

  String fetchDetails() {
    switch (widget.plant) {
      case 'Cockspur':
        return 'Cockspur Detailes...';
      case 'Lantana':
        return 'Lantana Detailes...';
      case 'Mimosa Pudica':
        return 'Mimosa Detailes...';
      case 'Oxalis Weed':
        return 'Oxalis Weed Detailes...';
      case 'Parthenium':
        return 'Parthenium Detailes...';
      case 'Siam Weed':
        return 'Siam Weed Detailes...';
      case 'Snake Weed':
        return 'Snake Weed Detailes...';
      case 'Stinging Nettle':
        return 'Stinging Nettle Detailes...';
        break;
      default:
        return '';
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _details = fetchDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.plant),
      ),
      body: Center(
        child: Text(_details),
      ),
    );
  }
}
