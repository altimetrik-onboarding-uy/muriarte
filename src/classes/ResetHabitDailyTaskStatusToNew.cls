global class ResetHabitDailyTaskStatusToNew implements Database.Batchable<sObject> {

	String query;

	global ResetHabitDailyTaskStatusToNew() {

	}

	global Database.QueryLocator start(Database.BatchableContext BC) {
		return Database.getQueryLocator('SELECT ID, Name, Status__c, Contact__r.Name, RecordType.Name, Contact__c FROM Task__c WHERE RecordType.Name = \'Habit\' or RecordType.Name = \'Daily\'');
	}

   	global void execute(Database.BatchableContext BC, List<Task__c> scope) {

			List<Task__c> tasksToUpdate = new List<Task__c>();

			for(Task__c task: scope)
			{
				task.Status__c = 'New';
				tasksToUpdate.add(task);
			}

			update tasksToUpdate;


	}

	global void finish(Database.BatchableContext BC) {

	}

}