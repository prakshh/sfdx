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
                if((leadRecord.Status == 'Closed - Converted' || leadRecord.Status == 'Closed - Not Converted') && Trigger.oldMap.get(leadRecord.Id).Status == 'Open - Not Contacted') {
                       leadRecord.Status.addError('Lead Status cannot be marked as Closed directly from Open');
                }
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
            for(Lead leadRecord : Trigger.new) {
                Task leadTaskRecord = new Task(Subject='Follow up with Lead', WhoId=leadRecord.Id);
                insert leadTaskRecord;
            }
        }
        
    }
}

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