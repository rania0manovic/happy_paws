import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:happypaws/common/services/PetBreedsService.dart';
import 'package:happypaws/common/services/PetTypesService.dart';
import 'package:happypaws/common/services/PetsService.dart';
import 'package:happypaws/common/utilities/toast.dart';
import 'package:happypaws/common/utilities/Colors.dart';
import 'package:happypaws/desktop/components/api_data_dropdown_menu.dart';
import 'package:happypaws/desktop/components/buttons/action_button.dart';
import 'package:happypaws/desktop/components/buttons/primary_icon_button.dart';
import 'package:happypaws/desktop/components/confirmationDialog.dart';
import 'package:happypaws/desktop/components/spinner.dart';
import 'package:happypaws/desktop/components/table/table_data.dart';
import 'package:happypaws/desktop/components/table/table_head.dart';
import '../dialogs/add_edit_pet_breed_dialog.dart';

@RoutePage()
class PetBreedsPage extends StatefulHookWidget {
  const PetBreedsPage({super.key});
  @override
  State<PetBreedsPage> createState() => _PetBreedsPageState();
}

class _PetBreedsPageState extends State<PetBreedsPage> {
  Map<String, dynamic>? petBreeds;
  Map<String, dynamic>? petTypes;
  late ScrollController _scrollController;
  late int currentPage = 1;
  bool isLoadingMore = false;
  String? selectedPetType;
  Map<String, dynamic> params = {};
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    fetchBreeds();
    fetchPetTypes();
  }

  Future<void> fetchPetTypes() async {
    var response = await PetTypesService().getPaged(
      "",
      1,
      999,
    );
    if (response.statusCode == 200) {
      setState(() {
        petTypes = response.data;
      });
    }
  }

  Future<void> fetchBreeds() async {
    var response = await PetBreedsService()
        .getPaged("", currentPage, 15, searchObject: params);
    if (response.statusCode == 200) {
      setState(() {
        currentPage++;
        if (petBreeds == null) {
          petBreeds = response.data;
        } else {
          petBreeds!['items'].addAll(response.data['items']);
        }
      });
    }
  }

  Future<void> _scrollListener() async {
    double currentPosition = _scrollController.position.pixels;
    double maxScrollExtent = _scrollController.position.maxScrollExtent;
    double distanceFromBottom = maxScrollExtent - currentPosition;

    if (distanceFromBottom <= 10 &&
        currentPage <= petBreeds!['pageCount'] &&
        !isLoadingMore) {
      setState(() {
        isLoadingMore = true;
      });
      await fetchBreeds();
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  Future<void> deletePetBreed(int id) async {
    try {
      var response = await PetBreedsService().delete('/$id');
      if (response.statusCode == 200) {
        setState(() {
          petBreeds!['items'].removeWhere((x) => x['id'] == id);
        });
        if (!mounted) return;
        ToastHelper.showToastSuccess(
            context, "You have successfully deleted the selected pet breed!");
      } 
    } on DioException catch (e) {
      if (!mounted) return;
      if (e.response != null && e.response!.statusCode == 403) {
        ToastHelper.showToastError(
            context, "You do not have permission for this action!");
      } else {
        ToastHelper.showToastError(
            context, "An error has occured! Please try again later.");
      }
      rethrow;
    }
  }

  void showAddEditMenu(BuildContext context, {Map<String, dynamic>? data}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            content: AddEditPetBreedMenu(
              allbreeds: petBreeds,
              onClose: () {
                Navigator.of(context).pop();
              },
              onAdd: (value) {
                if (petBreeds!['hasNextPage']) return;
                setState(() {
                  petBreeds!['items'].add(value);
                });
              },
              onEdit: (value) {
                setState(() {
                  petBreeds!['items'][petBreeds!['items']
                      .indexWhere((x) => x['id'] == value['id'])] = value;
                });
              },
              data: data,
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      fetchBreeds();
      return null;
    }, [params['petTypeId']]);
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
                      'Pet breeds settings',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    if (petTypes != null)
                      SizedBox(
                        width: 200,
                        child: ApiDataDropdownMenu(
                          items: petTypes!['items'],
                          onChanged: (String? newValue) async {
                            setState(() {
                              currentPage = 1;
                              petBreeds = null;
                              selectedPetType = newValue;
                              params["petTypeId"] = newValue;
                            });
                          },
                          selectedOption: selectedPetType,
                          hint: "Select pet type...",
                        ),
                      ),
                    if (params["petTypeId"] != null && params["petTypeId"] != 0)
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                currentPage = 1;
                                selectedPetType = null;
                                petBreeds = null;
                                params["petTypeId"] = null;
                              });
                            },
                            icon: const Icon(
                              Icons.close,
                              size: 24,
                              color: AppColors.error,
                            ),
                          ))
                    else
                      const SizedBox(
                        width: 20,
                      ),
                    PrimaryIconButton(
                        onPressed: () => showAddEditMenu(context),
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        label: "Add new pet breed"),
                  ],
                ),
                const SizedBox(height: 16.0),
                if (petBreeds != null)
                  Expanded(
                      child: SingleChildScrollView(
                          controller: _scrollController,
                          scrollDirection: Axis.vertical,
                          child: table()))
                else
                  const Expanded(
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
            TableHead(
                header: 'Pet breed', alignmentGeometry: Alignment.centerLeft),
            TableHead(
                header: 'Pet type', alignmentGeometry: Alignment.centerLeft),
            TableHead(
                header: 'Actions', alignmentGeometry: Alignment.centerRight),
          ],
        ),
        for (var petBreed in petBreeds!['items'])
          TableRow(
            children: [
              TableData(
                data: petBreed['name'],
                alignmentGeometry: Alignment.bottomLeft,
                paddingHorizontal: 25,
              ),
              TableData(
                data: petBreed['petType']['name'],
                alignmentGeometry: Alignment.bottomLeft,
                paddingHorizontal: 25,
              ),
              tableActions(petBreed)
            ],
          ),
      ],
    );
  }

  TableCell tableActions(Map<String, dynamic> data) {
    return TableCell(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ActionButton(
                onPressed: () {
                  showAddEditMenu(context, data: data);
                },
                icon: Icons.edit_outlined,
                iconColor: AppColors.gray,
              ),
              ActionButton(
                onPressed: () async {
                  var response =
                      await PetsService().hasAnyWithPetBreedId(data['id']);
                  if (response.data == true) {
                    if (!mounted) return;
                    ToastHelper.showToastError(context,
                        "You cannot delete this pet breed because it contains one or more pets.");
                    return;
                  }
                  if (!mounted) return;
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ConfirmationDialog(
                        title: 'Confirmation',
                        content:
                            'Are you sure you want to delete this pet breed?',
                        onYesPressed: () {
                          Navigator.of(context).pop();
                          deletePetBreed(data['id']);
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
      ),
    );
  }
}
