trigger LeadTrigger on Lead (before insert, before update, after update) {
	// System.debug('Lead trigger called');
	
	System.debug('Trigger size: ' + Trigger.size);
    System.debug('is trigger: ' + Trigger.isExecuting);
    System.debug('Operation Type: ' + Trigger.operationType);    
    
    for(Lead leadRecord : Trigger.new) {
        // if lead source is blank, then make it other
        if(Trigger.isBefore && String.isBlank(leadRecord.LeadSource)) {
            leadRecord.LeadSource = 'Other';
        }
        if((leadRecord.Status == 'Closed - Converted' || leadRecord.Status == 'Closed - Not Converted') && Trigger.oldMap.get(leadRecord.Id).Status == 'Open - Not Contacted') {
            leadRecord.Status.addError('You cannot directly close an open lead record');
        }
        // validation rules in Industry fields
        if(String.isEmpty(leadRecord.Industry) && Trigger.isInsert) {
            leadRecord.addError('The industry field cannot be blank');
        }
    }
    // System.debug('Lead trigger 1 is executing');
}