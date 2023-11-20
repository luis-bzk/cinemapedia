import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';

import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:go_router/go_router.dart';

class MoviesHorizontalListView extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subtitle;
  final VoidCallback? loadNextPage;

  const MoviesHorizontalListView(
      {super.key,
      required this.movies,
      this.title,
      this.subtitle,
      this.loadNextPage});

  @override
  State<MoviesHorizontalListView> createState() =>
      _MoviesHorizontalListViewState();
}

class _MoviesHorizontalListViewState extends State<MoviesHorizontalListView> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;

      if ((scrollController.position.pixels + 200) >=
          scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(children: [
        if (widget.title != null || widget.subtitle != null)
          _Title(
            title: widget.title!,
            subtitle: widget.subtitle!,
          ),
        Expanded(
            child: ListView.builder(
          controller: scrollController,
          itemCount: widget.movies.length,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return FadeInRight(child: _Slide(movie: widget.movies[index]));
          },
        ))
      ]),
    );
  }
}

class _Title extends StatelessWidget {
  final String title;
  final String subtitle;
  const _Title({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleLarge;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
      child: Row(children: [
        Text(
          title,
          style: textStyle,
        ),
        const Spacer(),
        FilledButton.tonal(
          onPressed: () {},
          child: Text(subtitle),
          style: ButtonStyle(visualDensity: VisualDensity.compact),
        )
      ]),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // * Image
        SizedBox(
          width: 150,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              movie.posterPath,
              fit: BoxFit.cover,
              width: 150,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress != null) {
                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  );
                }

                return GestureDetector(
                  child: FadeIn(child: child),
                  onTap: () => context.push('/movie/${movie.id}'),
                );

                // return child;
              },
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        // * Title
        SizedBox(
          width: 150,
          child: Text(
            movie.title,
            maxLines: 2,
            style: textStyles.titleSmall,
          ),
        ),
        // * Rating
        SizedBox(
          width: 150,
          child: Row(
            children: [
              Icon(
                Icons.star_half_outlined,
                color: Colors.yellow.shade800,
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                movie.voteAverage.toStringAsFixed(2),
                style: textStyles.bodyMedium
                    ?.copyWith(color: Colors.yellow.shade900),
              ),
              const Spacer(),
              Text(HumanFormats.number(movie.popularity),
                  style: textStyles.bodySmall),
            ],
          ),
        )
        // Title
      ]),
    );
  }
}
