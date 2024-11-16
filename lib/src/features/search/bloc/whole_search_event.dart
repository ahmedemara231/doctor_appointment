part of 'whole_search_bloc.dart';

sealed class SearchEvent {}
final class ClickNewLetter extends SearchEvent{
  String pattern;
  ClickNewLetter(this.pattern);
}
