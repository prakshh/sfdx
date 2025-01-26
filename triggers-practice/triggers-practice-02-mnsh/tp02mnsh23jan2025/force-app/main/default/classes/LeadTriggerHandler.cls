public class LeadTriggerHandler {
    
    public static void beforeInsertHandler(List<Lead> lstNewLeadRecords) {
        for(Lead leadRecord : lstNewLeadRecords) {
            if(String.isBlank(leadRecord.Title)) {
                leadRecord.Title = 'Ok';
            }
            if(String.isEmpty(leadRecord.Industry)) {
                leadRecord.Industry.addError('Industry field cannot be blank');
            }
        }
    }
    
    public static void beforeUpdateHandler(List<Lead> lstNewLeadRecords, Map<Id, Lead> mapOldLeadRecords) {
        for(Lead leadRecord : lstNewLeadRecords) {
            if(String.isBlank(leadRecord.Title)) {
                leadRecord.Title = 'Ok';
            }
            if(String.isEmpty(leadRecord.Industry)) {
                leadRecord.Industry.addError('Industry field cannot be blank');
            }
            // if((leadRecord.Status == 'Closed - Converted' || leadRecord.Status == 'Closed - Not Converted') && Trigger.oldMap.get(leadRecord.Id).Status == 'Open - Not Contacted') {
            if((leadRecord.Status == 'Closed - Converted' || leadRecord.Status == 'Closed - Not Converted') && mapOldLeadRecords.get(leadRecord.Id).Status == 'Open - Not Contacted') {
                leadRecord.Status.addError('Lead Status cannot be marked as Closed directly from Open');
            }
        }
    }
    
    public static void afterInsertHandler(List<Lead> lstNewLeadRecords) {
        List<Task> lstTaskRecords = new List<Task>();
        for(Lead leadRecord: lstNewLeadRecords) {
            Task taskRecord = new Task(Subject='Follow up with Lead', WhoId=leadRecord.Id);
            lstTaskRecords.add(taskRecord);
        }
        insert lstTaskRecords;
    }
    
}