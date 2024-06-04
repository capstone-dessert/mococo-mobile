import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mococo_mobile/src/service/http_service.dart';
import 'package:mococo_mobile/src/widgets/tag_pickers.dart';
import 'package:mococo_mobile/src/widgets/app_bar.dart';
import 'package:mococo_mobile/src/widgets/modal.dart';

class RegisterCloth extends StatefulWidget {
  final String imagePath;

  const RegisterCloth({super.key, required this.imagePath});

  @override
  State<RegisterCloth> createState() => _RegisterClothState();
}

class _RegisterClothState extends State<RegisterCloth> {
  XFile? _pickedFile; // 이미지 파일
  File? _croppedFile; // 크롭된 이미지 파일
  bool _isDeleteButtonPressed = false; // 삭제 버튼 눌림 여부

  late Map<String, dynamic> classifiedInfo;

  String? selectedPrimaryCategory;
  Set<String> selectedSubCategories = {};
  Set<String> selectedColors = {};
  Set<String> selectedDetailTags = {};

  // TODO: 위젯에서 쿼리 받아오기
  Set queries = {};

  void setSelectedPrimaryCategory(selectedPrimaryCategory) {
    setState(() {
      if (selectedPrimaryCategory == "null") {
        this.selectedPrimaryCategory = null;
      } else {
        this.selectedPrimaryCategory = selectedPrimaryCategory;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _pickedFile = XFile(widget.imagePath);
    // 이미지 파일이 있을 때는 삭제, 크롭 버튼만 보임
    if (_pickedFile != null) {
      _isDeleteButtonPressed = true;
    }
    classifyImage(_pickedFile!).then((value) {
      setState(() {
        classifiedInfo = value;
        // TODO: UI에 classifiedInfo 적용
      });
    }).catchError((error) {
      print("Error classifying image: $error");
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TextTitleAppBar(
        title: "의류 등록",
        buttonNum: 3,
        onBackButtonPressed: _onBackButtonPressed,
        onSaveButtonPressed: _onSaveButtonPressed,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Center(
                // TODO 이미지 서버에 보내서 분류, 배경 제거
                child: _pickedFile != null
                    ? Image.file(File(_pickedFile!.path))
                    : _croppedFile != null
                    ? Image.file(File(_croppedFile!.path))
                    : const Text("이미지가 없습니다."),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!_isDeleteButtonPressed)
                    FloatingActionButton(
                      heroTag: 'unique_tag_1',
                      onPressed: () {
                        _onAddButtonPressed(context);
                      },
                      backgroundColor: Colors.redAccent,
                      tooltip: 'Add',
                      child: const Icon(Icons.add),
                    ),
                  if (_isDeleteButtonPressed) ...[
                    FloatingActionButton(
                      heroTag: 'unique_tag_2',
                      onPressed: () {
                        setState(() {
                          _isDeleteButtonPressed = !_isDeleteButtonPressed;
                        });
                        _imageClear(); // 이미지 초기화
                      },
                      backgroundColor: Colors.redAccent,
                      tooltip: 'Delete',
                      child: const Icon(Icons.delete),
                    ),
                    const SizedBox(width: 20),
                    FloatingActionButton(
                      heroTag: 'unique_tag_3',
                      onPressed: () {
                        _cropImage();
                      },
                      backgroundColor: Colors.redAccent,
                      tooltip: 'Crop',
                      child: const Icon(Icons.crop),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 20),
              PrimaryCategoryTagPicker(
                selectedPrimaryCategory: null,
                setSelectedPrimaryCategory: setSelectedPrimaryCategory,
              ),
              const Divider(color: Color(0xffF0F0F0)),
              if (selectedPrimaryCategory != null)
                Column(
                  children: [
                    SubCategoryTagPicker(primaryCategory: selectedPrimaryCategory!, selectedSubCategories: selectedSubCategories,),
                    const Divider(color: Color(0xffF0F0F0)),
                  ],
                ),
              ColorTagPicker(selectedColors: selectedColors),
              const Divider(color: Color(0xffF0F0F0)),
              DetailTagPicker(selectedDetailTags: selectedDetailTags),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  void _onBackButtonPressed() {
    AlertModal.show(
      context,
      message: '등록을 취소하시겠습니까?',
      onConfirm: () {
        Navigator.pop(context);
      },
    );
  }

  void _onSaveButtonPressed() {
    AlertModal.show(
      context,
      message: '의류를 등록하시겠습니까?',
      onConfirm: () {
        Navigator.pop(context);
      },
    );
  }

  void _onAddButtonPressed(BuildContext context) {
    GetImageModal.show(context);
  }

  void _imageClear() {
    setState(() {
      _pickedFile = null;
      _croppedFile = null;
    });
  }

  Future<void> _cropImage() async {
    if (_pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _pickedFile!.path,
        aspectRatio: const CropAspectRatio(ratioX: 300, ratioY: 360), // 300 * 360으로 크기 고정
        androidUiSettings: const AndroidUiSettings(
          toolbarTitle: '크롭하기',
          toolbarColor: Colors.redAccent,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true, // 비율 잠금
        ),
        iosUiSettings: const IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),
      );
      if (croppedFile != null) {
        setState(() {
          _pickedFile = null; // 크롭된 이미지를 활용하기 위해 기존 이미지 null 처리
          _croppedFile = croppedFile;
        });
      }
    }
  }
}
