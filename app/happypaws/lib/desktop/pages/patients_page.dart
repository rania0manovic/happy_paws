import 'dart:async';
import 'package:dio/dio.dart';
import 'package:happypaws/common/services/PetsService.dart';
import 'package:happypaws/common/utilities/toast.dart';
import 'package:happypaws/desktop/components/confirmationDialog.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/utilities/Colors.dart';
import 'package:happypaws/desktop/components/buttons/action_button.dart';
import 'package:happypaws/desktop/components/buttons/primary_icon_button.dart';
import 'package:happypaws/desktop/components/spinner.dart';
import 'package:happypaws/desktop/components/table/table_data.dart';
import 'package:happypaws/desktop/components/table/table_data_photo.dart';
import 'package:happypaws/desktop/components/table/table_head.dart';
import '../dialogs/add_edit_patient_dialog.dart';

@RoutePage()
class PatientsPage extends StatefulWidget {
  final String? myPawNumber;

  const PatientsPage({super.key, this.myPawNumber});

  @override
  State<PatientsPage> createState() => _PatientsPageState();
}

class _PatientsPageState extends State<PatientsPage> {
  Map<String, dynamic>? patients;
  Map<String, dynamic> params = {'formatPhotos': true};
  late ScrollController _scrollController;
  Timer? _debounce;
  late int currentPage = 1;
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    if (widget.myPawNumber != null) {
      setState(() {
        params["myPawNumber"] = widget.myPawNumber;
      });
    }
    fetchData();
  }

  Future<void> fetchData() async {
   try {
      var response =
        await PetsService().getPaged("", currentPage, 15, searchObject: params);
    if (response.statusCode == 200) {
      setState(() {
        currentPage++;
        if (patients == null) {
          patients = response.data;
        } else {
          patients!['items'].addAll(response.data['items']);
        }
      });
    }
   } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 403) {
        if(!mounted)return;
        ToastHelper.showToastError(
            context, "You do not have permission for this action!");
      }
   }
  }

  onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      setState(() {
        patients = null;
        currentPage = 1;
      });
      fetchData();
    });
  }

  void showAddEditPatientMenu(BuildContext context,
      {Map<String, dynamic>? data}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding:
              const EdgeInsets.symmetric(vertical: 20, horizontal: 150),
          contentPadding: const EdgeInsets.all(8),
          content: AddEditPatientMenu(
            onAdd: (value) {
              setState(() {
                patients!['items'].add(value);
              });
            },
            onEdit: (value) {
              setState(() {
                patients!['items'][patients!['items']
                    .indexWhere((x) => x['id'] == value['id'])] = value;
              });
            },
            data: data,
            onClose: () {
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }

  Future<void> deletePatient(int id) async {
    try {
      var response = await PetsService().delete('/$id');
      if (response.statusCode == 200) {
        patients!['items'].removeWhere((x) => x['id'] == id);
        if (!mounted) return;
        ToastHelper.showToastSuccess(
            context, "You have successfully removed the selected patient!");
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 403) {
        if (!mounted) return;
        ToastHelper.showToastError(
            context, "You do not have permission for this action!");
      }
      rethrow;
    }
  }

  Future<void> _scrollListener() async {
    double currentPosition = _scrollController.position.pixels;
    double maxScrollExtent = _scrollController.position.maxScrollExtent;
    double distanceFromBottom = maxScrollExtent - currentPosition;

    if (distanceFromBottom <= 10 &&
        currentPage <= patients!['pageCount'] &&
        !isLoadingMore) {
      setState(() {
        isLoadingMore = true;
      });
      await fetchData();
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 0, bottom: 0),
        child: Card(
          margin: const EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Patient details',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 250,
                      child: TextFormField(
                        initialValue: widget.myPawNumber,
                        onChanged: (value) {
                          setState(() {
                            params['myPawNumber'] = value;
                          });
                          onSearchChanged(value);
                        },
                        decoration: InputDecoration(
                            labelText: "Enter MyPaw number...",
                            labelStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.w500),
                            suffixIcon: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.search,
                                  size: 25,
                                  color: AppColors.primary,
                                ))),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    PrimaryIconButton(
                        onPressed: () => showAddEditPatientMenu(context),
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        label: "Add new patient"),
                  ],
                ),
                const SizedBox(height: 16.0),
                patients != null
                    ? (patients!.isEmpty
                        ? const Center(
                            child: Padding(
                            padding: EdgeInsets.only(top: 32.0),
                            child: Text(
                              'No patient added yet.',
                              style: TextStyle(color: AppColors.primary),
                            ),
                          ))
                        : Expanded(
                            child: SingleChildScrollView(
                                controller: _scrollController,
                                scrollDirection: Axis.vertical,
                                child: table()),
                          ))
                    : const Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(top: 36.0),
                            child: Spinner())),
                if (isLoadingMore)
                  Transform.scale(scale: 0.8, child: const Spinner())
              ],
            ),
          ),
        ));
  }

  Table table() {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(3),
        2: FlexColumnWidth(4),
        3: FlexColumnWidth(4),
        4: FlexColumnWidth(2),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      border: TableBorder(
        horizontalInside: BorderSide(
          color: AppColors.gray.withOpacity(0.5),
          width: 1.0,
        ),
      ),
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
          ),
          children: const [
            TableHead(header: 'Id.', alignmentGeometry: Alignment.centerLeft),
            TableHead(header: 'Photo', alignmentGeometry: Alignment.center),
            TableHead(header: 'Name', alignmentGeometry: Alignment.center),
            TableHead(header: 'Breed', alignmentGeometry: Alignment.center),
            TableHead(header: 'Actions', alignmentGeometry: Alignment.center),
          ],
        ),
        for (var patient in patients!['items'])
          TableRow(
            children: [
              TableData(data: patient['id'].toString()),
              patient['photo'] == null
                  ? TableCell(
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(1000),
                            child: const Image(
                              image:
                                  AssetImage("assets/images/pet_default.jpg"),
                            ),
                          ),
                        ),
                      ),
                    )
                  : TableDataPhoto(data: patient['photo']['downloadURL']),
              TableData(data: patient['name']),
              TableData(data: patient['petBreed']['name']),
              tableActions(patient)
            ],
          )
      ],
    );
  }

  TableCell tableActions(Map<String, dynamic> data) {
    return TableCell(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ActionButton(
              onPressed: () {
                showAddEditPatientMenu(context, data: data);
              },
              icon:  Icons.edit_outlined,
              iconColor: AppColors.gray,
            ),
            ActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ConfirmationDialog(
                      insentPaddingX: 300,
                      title: 'Confirmation',
                      content:
                          'Deleting this patient will result in the deletion of all related data, including appointment history, medical records, and any other associated information. This action cannot be undone. Please confirm that you want to proceed.',
                      onYesPressed: () {
                        Navigator.of(context).pop();
                        deletePatient(data['id']);
                      },
                      onNoPressed: () {
                        Navigator.of(context).pop();
                      },
                    );
                  },
                );
              },
              icon: Icons.delete_outline_outlined,
              iconColor: AppColors.error,
            ),
          ],
        ),
      ),
    );
  }
}
