part of 'whole_search_bloc.dart';

sealed class SearchEvent {}
final class ClickNewLetter extends SearchEvent{
  String pattern;
  ClickNewLetter(this.pattern);
}

final class SortDoctor extends SearchEvent{
  SortingResult result;
  SortDoctor(this.result);
}

final class ResetSearchState extends SearchEvent{}
final class AddSearchHistory extends SearchEvent{
  String result;
  AddSearchHistory(this.result);
}