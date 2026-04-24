trigger AccountChangeTrigger on AccountChangeEvent (after insert) {
List<Task> tasks = new List<Task>();
  
  // Iterate through each event message.
  for (AccountChangeEvent event : Trigger.New) {
    // Get some event header fields
    EventBus.ChangeEventHeader header = event.ChangeEventHeader;
    System.debug('Received change event for ' +
      header.entityName +
      ' for the ' + header.changeType + ' operation.');
    // For update operations, we can get a list of changed fields
    if (header.changetype == 'UPDATE') {
        System.debug('List of all changed fields:');
        for (String field : header.changedFields) {
            if (null == event.get(field)) {
                System.debug('Deleted field value (set to null): ' + field);
            } else {
                System.debug('Changed field value: ' + field + '. New Value: '
                    + event.get(field));
            }
        }
    }
    // Get record fields and display only if not null.
    System.debug('Some Employee record field values from the change event:');
    if (event.Name  != null) {
      System.debug('Name  Name: ' + event.Name );
    }
    if (event.AccountNumber  != null) {
      System.debug('Account Number : ' + event.AccountNumber );
    }
    if (event.Phone != null) {
      System.debug('Phone: ' + event.Phone);
    }
    if (event.Type  != null) {
      System.debug('Type : ' + event.Type );
    }
    // Create a followup task
    Task tk = new Task();
    tk.Subject = 'Follow up on account record(s): ' +
    header.recordIds;
    tk.OwnerId = header.CommitUser;
    tasks.add(tk);
  }
  // Insert all tasks in bulk.
  if (tasks.size() > 0) {
    insert tasks;
  }
}