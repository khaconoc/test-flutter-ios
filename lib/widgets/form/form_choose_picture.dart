import 'dart:convert';

import 'package:bccp_mobile_v2/core/services/http_service.dart';
import 'package:bccp_mobile_v2/core/utils/helpers.dart';
import 'package:bccp_mobile_v2/data/repositories/base_repository.dart';
import 'package:bccp_mobile_v2/theme/app_theme.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';

import '../if_widget.dart';

class FormChoosePicture extends StatefulWidget {

  /// list hình ảnh mặc định được widget cha truyền vào
  final List listItem;

  /// event select image
  final Function onSelectImage;

  /// disable
  final bool disabled;

  /// số lượng ảnh tối đa được chọn
  final int max;

  /// bind error
  final String error;

  FormChoosePicture({
    @required this.onSelectImage,
    this.disabled = false,
    this.listItem,
    this.max = 999,
    this.error = '',
  });

  @override
  _FormChoosePictureState createState() => _FormChoosePictureState();
}

class _FormChoosePictureState extends State<FormChoosePicture> {
  /// http service
  HttpService _httpService = Get.find();

  /// loading
  bool isLoading = false;

  /// list value in control
  List listControlValue = [];

  Function deepEq = const DeepCollectionEquality().equals;

  @override
  void initState() {
    super.initState();
    setState(() {
      listControlValue = List.from(widget.listItem);
    });
  }

  @override
  void didUpdateWidget(FormChoosePicture oldWidget) {
    if(!deepEq(widget.listItem, listControlValue)) {
      setState(() {
        print('form choose image re render');
        listControlValue = List.from(widget.listItem);
      });
    }
    super.didUpdateWidget(oldWidget);
  }
  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                  title: new Text('Chọn từ thư viện'),
                  onTap: () => {
                        imageSelector(context, "gallery"),
                        Navigator.pop(context),
                      }),
              new ListTile(
                title: new Text('Chụp ảnh'),
                onTap: () =>
                    {imageSelector(context, "camera"), Navigator.pop(context)},
              ),
            ],
          ),
        );
      },
    );
  }

  Future imageSelector(BuildContext context, String pickerType) async {
    PickedFile tempImage;
    switch (pickerType) {
      case "gallery":

        /// GALLERY IMAGE PICKER
        tempImage = await ImagePicker().getImage(
            source: ImageSource.gallery,
            imageQuality: 70,
            maxWidth: 1500,
            maxHeight: 1500);
        break;

      case "camera": // CAMERA CAPTURE CODE
        tempImage = await ImagePicker().getImage(
            source: ImageSource.camera,
            imageQuality: 70,
            maxHeight: 1500,
            maxWidth: 1500);
        break;
    }

    if (tempImage != null) {
      onUploadImageToServer(tempImage);
    }
  }

  void onUploadImageToServer(PickedFile image) async {
    String fileName = image.path.split('/').last;
    var formData = FormData.fromMap({
      'file': [
        MultipartFile.fromFileSync(image.path, filename: fileName),
      ]
    });
    setState(() {
      isLoading = true;
    });
    var rs = (await _httpService.dio.post(
      BaseRepository.postFileApi,
      data: formData,
      options: Options(
        // contentType: Headers.formUrlEncodedContentType, // form data
        followRedirects: false,
        validateStatus: (status) {
          return true;
        },
      ),
    )) as Response;
    setState(() {
      isLoading = false;
    });
    if (rs.statusCode == 200) {
      var imageResponse = (rs.data as List)[0];
      setState(() {
        listControlValue.add(imageResponse);
        widget.onSelectImage(listControlValue);
      });
    }

    // print(rs);
  }

  void onRemoveImage(int index) {
    setState(() {
      listControlValue.removeAt(index);
    });
    widget.onSelectImage(listControlValue);
  }

  void openDialog(BuildContext context, String imageUrl) => showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              child: PhotoView(
                tightMode: true,
                imageProvider: NetworkImage(
                  imageUrl,
                ),
                // FadeInImage.memoryNetwork(),
                heroAttributes: const PhotoViewHeroAttributes(tag: "someTag"),
                minScale: PhotoViewComputedScale.contained * 1,
                maxScale: PhotoViewComputedScale.covered * 2,
                backgroundDecoration: BoxDecoration(color: Colors.transparent),
              ),
            ),
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 10),
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: (widget.disabled && listControlValue.length == 0)
                  ? 1
                  : listControlValue.length + 1,
              itemBuilder: (context, index) {
                if (index < listControlValue.length) {
                  return _imageMiniPreview(
                    context: context,
                    data: listControlValue[index],
                    index: index,
                  );
                }
                if (widget.disabled && listControlValue.length == 0) {
                  return _imageNoImage(context: context);
                }
                if (listControlValue.length < widget.max) {
                  return _imageButtonChoose(context: context);
                }
                return Container();
              },
            ),
          ),
          IfWidget(condition: widget.error.isNotEmpty, right: Text(widget.error??'', style: BccpAppTheme.textStyleRed,))
        ],
      ),
    );
  }

  Widget _imageMiniPreview(
      {BuildContext context, Map data, int index}) {
    String imageUrl = '';
    imageUrl = BaseRepository.baseUrl;
    imageUrl += data['fileUrl'].replaceAll('/kt1','').replaceAll('dowload', 'dowloadimage') + '&width=100&height=150';
    return GestureDetector(
      onTap: () {
        openDialog(context, imageUrl);
      },
      child: Container(
        height: 150,
        width: 100,
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Center(
                  // child: Image(
                  //   image: data,
                  // ),

                  ),
            ),
            IfWidget(
              condition: !widget.disabled,
              right: Positioned(
                right: 1,
                top: 1,
                child: GestureDetector(
                  onTap: () {
                    onRemoveImage(index);
                  },
                  child: Material(
                    borderRadius: BorderRadius.circular(30),
                    elevation: 5,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white),
                      child: Icon(
                        Icons.close,
                        size: 15,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        // child: Text('a'),
      ),
    );
  }

  Widget _imageButtonChoose({BuildContext context}) {
    return IfWidget(
      condition: !widget.disabled,
      right: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(5),
            height: 200,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              border: widget.error.isNotEmpty ? Border.all(
                  color: Colors.redAccent
              ) : null,
              // color: const Color(0xff7c94b6),
              borderRadius: BorderRadius.circular(10),
              // image: isLoading
              //     ? DecorationImage(
              //         image: AssetImage('assets/images/background_dark.jpg'),
              //         colorFilter: new ColorFilter.mode(
              //             Colors.black.withOpacity(0.4), BlendMode.dstATop),
              //         fit: BoxFit.cover,
              //       )
              //     : null,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Center(
              child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  highlightColor: Colors.blueAccent,
                  onTap: () {
                    if (!isLoading) {
                      _settingModalBottomSheet(context);
                    }
                  },
                  child: IfWidget(
                    condition: isLoading,
                    right: SpinKitWave(
                      size: 25,
                      color: Colors.white,
                    ),
                    wrong: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_a_photo_outlined,
                          color: Colors.grey,
                        ),
                        Text(
                          'Chọn ảnh',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _imageNoImage({BuildContext context}) {
    return Container(
      margin: EdgeInsets.all(5),
      height: 200,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        // color: const Color(0xff7c94b6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.no_photography_outlined, color: Colors.grey),
          Text(
            'không có ảnh',
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
    );
  }
}