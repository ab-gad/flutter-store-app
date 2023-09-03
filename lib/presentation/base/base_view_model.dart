abstract class BaseViewModel
    implements BaseViewModelInput, BaseViewModelOutput {}

/// Base Interface for all view models inputs.
///
/// Contains methods that represents the actions/events
/// that comes from views and will be used in all view models
abstract class BaseViewModelInput {
  void init();
  void dispose();
}

/// Base Interface for all view models outputs.
///
/// Contains methods that represents the results
/// of the input events that will return to views
/// to be updated corresponding to the new state (result)
abstract class BaseViewModelOutput {}
