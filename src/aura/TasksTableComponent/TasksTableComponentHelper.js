({
	createMap : function(component, event) {

		var action = component.get("c.getTaskItems");

		action.setCallback(this, function(response){

			var state = response.getState();

			if(state === "SUCCESS")
			{
				console.log(JSON.parse(JSON.stringify(response.getReturnValue())));
				component.set("v.listTasks", response.getReturnValue());
				var map = [];
				for(var task of (response.getReturnValue()))
				{
						if(task.Status__c!=="Completed")
						{
							// is there any entry on the map with the current task's record type name?
							if (map[task.RecordType.Name])
							{
								// yes, so I just add the new item
								map[task.RecordType.Name].push(task);

							}
							else
							{
								// create a new entry on the map AND add the task to it.
								map[task.RecordType.Name] = [task];
							}

					}
				}
				console.log('## ', map);
				component.set('v.mapTasks', map);

				// Genero una lista para cada tipo de tarea
				var TDtask = [];

				if(map['TO-DO']!= null)
				{
					for(var name of map['TO-DO'])
					{
						TDtask.push(name);
					}
					component.set('v.ToDoTasks', TDtask);
					console.log(TDtask);
				}

				var Dtask = [];
				if(map['Daily']!=null)
				{
					for(var name of map['Daily'])
					{
						Dtask.push(name);
					}
					component.set('v.DailyTasks', Dtask);
					console.log(Dtask);
				}

				var Htask = [];
				for(var name of map['Habit'])
				{

					Htask.push(name);
				}
				component.set('v.HabitTasks', Htask);
				console.log(Htask);

			}
			else {
				console.log("Task load failed with state: " + state);
			}
		});

		$A.enqueueAction(action);

	},

})
