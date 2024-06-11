import 'package:flutter/material.dart';
import 'package:flutter_database_interaction/api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Oracle App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DonorScreen(),
    );
  }
}

class DonorScreen extends StatefulWidget {
  @override
  _DonorScreenState createState() => _DonorScreenState();
}

class _DonorScreenState extends State<DonorScreen> {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donors'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddDonorDialog(
                      apiService: apiService,
                      onAdd: () {
                        // Handle what to do after adding a donor
                      },
                    );
                  },
                );
              },
              child: Text('Add Donor'),
            ),
          ],
        ),
      ),
    );
  }
}

class AddDonorDialog extends StatelessWidget {
  final ApiService apiService;
  final VoidCallback onAdd;

  final TextEditingController donorIdController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactInfoController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController donationTotalController = TextEditingController();

  AddDonorDialog({required this.apiService, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Donor'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: donorIdController,
              decoration: InputDecoration(labelText: 'Donor ID'),
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: contactInfoController,
              decoration: InputDecoration(labelText: 'Contact Info'),
            ),
            TextField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: donationTotalController,
              decoration: InputDecoration(labelText: 'Donation Total'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            final donor = {
              'DonorID': int.parse(donorIdController.text),
              'Name': nameController.text,
              'ContactInfo': contactInfoController.text,
              'Address': addressController.text,
              'DonationTotal': int.parse(donationTotalController.text),
            };
            apiService.createDonor(donor).then((_) {
              onAdd();
              Navigator.of(context).pop();
            });
          },
          child: Text('Add'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
