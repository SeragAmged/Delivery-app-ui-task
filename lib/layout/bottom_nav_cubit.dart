import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class BottomNavCubit extends Cubit<int> {
  BottomNavCubit() : super(0);

  void changeTab(int index) => emit(index);
}
