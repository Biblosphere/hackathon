import 'package:biblosphere/src/app/camera/camera_page.dart';
import 'package:biblosphere/src/app/input_page/input_cubit.dart';
import 'package:biblosphere/src/ui_kit/colors.dart';
import 'package:biblosphere/src/ui_kit/icons.dart';
import 'package:biblosphere/src/ui_kit/styles.dart';
import 'package:biblosphere/src/utils/camera_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotoButton extends StatelessWidget {
  const PhotoButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: CupertinoButton(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        onPressed: () async {
          if (!CameraUtil.instance.hasBackCamera) {
            await CameraUtil.instance.initilize();
          }
          if (CameraUtil.instance.hasBackCamera) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider<InputCubit>.value(
                  value: context.read(),
                  child: const CameraPage(),
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Камера недоступна.'),
              ),
            );
          }
        },
        child: Row(
          children: [
            Text(
              'Сканировать книжную полку',
              style: AppStyles.defaultRegularBody(color: AppColors.accent1),
            ),
            const Spacer(),
            const AppIcon(AppIcons.camera, color: AppColors.accent1),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}
