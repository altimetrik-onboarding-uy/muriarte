({
	FireRenderEvent : function(component, TaskToUpdate) {
		var e = component.getEvent("reRenderTaskTable");
		var task = TaskToUpdate;
		e.setParam("TaskMovedToCompleted", task);
		e.fire();

 },


})