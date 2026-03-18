import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/user.dart';
import '../../../data/repositories/media_repository.dart';

abstract class MediaEvent extends Equatable {
  const MediaEvent();

  @override
  List<Object?> get props => [];
}

class MediaLoadRequested extends MediaEvent {
  final int page;
  final int size;

  const MediaLoadRequested({this.page = 0, this.size = 20});

  @override
  List<Object?> get props => [page, size];
}

class MediaUploadRequested extends MediaEvent {
  final String filePath;
  final String fileType;

  const MediaUploadRequested({
    required this.filePath,
    required this.fileType,
  });

  @override
  List<Object?> get props => [filePath, fileType];
}

class MediaDeleteRequested extends MediaEvent {
  final int fileId;

  const MediaDeleteRequested(this.fileId);

  @override
  List<Object?> get props => [fileId];
}

class AIEnhanceRequested extends MediaEvent {
  final String imageBase64;
  final String? prompt;

  const AIEnhanceRequested({
    required this.imageBase64,
    this.prompt,
  });

  @override
  List<Object?> get props => [imageBase64, prompt];
}

class AIPoseAnalysisRequested extends MediaEvent {
  final String imageBase64;

  const AIPoseAnalysisRequested(this.imageBase64);

  @override
  List<Object?> get props => [imageBase64];
}

abstract class MediaState extends Equatable {
  const MediaState();

  @override
  List<Object?> get props => [];
}

class MediaInitial extends MediaState {}

class MediaLoading extends MediaState {}

class MediaLoaded extends MediaState {
  final List<MediaFile> files;
  final bool hasMore;

  const MediaLoaded(this.files, {this.hasMore = true});

  @override
  List<Object?> get props => [files, hasMore];
}

class MediaUploading extends MediaState {
  final double progress;

  const MediaUploading(this.progress);

  @override
  List<Object?> get props => [progress];
}

class MediaUploaded extends MediaState {
  final MediaFile file;

  const MediaUploaded(this.file);

  @override
  List<Object?> get props => [file];
}

class MediaError extends MediaState {
  final String message;

  const MediaError(this.message);

  @override
  List<Object?> get props => [message];
}

class AIProcessing extends MediaState {}

class AIResultReady extends MediaState {
  final String result;

  const AIResultReady(this.result);

  @override
  List<Object?> get props => [result];
}

class MediaBloc extends Bloc<MediaEvent, MediaState> {
  final MediaRepository _mediaRepository;

  MediaBloc({required MediaRepository mediaRepository})
      : _mediaRepository = mediaRepository,
        super(MediaInitial()) {
    on<MediaLoadRequested>(_onLoadRequested);
    on<MediaUploadRequested>(_onUploadRequested);
    on<MediaDeleteRequested>(_onDeleteRequested);
    on<AIEnhanceRequested>(_onEnhanceRequested);
    on<AIPoseAnalysisRequested>(_onPoseAnalysisRequested);
  }

  Future<void> _onLoadRequested(
    MediaLoadRequested event,
    Emitter<MediaState> emit,
  ) async {
    emit(MediaLoading());
    try {
      final files = await _mediaRepository.getMediaFiles(
        page: event.page,
        size: event.size,
      );
      emit(MediaLoaded(files));
    } catch (e) {
      emit(MediaError(e.toString()));
    }
  }

  Future<void> _onUploadRequested(
    MediaUploadRequested event,
    Emitter<MediaState> emit,
  ) async {
    emit(const MediaUploading(0));
    try {
      final file = await _mediaRepository.uploadFile(
        event.filePath,
        event.fileType,
        onProgress: (sent, total) {
          emit(MediaUploading(sent / total));
        },
      );
      emit(MediaUploaded(file));
    } catch (e) {
      emit(MediaError(e.toString()));
    }
  }

  Future<void> _onDeleteRequested(
    MediaDeleteRequested event,
    Emitter<MediaState> emit,
  ) async {
    try {
      await _mediaRepository.deleteFile(event.fileId);
      final currentState = state;
      if (currentState is MediaLoaded) {
        final updatedFiles = currentState.files
            .where((f) => f.id != event.fileId)
            .toList();
        emit(MediaLoaded(updatedFiles));
      }
    } catch (e) {
      emit(MediaError(e.toString()));
    }
  }

  Future<void> _onEnhanceRequested(
    AIEnhanceRequested event,
    Emitter<MediaState> emit,
  ) async {
    emit(AIProcessing());
    try {
      final result = await _mediaRepository.enhanceImage(
        event.imageBase64,
        prompt: event.prompt,
      );
      emit(AIResultReady(result));
    } catch (e) {
      emit(MediaError(e.toString()));
    }
  }

  Future<void> _onPoseAnalysisRequested(
    AIPoseAnalysisRequested event,
    Emitter<MediaState> emit,
  ) async {
    emit(AIProcessing());
    try {
      final result = await _mediaRepository.analyzePose(event.imageBase64);
      emit(AIResultReady(result));
    } catch (e) {
      emit(MediaError(e.toString()));
    }
  }
}
