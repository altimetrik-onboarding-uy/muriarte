global class DailyHabitTaskStatusResetToNew implements Schedulable {


	global void execute(SchedulableContext sc) {

		ResetHabitDailyTaskStatusToNew resetStatusBatch = new ResetHabitDailyTaskStatusToNew();
		Id batchId = Database.executeBatch(resetStatusBatch);

	}


}