trigger TestTrigger4v2 on Contact (after insert, after update){

    Map<Id,Account> accMap = new Map<Id,Account>();
    List<Account> accListToUpdate = new List<Account>();

    for(Contact con: trigger.new){
        if(trigger.isAfter){
            if(con.Description != null && con.AccountId !=null && (trigger.isUpdate && con.Description != trigger.oldmap.get(con.Id).Description || trigger.isInsert) ){
                accMap.put(con.AccountId,con.Account);
            }
        }
    }

    if(!accMap.isEmpty()){
        for(Contact con : trigger.new){
            Account acc = new Account();
            acc.Id = con.AccountId;
            acc.Description = con.Description;
            accListToupdate.add(acc);
        }
        if(!acclisttoupdate.isEmpty()){
            update acclistToUpdate;
        }
    }
}