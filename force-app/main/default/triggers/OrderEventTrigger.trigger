// Trigger for listening to Order events.
trigger OrderEventTrigger on Order_Event__e (after insert) {
	// List to hold all Tasks to be created.
    List<Task> Taskslist = new List<Task>();
    
    // Iterate through each notification.
    for (Order_Event__e event : Trigger.New) {
        if (event.Has_Shipped__c  == true) {
            // Create task to dispatch new team.
            Task tk = new Task();
            tk.Priority = 'Medium';
            tk.Subject = 'Follow up on shipped order ' + event.Order_Number__c;
            tk.OwnerId = event.CreatedById;
            Taskslist.add(tk);
        }
   }
    
    // Insert all task corresponding to events received.
    insert Taskslist;
    system.debug('@@@@Taskslist ' + Taskslist);
}