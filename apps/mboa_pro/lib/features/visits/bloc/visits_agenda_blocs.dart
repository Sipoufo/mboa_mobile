import 'package:mboa_shared/mboa_shared.dart';

/// The agent's week (CDC M16).
///
/// A subclass rather than a named registration: both personas run the same
/// agenda over different sources, and `get_it` and `BlocProvider` both key on
/// the type. Naming them keeps the two instances from being mistaken for one
/// another in DI, in a provider tree, and in a test.
class AgentAgendaBloc extends VisitsAgendaBloc {
  AgentAgendaBloc({required super.source, super.today});
}

/// The prestataire's own week (RM-M11-10 / RM-M15-06).
class PrestataireAgendaBloc extends VisitsAgendaBloc {
  PrestataireAgendaBloc({required super.source, super.today});
}
