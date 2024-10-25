import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistorySaveScreen extends StatelessWidget {
  const HistorySaveScreen({Key? key}) : super(key: key);

  // Function to fetch all receipts from Firestore
  Future<List<Map<String, dynamic>>> _fetchReceipts() async {
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('receipts').get();

    // Map each document to a Map<String, dynamic>
    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Receipt History')),
        backgroundColor: Colors.orange,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchReceipts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching data.'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No receipts found.'));
          }

          final receipts = snapshot.data!;

          return ListView.builder(
            itemCount: receipts.length,
            itemBuilder: (context, index) {
              final receipt = receipts[index];
              return _buildReceiptCard(receipt);
            },
          );
        },
      ),
    );
  }

  // Helper method to build a receipt card widget
  Widget _buildReceiptCard(Map<String, dynamic> receipt) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Student Name: ${receipt['studentName']}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Father\'s Name: ${receipt['fatherName']}'),
            Text('Fee Amount: \$${receipt['feeAmount']}'),
            Text('Receipt Number: ${receipt['receiptNumber']}'),
            Text('Date: ${receipt['date']}'),
          ],
        ),
      ),
    );
  }
}
