public with sharing class TaskItemController {

	@AuraEnabled
	public static List<Task__c> getTaskItems()
	{
		return [SELECT Id, Name, Status__c, Description__c, Contact__c, Contact__r.Name, Contact__r.Total_Points_Awared__c, RecordTypeId, RecordType.Name FROM Task__c];
	}

	@AuraEnabled
	public static Contact getTaskContactApex(Task__c task)
	{
		//ID contactId = task.Contact__c;
		Contact taskContact = [SELECT Id, Name, Total_Points_Awared__c FROM Contact where Id =: task.Contact__c ];
		return taskContact;
	}

	@AuraEnabled
	public static void updateTask(Task__c updateTask){

		update updateTask;
	}

	@AuraEnabled
	public static void ContactHabitDone(Contact contactTask){

		update contactTask;

	}


}
