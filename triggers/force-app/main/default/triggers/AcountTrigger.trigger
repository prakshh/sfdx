trigger AcountTrigger on Account (after insert) {
	UpdateAcc.updateAccountRecords(Trigger.newMap.keySet());
}