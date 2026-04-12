// import 'package:flutter/widgets.dart';
// import 'package:vm_app/src/core/di/dependencies.dart';
// import 'package:vm_app/src/feature/event/controller/create/vm_event_create_controller.dart';
// import 'package:vm_app/src/feature/event/model/event.dart';

// /// {@template vm_event_scope}
// /// VmEventScope widget.
// /// {@endtemplate}
// class VmEventCreateScope extends StatefulWidget {
//   /// {@macro vm_event_scope}
//   const VmEventCreateScope({super.key, required this.child});

//   final Widget child;

//   static VmEventCreateController controllerOf(BuildContext context) => Dependencies.of(context).eventController;

//   static void create(BuildContext context, VmEvent event) => controllerOf(context).create(event);

//   @override
//   State<VmEventCreateScope> createState() => _VmEventCreateScopeState();
// }

// /// State for widget VmEventScope.
// class _VmEventCreateScopeState extends State<VmEventCreateScope> {
//   /* #region Lifecycle */
//   @override
//   void initState() {
//     super.initState();
//     // _eventController = Dependencies.of(context).eventController;
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }
//   /* #endregion */

//   @override
//   Widget build(BuildContext context) => _InheritedEvents(child: widget.child);
// }

// class _InheritedEvents extends InheritedModel<VmEventID> {
//   const _InheritedEvents({required this.events, required super.child});

//   final VmEvents events;

//   /// Table of events.
//   final Map<VmEventID, VmEvent> table;

//   static _InheritedEvents? maybeOf(BuildContext context, {bool listen = true}) => listen
//       ? context.dependOnInheritedWidgetOfExactType<_InheritedEvents>()
//       : context.getInheritedWidgetOfExactType<_InheritedEvents>();

//   /// Get product by id.
//   static VmEvent? getById(BuildContext context, VmEventID id, {bool listen = true}) =>
//       (listen ? InheritedModel.inheritFrom<_InheritedEvents>(context, aspect: id) : maybeOf(context, listen: false))
//           ?.table[id];

//   @override
//   bool updateShouldNotify(covariant _InheritedEvents oldWidget) => !identical(table, oldWidget.table);

//   @override
//   bool updateShouldNotifyDependent(covariant _InheritedEvents oldWidget, Set<VmEventID> aspects) {
//     for (final id in aspects) {
//       if (table[id] != oldWidget.table[id]) return true;
//     }
//     return false;
//   }
// }
