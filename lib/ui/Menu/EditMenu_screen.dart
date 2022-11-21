import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/Menu.dart';
import '../share/dialog_utils.dart';
import 'Menu_manager.dart';

class EditMenuScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  EditMenuScreen(
    Menu? menu, {
    super.key,
  }) {
    if (menu == null) {
      this.menu = Menu(
        id: null,
        title: '',
       rating: '',
        time: '',
        description: '',
        imageUrl: '',
      );
    } else {
      this.menu = menu;
    }
  }
  late final Menu menu;
  @override
  State<EditMenuScreen> createState() => _EditMenuScreenState();
}

class _EditMenuScreenState extends State<EditMenuScreen> {
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _editForm = GlobalKey<FormState>();
  late Menu _editMenu;
  var _isLoading = false;
  bool _isValidImageUrl(String value) {
    return (value.startsWith('http') || value.startsWith('http')) &&
        (value.startsWith('.png') || value.startsWith('.jpeg'));
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(() {
      if (!_imageUrlFocusNode.hasFocus) {
        if (!_isValidImageUrl(_imageUrlController.text)) {
          return;
        }
        setState(() {});
      }
    });
    _editMenu = widget.menu;
    _imageUrlController.text = _editMenu.imageUrl;
  }

  @override
  void dispose() {
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _editForm.currentState!.validate();
    if (!isValid) {
      return;
    }
    _editForm.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      final menuManager = context.read<MenuManager>();
      if (_editMenu.id != null) {
        await menuManager.updateMenu(_editMenu);
      } else {
        await menuManager.addProduct(_editMenu);
      }
    } catch (error) {
      await showErrorDialog(context, 'Something went wrong.');
    }
    setState(() {
      _isLoading = false;
    });
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cập nhật món ăn'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _editForm,
                child: ListView(
                  children: <Widget>[
                    buildTitleField(),
                   buildTime(),
                   buildRating(),
                    buildDescriptionField(),
                    buildProductPreview(),
                  ],
                ),
              ),
            ),
    );
  }

  TextFormField buildTitleField() {
    return TextFormField(
      initialValue: _editMenu.title,
      decoration: const InputDecoration(labelText: 'Title'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value';
        }
        return null;
      },
      onSaved: (newValue) {
        _editMenu = _editMenu.copyWith(title: newValue);
      },
    );
  }
  TextFormField buildTime() {
    return TextFormField(
      initialValue: _editMenu.time,
      decoration: const InputDecoration(labelText: 'Time'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value';
        }
        return null;
      },
      onSaved: (newValue) {
        _editMenu = _editMenu.copyWith(time: newValue);
      },
    );
  }
TextFormField buildRating() {
    return TextFormField(
      initialValue: _editMenu.rating,
      decoration: const InputDecoration(labelText: 'Rating'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value';
        }
        return null;
      },
      onSaved: (newValue) {
        _editMenu = _editMenu.copyWith(rating: newValue);
      },
    );
  }
  

  TextFormField buildDescriptionField() {
    return TextFormField(
      initialValue: _editMenu.description,
      decoration: const InputDecoration(labelText: 'Description'),
      maxLines: 3,
      keyboardType: TextInputType.multiline,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a description';
        }
        if (value.length < 10) {
          return 'Should be at least 10 characters long';
        }
        return null;
      },
       onSaved: (newValue) {
        _editMenu = _editMenu.copyWith(description: newValue);
      },
    );
  }

  Widget buildProductPreview() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          width: 100,
          height: 100,
          margin: const EdgeInsets.only(
            top: 8,
            right: 10,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _imageUrlController.text.isEmpty
              ? const Text('Enter a URL')
              : FittedBox(
                  child: Image.network(
                    _imageUrlController.text,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
        Expanded(
          child: buildImageURLField(),
        )
      ],
    );
  }

  TextFormField buildImageURLField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Image URL'),
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.done,
      controller: _imageUrlController,
      focusNode: _imageUrlFocusNode,
      onFieldSubmitted: (value) => _saveForm(),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter an image URL';
        }
        return null;
      },
      onSaved: (value) {
        _editMenu = _editMenu.copyWith(imageUrl: value);
      },
    );
  }
}
