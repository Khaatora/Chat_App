import 'package:chat_own/base_class.dart';
import 'package:chat_own/models/room_category.dart';
import 'package:chat_own/modules/add_room/add_room_navigator.dart';
import 'package:chat_own/modules/add_room/add_room_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRoomScreen extends StatefulWidget {
  const AddRoomScreen({Key? key}) : super(key: key);
  static const String routeName = "/AddRoom";

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends BaseView<AddRoomScreen, AddRoomViewModel>
    implements AddRoomNavigator {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late GlobalKey<FormState> formKey;
  late List<RoomCategoryModel> roomCategories;
  RoomCategoryModel? selectedCategory;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    roomCategories = RoomCategoryModel.getCategories();
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return ChangeNotifierProvider<AddRoomViewModel>.value(
        value: viewModel,
        builder: (context, child) {
          return Scaffold(
              backgroundColor: Colors.white,
              body: Stack(
                children: [
                  Image.asset(
                    "assets/images/main_background_img_triangles.png",
                  ),
                  Positioned(
                      top: mediaQuery.size.height * 0.1,
                      width: mediaQuery.size.width,
                      child: const Center(
                          child: Text(
                            "Add Room",
                            style: TextStyle(color: Colors.white),
                          ))),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: mediaQuery.size.width * 0.03),
                    child: Center(
                      child: Container(
                        height: mediaQuery.size.height * 0.6,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: const Offset(0, 5)),
                            ]),
                        child: Form(
                          key: formKey,
                          child: SingleChildScrollView(
                            padding: EdgeInsets.symmetric(
                                horizontal: mediaQuery.size.width * 0.03,
                                vertical: mediaQuery.size.height * 0.02),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  //Create New Room Text
                                  const Text(
                                    "Create new Room",
                                    textAlign: TextAlign.center,
                                  ),
                                  //Chat Img
                                  Image.asset("assets/images/chat_img.png"),
                                  // ------------------- First Name
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: mediaQuery.size.height * 0.01),
                                    child: TextFormField(
                                      controller: titleController,
                                      keyboardType: TextInputType.text,
                                      validator: (text) {
                                        if (text!.trim() == "") {
                                          return "Please Enter Room TiTle";
                                        }
                                        return null;
                                      },
                                      autofocus: false,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                          hintText: "Room Title",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                color: Colors.blue,
                                              )),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                color: Colors.blue,
                                              ))),
                                    ),
                                  ),
                                  // ------------------- User Name
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: mediaQuery.size.height * 0.01),
                                    child: TextFormField(
                                      controller: descriptionController,
                                      validator: (text) {
                                        if (text!.trim() == "") {
                                          return "Please Enter Description";
                                        }
                                        return null;
                                      },
                                      autofocus: false,
                                      decoration: InputDecoration(
                                        hintText: "Description",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                              color: Colors.blue,
                                            )),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                              color: Colors.blue,
                                            )),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: mediaQuery.size.height * 0.01),
                                    child: DropdownButtonFormField<RoomCategoryModel>(
                                      validator: (value) {
                                        if(value==null){
                                          return "Please select a Category";
                                        }
                                        return null;
                                      },
                                      isExpanded: true,
                                      value: selectedCategory,
                                      hint: const Text("Select Category"),
                                      onChanged: (selectedCategory) {
                                        if (selectedCategory == null) return;
                                        setState(() {
                                          this.selectedCategory =
                                          selectedCategory;
                                        });
                                      },
                                      items: roomCategories
                                          .map((category) =>
                                          DropdownMenuItem<
                                              RoomCategoryModel>(
                                              value: category,
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceEvenly,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: [
                                                  Text(category.name),
                                                  Image.asset(category.image,
                                                      height: 25),
                                                ],
                                              )))
                                          .toList(),
                                    ),
                                  ),

                                  ElevatedButton(
                                      onPressed: validateForm,
                                      style: ButtonStyle(
                                          side: MaterialStateBorderSide
                                              .resolveWith((states) =>
                                          const BorderSide(
                                              width: 0.5))),
                                      child: const Text("Create Room")),
                                ]),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ));
        });
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  AddRoomViewModel initViewModel() {
    return AddRoomViewModel();
  }

  void validateForm() {
    if (formKey.currentState!.validate()) {
      viewModel.addRoomToDB(title: titleController.text,
          description: descriptionController.text,
          categoryId: selectedCategory!.id);
      unFocusKeyboardFromScope();
    }
  }

  void unFocusKeyboardFromScope() {
    FocusScope.of(context).unfocus();
  }
}
