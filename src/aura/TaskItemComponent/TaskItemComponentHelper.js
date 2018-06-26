({
	FireRenderEvent : function(component, event) {
		var e = component.getEvent("reRenderTaskTable");
		e.fire();
		console.log("Disparó el evento");

 },


})
