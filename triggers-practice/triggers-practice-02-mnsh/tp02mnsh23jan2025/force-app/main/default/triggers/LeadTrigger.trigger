trigger LeadTrigger on Lead(before insert, before update, after insert, after update) {
    switch on Trigger.operationType {
        
        when BEFORE_INSERT {
            for(Lead leadRecord : Trigger.new) {
                if(String.isBlank(leadRecord.Title)) {
                    leadRecord.Title = 'Ok';
                }
                if(String.isEmpty(leadRecord.Industry)) {
                    leadRecord.Industry.addError('Industry field cannot be blank');
                }
                /*
                if((leadRecord.Status == 'Closed - Converted' || leadRecord.Status == 'Closed - Not Converted') && Trigger.oldMap.get(leadRecord.Id).Status == 'Open - Not Contacted') {
                       leadRecord.Status.addError('Lead Status cannot be marked as Closed directly from Open');
                }
					// you're using Trigger.oldMap in the BEFORE_INSERT context, which is invalid because there is no Trigger.oldMap during an INSERT operation (records don't yet exist in the database). This will throw a null pointer exception.
				*/
            }
        }
        
        when BEFORE_UPDATE {
            for(Lead leadRecord : Trigger.new) {
                if(String.isBlank(leadRecord.Title)) {
                    leadRecord.Title = 'Ok';
                }
                if(String.isEmpty(leadRecord.Industry)) {
                    leadRecord.Industry.addError('Industry field cannot be blank');
                }
                if((leadRecord.Status == 'Closed - Converted' || leadRecord.Status == 'Closed - Not Converted') && Trigger.oldMap.get(leadRecord.Id).Status == 'Open - Not Contacted') {
                       leadRecord.Status.addError('Lead Status cannot be marked as Closed directly from Open');
                }
            }
        }
        
        when AFTER_INSERT {
            /*for(Lead leadRecord : Trigger.new) {
                Task leadTaskRecord = new Task(Subject='Follow up with Lead', WhoId=leadRecord.Id);
                insert leadTaskRecord;
            }*/
            List<Task> lstTaskRecords = new List<Task>();
            for(Lead leadRecord: Trigger.new) {
                Task taskRecord = new Task(Subject='Follow up with Lead', WhoId=leadRecord.Id);
                lstTaskRecords.add(taskRecord);
            }
            insert lstTaskRecords;
            
            System.debug('Trigger size: ' + Trigger.size);				// null
            System.debug('is Trigger: ' + Trigger.isExecuting);			// false
            System.debug('Operation type: ' + Trigger.operationType);	// null
        }
        
    }
}

/* anonymous window

Lead leadRecord = new Lead(LastName='Lead22', Industry='Ok Industries', Company='Ok Co.');
	System.debug('Trigger size: ' + Trigger.size);				// null
	System.debug('is Trigger: ' + Trigger.isExecuting);			// false
	System.debug('Operation type: ' + Trigger.operationType);	// null
insert leadRecord;


List<Lead> lstLeads = new List<Lead>();
for(Integer i=1; i<149; i++) {
    lstLeads.add(new Lead(LastName='Lead'+i, Industry='Ok Industries', Company='Ok Co.'));
}
insert lstLeads;

// select Id, name from Lead where name like '%lead%'
// select Id, subject from Task

*/
/*trigger LeadTrigger on Lead(before insert, before update) {
    System.debug('Lead trigger called');
    for(Lead leadRecord: trigger.new) {
        // if(String.isEmpty(leadRecords.Title)) {  // isEmpty and isBlank - both works
        if(String.isBlank(leadRecord.Title)) {
            leadRecord.Title = 'Ok';
        }
        if(String.isEmpty(leadRecord.Industry)) {
            leadRecord.Industry.addError('Industry field cannot be blank');
        }
        if((leadRecord.Status == 'Closed - Converted' || leadRecord.Status == 'Closed - Not Converted') && Trigger.oldMap.get(leadRecord.Id).Status == 'Open - Not Contacted') {
               leadRecord.Status.addError('Lead Status cannot be marked as Closed directly from Open');
        }
    }
    System.debug('Lead trigger 1 is executing');
}
*/