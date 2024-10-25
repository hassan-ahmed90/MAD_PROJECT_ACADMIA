import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:mad_project/history_screen.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';

class NewForm extends StatefulWidget {
  const NewForm({super.key});

  @override
  State<NewForm> createState() => _NewFormState();
}

class _NewFormState extends State<NewForm> {
  final _formKey = GlobalKey<FormState>();
  final _studentNameController = TextEditingController();
  final _fatherNameController = TextEditingController();
  final _feeAmountController = TextEditingController();

  @override
  void dispose() {
    _studentNameController.dispose();
    _fatherNameController.dispose();
    _feeAmountController.dispose();
    super.dispose();
  }
  Future<void> _saveDataToFirestore() async {
    try {
      await FirebaseFirestore.instance.collection('receipts').add({
        'studentName': _studentNameController.text,
        'fatherName': _fatherNameController.text,
        'feeAmount': _feeAmountController.text,
        'date': DateTime.now().toIso8601String(),
        'receiptNumber': Random().nextInt(1000000),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data saved to Firestore')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving data: $e')),
      );
    }
  }

  Future<pw.Document> _generatePDF() async {
    final pdf = pw.Document();

    int receiptNumber = Random().nextInt(1000000);
    String currentDateTime = DateTime.now().toString();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Student Fee Receipt', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 20),
                pw.Text('Receipt No: $receiptNumber', style: pw.TextStyle(fontSize: 18)),
                pw.Text('Date: $currentDateTime', style: pw.TextStyle(fontSize: 18)),
                pw.SizedBox(height: 20),
                pw.Text('Student Name: ${_studentNameController.text}', style: pw.TextStyle(fontSize: 18)),
                pw.Text('Father\'s Name: ${_fatherNameController.text}', style: pw.TextStyle(fontSize: 18)),
                pw.Text('Fee Amount: \$${_feeAmountController.text}', style: pw.TextStyle(fontSize: 18)),
                pw.SizedBox(height: 20),
                pw.Text('Thank you for your payment!', style: pw.TextStyle(fontSize: 18)),
              ],
            ),
          );
        },
      ),
    );

    return pdf;
  }

  Future<void> _generatePDFAndSave() async {
    final pdf = await _generatePDF();

    final output = await getExternalStorageDirectory();
    final file = File('${output!.path}/fee_receipt.pdf');
    await file.writeAsBytes(await pdf.save());

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('PDF saved to ${file.path}')));

    await Printing.sharePdf(bytes: await pdf.save(), filename: 'fee_receipt.pdf');
  }

  void _showPDFPreview() async {
    final pdf = await _generatePDF();

    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: PdfPreview(
          build: (format) => pdf.save(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size using MediaQuery
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.orange.shade900,
              Colors.orange.shade800,
              Colors.orange.shade400,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height * 0.03), // 3% of screen height
              Padding(
                padding: EdgeInsets.all(width * 0.05), // 5% of screen width
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(width * 0.02), // 2% of screen width
                      child: Text(
                        "Aims Acadmey",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * 0.09, // Font size 9% of screen width
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(width * 0.02),
                      child: Text(
                        "Recipt Form",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * 0.06, // Font size 6% of screen width
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02), // 2% of screen height
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(width * 0.07), // 7% of screen width
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.04), // 4% of screen height
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(225, 95, 27, .3),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(width * 0.02),
                                child: TextFormField(
                                  controller: _studentNameController,
                                  decoration: InputDecoration(
                                    hintText: "Student Name",
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter the student\'s name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(width * 0.02),
                                child: TextFormField(
                                  controller: _fatherNameController,
                                  decoration: InputDecoration(
                                    hintText: "Father's name",
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter the Father\'s name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(width * 0.02),
                                child: TextFormField(
                                  controller: _feeAmountController,
                                  decoration: InputDecoration(
                                    hintText: "Amount",
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter the Amount';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.08), // 8% of screen height
                      MaterialButton(
                        child: Center(
                          child: Text(
                            "Submit Fees",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.05, // Font size 5% of screen width
                            ),
                          ),
                        ),
                        height: height * 0.06, // Button height 6% of screen height
                        color: Colors.orange[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _saveDataToFirestore();
                            _generatePDFAndSave();
                            _showPDFPreview();
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>HistorySaveScreen()));
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

