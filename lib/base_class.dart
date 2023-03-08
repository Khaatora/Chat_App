import 'package:flutter/material.dart';

abstract class BaseNavigator {
  void showLoading({String message});

  void showMessage(String message);

  void hideDialog();
}

class BaseViewModel<Navigator extends BaseNavigator> extends ChangeNotifier {
  late Navigator navigator;
}

abstract class BaseView<T extends StatefulWidget,
    ViewModel extends BaseViewModel> extends State<T> implements BaseNavigator {
  late ViewModel viewModel;

  ViewModel initViewModel();

  @override
  void initState() {
    viewModel = initViewModel();
    super.initState();
  }

  @override
  void showLoading({String message = "loading"}) {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  @override
  void showMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
        );
      },
    );
  }

  @override
  void hideDialog() {
    Navigator.pop(context);
  }
}
