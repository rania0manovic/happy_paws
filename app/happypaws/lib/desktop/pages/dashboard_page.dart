import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}
Future<List<String>> getData(String filter)async{
  return List.empty();
}
class _DashboardPageState extends State<DashboardPage> {
 final List<String> items = [
 'Search'
];

String? selectedValue;
final TextEditingController textEditingController = TextEditingController();

@override
void dispose() {
  textEditingController.dispose();
  super.dispose();
}

@override
Widget build(BuildContext context) {
  return Center(child: Text("DASHBOARD"),); 
  
  }}