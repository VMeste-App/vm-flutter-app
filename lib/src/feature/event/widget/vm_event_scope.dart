// import 'package:flutter/widgets.dart';
// import 'package:vm_app/src/core/di/dependencies.dart';
// import 'package:vm_app/src/feature/event/controller/vm_event_controller.dart';
// import 'package:vm_app/src/feature/event/model/event.dart';

// /// {@template vm_event_scope}
// /// VmEventScope widget.
// /// {@endtemplate}
// class VmEventScope extends StatefulWidget {
//   /// {@macro vm_event_scope}
//   const VmEventScope({super.key, required this.child});

//   final Widget child;

//   static VmEventController controllerOf(BuildContext context) => Dependencies.of(context).eventController;

//   // static void refresh(BuildContext context) => controllerOf(context).fetch(id);

//   // static void fetch(BuildContext context) => controllerOf(context).fetch(id);

//   static void fetchByID(BuildContext context, VmEventID id) => controllerOf(context).fetch(id);

//   static void create(BuildContext context, VmEvent event) => controllerOf(context).create(event);

//   static void update(BuildContext context, VmEvent event) => controllerOf(context).update(event);

//   static void delete(BuildContext context, VmEventID id) => controllerOf(context).delete(id);

//   @override
//   State<VmEventScope> createState() => _VmEventScopeState();
// }

// /// State for widget VmEventScope.
// class _VmEventScopeState extends State<VmEventScope> {
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

//   static _InheritedEvents? maybeOf(BuildContext context, {bool listen = true}) =>
//       listen
//           ? context.dependOnInheritedWidgetOfExactType<_InheritedEvents>()
//           : context.getInheritedWidgetOfExactType<_InheritedEvents>();

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
