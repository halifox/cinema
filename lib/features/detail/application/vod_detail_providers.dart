import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../cms/cms_models.dart';
import '../../../cms/cms_providers.dart';
import '../../library/application/library_providers.dart';
import '../../library/data/library_database.dart';

typedef VodResumeData = ({
  VodItem item,
  VodViewingProgress progress,
  PlaySource source,
  PlayEpisode episode,
});

final vodResumeDataProvider = Provider.autoDispose
    .family<VodResumeData?, VodDetailArguments>((ref, arguments) {
      final detail = ref.watch(vodDetailProvider(arguments));
      final progress = ref.watch(vodViewingProgressProvider(arguments.id));
      if (!detail.hasValue || !progress.hasValue) return null;

      final viewingProgress = progress.requireValue;
      if (viewingProgress == null) return null;

      final item = detail.requireValue;
      final target = resolveResumeTarget(
        sources: parsePlaySources(
          playFrom: item.playFrom,
          playUrl: item.playUrl,
        ),
        progress: viewingProgress,
      );
      return (
        item: item,
        progress: viewingProgress,
        source: target.source,
        episode: target.episode,
      );
    });

({PlaySource source, PlayEpisode episode}) resolveResumeTarget({
  required List<PlaySource> sources,
  required VodViewingProgress progress,
}) {
  final sourceIndex = sources.indexWhere(
    (source) =>
        source.name == progress.sourceName &&
        source.episodes.any((episode) => episode.url == progress.episodeUrl),
  );
  if (sourceIndex < 0) {
    final storedEpisode = PlayEpisode(
      name: progress.episodeName,
      url: progress.episodeUrl,
    );
    return (
      source: PlaySource(name: progress.sourceName, episodes: [storedEpisode]),
      episode: storedEpisode,
    );
  }

  final source = sources[sourceIndex];
  final episode = source.episodes.firstWhere(
    (candidate) => candidate.url == progress.episodeUrl,
  );
  return (source: source, episode: episode);
}
