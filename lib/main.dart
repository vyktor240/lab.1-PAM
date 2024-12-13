import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(CurrencyConverterApp());
}

class CurrencyConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[300],
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.black),
        ),
      ),
      home: CurrencyConverterScreen(),
    );
  }
}

class CurrencyConverterScreen extends StatefulWidget {
  @override
  _CurrencyConverterScreenState createState() => _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  String fromCurrency = 'MDL';
  String toCurrency = 'USD';
  double mdlToUsdRate = 1 / 17.65;
  double usdToMdlRate = 17.65;
  TextEditingController mdlAmountController = TextEditingController();
  TextEditingController usdAmountController = TextEditingController();

  String getCurrentTime() {
    final now = DateTime.now();
    final formatter = DateFormat('HH:mm');
    return formatter.format(now);
  }

  void updateConversion() {
    double mdlAmount = double.tryParse(mdlAmountController.text) ?? 0.0;
    double usdAmount = double.tryParse(usdAmountController.text) ?? 0.0;

    if (fromCurrency == 'MDL' && toCurrency == 'USD') {
      usdAmountController.text = (mdlAmount * mdlToUsdRate).toStringAsFixed(2);
    } else if (fromCurrency == 'USD' && toCurrency == 'MDL') {
      mdlAmountController.text = (usdAmount * usdToMdlRate).toStringAsFixed(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 60),
                Center(
                  child: Text(
                    'Currency Converter',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue[900]),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: DropdownButton<String>(
                              value: fromCurrency,
                              icon: Icon(Icons.arrow_downward),
                              underline: Container(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  fromCurrency = newValue!;

                                  updateConversion();
                                });
                              },
                              items: <String>['MDL', 'USD']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        value == 'MDL'
                                            ? 'assets/Moldova.png'
                                            : 'assets/USA.png',
                                        height: 20,
                                        width: 20,
                                      ),
                                      SizedBox(width: 6),
                                      Text(value),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200], // Fundal gri deschis
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: TextField(
                                controller: fromCurrency == 'MDL'
                                    ? mdlAmountController
                                    : usdAmountController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Amount',
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                                ),
                                textAlign: TextAlign.right,
                                onChanged: (value) {
                                  setState(() {
                                    updateConversion();
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      IconButton(
                        icon: Icon(Icons.swap_vert, size: 28, color: Colors.blue[900]),
                        onPressed: () {
                          setState(() {
                            String tempCurrency = fromCurrency;
                            fromCurrency = toCurrency;
                            toCurrency = tempCurrency;
                            updateConversion();
                          });
                        },
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: DropdownButton<String>(
                              value: toCurrency,
                              icon: Icon(Icons.arrow_downward),
                              underline: Container(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  toCurrency = newValue!;

                                  updateConversion();
                                });
                              },
                              items: <String>['MDL', 'USD']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        value == 'MDL'
                                            ? 'assets/Moldova.png'
                                            : 'assets/USA.png',
                                        height: 20,
                                        width: 20,
                                      ),
                                      SizedBox(width: 6),
                                      Text(value),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[300], // Fundal gri pentru USD
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: TextField(
                                controller: toCurrency == 'MDL'
                                    ? mdlAmountController
                                    : usdAmountController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Amount',
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                                ),
                                textAlign: TextAlign.right,
                                onChanged: (value) {
                                  setState(() {

                                    updateConversion();
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Indicative Exchange Rate',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      '1 USD = ',
                      style: TextStyle(fontSize: 16),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '$usdToMdlRate MDL',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 36,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      getCurrentTime(),
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Icon(Icons.signal_wifi_4_bar, color: Colors.black, size: 18),
                        SizedBox(width: 6),
                        Icon(Icons.signal_cellular_4_bar, color: Colors.black, size: 18), // Icon pentru conexiunea la rețea
                        SizedBox(width: 6),
                        Icon(Icons.battery_full, color: Colors.black, size: 18),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
