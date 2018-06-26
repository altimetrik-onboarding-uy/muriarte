({
	getTaskContact : function(component, event) {

		var Task = component.get("v.Task");
		var action = component.get("c.getTaskContactApex");

		console.log(Task);

		action.setParam("task", Task);

		action.setCallback(this, function(response){

		var state = response.getState();

		if(state === "SUCCESS")
		{
			component.set("v.TaskContact", response.getReturnValue());
		}
		else if (state === "ERROR") {

			console.log("Error description: " + response.getError());
		}
		else{
			console.log("Error description: otro error" );
		}
		});

		$A.enqueueAction(action);
},

	DoneHabit : function(component, event){

	var Task = component.get("v.Task");
	var Contact = component.get("v.TaskContact");

	Contact.Total_Points_Awared__c += 1;

	var action = component.get("c.ContactHabitDone");

	action.setParam("contactTask", Contact);
	action.setCallback(this, function(response){

	var state = response.getState();
	console.log(Contact.Total_Points_Awared__c);

	if(state==="SUCCESS")
	{
		console.log("## ", Contact.Total_Points_Awared__c);
	}
	else if(state==="ERROR"){
		console.log("Error description: "+ response.getError());
	}
	});

	$A.enqueueAction(action);
},

	UndoneHabit : function(component, event){
		var Task = component.get("v.Task");
		var Contact = component.get("v.TaskContact");

		Contact.Total_Points_Awared__c -= 1;

		var action = component.get("c.ContactHabitDone");

		action.setParam("contactTask", Contact);
		action.setCallback(this, function(response){

		var state = response.getState();
		console.log(Contact.Total_Points_Awared__c);

		if(state==="SUCCESS")
		{
			console.log("## ", Contact.Total_Points_Awared__c);
		}
		else if(state==="ERROR"){
			console.log("Error description: "+ response.getError());
		}
		});

		$A.enqueueAction(action);
	},


})
