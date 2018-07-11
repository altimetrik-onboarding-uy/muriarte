({
	DoneHabit : function(component, event){

	var Task = component.get("v.Task");
	Task.Contact__r.Total_Points_Awared__c += 1;

	var action = component.get("c.updateContact");

	action.setParam("contact", Task.Contact__r);
	action.setCallback(this, function(response){

	var state = response.getState();
	if(state==="SUCCESS")
	{
		console.log("## ", Task.Contact__r.Total_Points_Awared__c);
	}
	else if(state==="ERROR"){
		console.log("Error description: "+ response.getError());
	}
	});

	$A.enqueueAction(action);
},

	UndoneHabit : function(component, event){
		var Task = component.get("v.Task");

		Task.Contact__r.Total_Points_Awared__c -= 1;

		var action = component.get("c.updateContact");

		action.setParam("contact", Task.Contact__r);
		action.setCallback(this, function(response){

		var state = response.getState();

		if(state==="SUCCESS")
		{
			console.log("## ", Task.Contact__r.Total_Points_Awared__c);
		}
		else if(state==="ERROR"){
			console.log("Error description: "+ response.getError());
		}
		});

		$A.enqueueAction(action);
	},


})