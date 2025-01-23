trigger LeadTrigger on Lead(before insert) {
    System.debug('Lead trigger called');
    for(Lead leadRecords: trigger.new) {
        // if(String.isEmpty(leadRecords.Title)) {  // isEmpty and isBlank - both works
        if(String.isBlank(leadRecords.Title)) {
            leadRecords.Title = 'Ok';
        }
    }
}