({
	doInit : function(component, event, helper) {
		    var options = [
            { value: "New", label: "New" },
            { value: "In Progress", label: "In Progress" },
            { value: "Completed", label: "Completed" }
        ];
        component.set("v.statusOptions", options);
				// var obj = JSON.parse(JSON.stringify(component.get('v.cTask')));
				console.log('### ', component.get('v.Task'));
    },

		NewTaskStatus : function(component, event, helper){

			var TaskToUpdate = component.get("v.Task");
			var action = component.get("c.updateTask");


			action.setParam("updateTask", TaskToUpdate);
			action.setCallback(this, function(response){

				var state = response.getState();

				if(state==="SUCCESS")
				{
					component.set('v.Task', TaskToUpdate);
					// Para que ande bien el update borrar el IF que le sigue
					if(TaskToUpdate.Status__c === "Completed")
					{

						helper.FireRenderEvent(component, event);
					}
				}
				else {
					console.log("Task update failed with state: " + state);
				}

			});

			$A.enqueueAction(action);
		},




})
