public with sharing class TaskItemController {

	@AuraEnabled
	public static List<Task__c> getTaskItems()
	{
		return [SELECT Id, Name, Status__c, Description__c, Contact__c, Contact__r.Name, Contact__r.Id, Contact__r.Total_Points_Awared__c, RecordTypeId, RecordType.Name FROM Task__c];
	}

	@AuraEnabled
	public static void updateTask(Task__c updateTask){

		update updateTask;
	}

	@AuraEnabled
	public static void updateContact(Contact contact){

// "contact" is the contact record to be updated
		update contact;

	}


}