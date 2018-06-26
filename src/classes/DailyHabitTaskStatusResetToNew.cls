global class DailyHabitTaskStatusResetToNew implements Schedulable {


	global void execute(SchedulableContext sc) {

		List<Task__c> tasksToUpdate = [SELECT Id, Name, Status__c, Contact__r.Name, RecordType.Name, Contact__c FROM Task__c
		WHERE RecordType.Name = 'Habit' or RecordType.Name = 'Daily'];

		for(Task__c task: tasksToUpdate)
		{
			task.Status__c = 'New';
		}

		update tasksToUpdate;
	
	}


}
