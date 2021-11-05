import 'dart:io';
import 'package:biblosphere/src/app/camera/camera_cubit.dart';
import 'package:biblosphere/src/app/camera/photo.dart';
import 'package:biblosphere/src/ui_kit/colors.dart';
import 'package:biblosphere/src/ui_kit/icons.dart';
import 'package:biblosphere/src/ui_kit/loading.dart';
import 'package:biblosphere/src/ui_kit/styles.dart';
import 'package:biblosphere/src/utils/camera_util.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CameraCubit(context.read()),
      child: const _CameraPageWidget(),
    );
  }
}

class _CameraPageWidget extends StatefulWidget {
  const _CameraPageWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CameraPageWidgetState();
}

class _CameraPageWidgetState extends State<_CameraPageWidget> {
  CameraController? _cameraController;
  static const _minBottomBar = 102.0;
  static const _maxBottomBar = 222.0;
  static const _animationDuration = Duration(milliseconds: 300);

  var _flashMode = FlashMode.auto;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(
      CameraUtil.instance.backCamera,
      ResolutionPreset.max,
      enableAudio: false,
    )..initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.greyLight,
        leading: _buildFlashButton(),
      ),
      backgroundColor: AppColors.greyLight,
      body: !(_cameraController?.value.isInitialized ?? false)
          ? _buildLoadingBody()
          : _buildLoadedBody(),
    );
  }

  Widget _buildFlashButton() {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        if (_cameraController != null) {
          _flashMode = _flashMode == FlashMode.always
              ? FlashMode.auto
              : FlashMode.always;
          _cameraController!.setFlashMode(FlashMode.auto);
        }
      },
      child: const AppIcon(
        AppIcons.thunder,
        height: 20,
        width: 20,
      ),
    );
  }

  Widget _buildLoadingBody() {
    return const Center(child: AppLoading());
  }

  Widget _buildLoadedBody() {
    return LayoutBuilder(
      builder: (_, constraints) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: OverflowBox(
              minWidth: constraints.maxWidth,
              maxWidth: constraints.maxWidth,
              child: CameraPreview(_cameraController!),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BlocBuilder<CameraCubit, CameraState>(
              builder: (context, state) => AnimatedContainer(
                height: state.photos.isEmpty ? _minBottomBar : _maxBottomBar,
                duration: _animationDuration,
                curve: Curves.easeIn,
                color: AppColors.greyLight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildButtonsRow(state.photos.isNotEmpty),
                    Expanded(child: _buildPhotoRow(state.photos)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoRow(List<Photo> photos) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: photos.length,
      itemBuilder: (_, index) => _buildPhoto(
        index == 0,
        index == photos.length - 1,
        photos[index],
      ),
      separatorBuilder: (_, index) => const SizedBox(width: 17),
    );
  }

  Widget _buildPhoto(bool isFirst, bool isLast, Photo photo) {
    return Padding(
      padding: EdgeInsets.only(
        top: 12,
        bottom: 12,
        left: isFirst ? 12 : 0,
        right: isLast ? 12 : 0,
      ),
      child: LayoutBuilder(
        builder: (_, constraints) => ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: kIsWeb
              ? Image.network(
                  photo.photo.path,
                  height: constraints.maxHeight,
                  width: constraints.maxHeight,
                  fit: BoxFit.cover,
                )
              : Image.file(
                  File(photo.photo.path),
                  height: constraints.maxHeight,
                  width: constraints.maxHeight,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }

  Widget _buildButtonsRow(bool hasPhotos) {
    return Container(
      height: _minBottomBar,
      padding: const EdgeInsets.fromLTRB(24.5, 3, 24.5, 3),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: _buildPhotoButton(),
          ),
          if (!hasPhotos) ...[
            Align(
              alignment: Alignment.centerLeft,
              child: _buildBackButton(),
            ),
          ] else ...[
            Align(
              alignment: Alignment.centerRight,
              child: _buildContinueButton(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBackButton() {
    return CupertinoButton(
      onPressed: Navigator.of(context).pop,
      child: Text(
        'Назад',
        style: AppStyles.cameraButton(color: AppColors.accent1),
      ),
    );
  }

  Widget _buildPhotoButton() {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () async {
        final photo = await _cameraController!.takePicture();
        context.read<CameraCubit>().handlePhoto(photo);
      },
      child: Container(
        height: 70,
        width: 70,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.greyLight,
          border: Border.all(color: AppColors.line, width: 6),
          borderRadius: BorderRadius.circular(35),
        ),
        child: Container(
          height: 54,
          width: 54,
          decoration: BoxDecoration(
            color: AppColors.line,
            borderRadius: BorderRadius.circular(27),
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      height: 37,
      width: 90,
      child: CupertinoButton(
        color: AppColors.accent1,
        borderRadius: BorderRadius.circular(15),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        onPressed: Navigator.of(context).pop,
        child: Text(
          'Далее',
          style: AppStyles.cameraButton(color: AppColors.white),
        ),
      ),
    );
  }
}
