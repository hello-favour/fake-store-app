import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc(this._userRepository) : super(UserInitial()) {
    on<LoadUser>(_onLoadUser);
    on<RefreshUser>(_onRefreshUser);
    on<LoadCachedUser>(_onLoadCachedUser);
    on<ClearUser>(_onClearUser);
  }

  Future<void> _onLoadUser(LoadUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final user = await _userRepository.getUser(event.userId);
      emit(UserLoaded(user: user));
    } catch (e) {
      // If API fails, try to load from cache
      final cachedUser = _userRepository.getCachedUser();
      if (cachedUser != null) {
        emit(UserLoaded(user: cachedUser));
      } else {
        emit(UserError(message: e.toString()));
      }
    }
  }

  Future<void> _onRefreshUser(
    RefreshUser event,
    Emitter<UserState> emit,
  ) async {
    try {
      final user = await _userRepository.refreshUser(event.userId);
      emit(UserLoaded(user: user));
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  void _onLoadCachedUser(LoadCachedUser event, Emitter<UserState> emit) {
    final cachedUser = _userRepository.getCachedUser();
    if (cachedUser != null) {
      emit(UserLoaded(user: cachedUser));
    } else {
      emit(UserInitial());
    }
  }

  Future<void> _onClearUser(ClearUser event, Emitter<UserState> emit) async {
    await _userRepository.clearUser();
    emit(UserInitial());
  }
}
