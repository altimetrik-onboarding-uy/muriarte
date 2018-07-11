({
	doInit : function(component, event, helper) {
		//console.log("AAAAA");
		helper.createMap(component);

	},

	TaskMoveToCompleted : function(component, event, helper){


		var task = event.getParam('TaskMovedToCompleted');



		helper.refreshTasksList(component, task);


	},

})