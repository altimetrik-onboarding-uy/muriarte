({
	doInit : function(component, event, helper) {

		var gTask = component.get("v.Task");
		if(gTask.RecordType.Name === 'Habit')
		{
			component.set("v.isHtask", true);
			console.log();

		}

	}
})