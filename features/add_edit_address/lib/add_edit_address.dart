import 'package:auto_route/annotations.dart';

import 'add_edit_address.gm.dart';

export 'package:add_edit_address/add_edit_address.dart';
export 'package:add_edit_address/add_edit_address.gm.dart';

@AutoRouterConfig.module(replaceInRouteName: 'Page|Dialog,Route')
class AddEditAddressModule extends $AddEditAddressModule {}
