trigger UpdateTotalPointsAw on Task__c (after insert, after update) {

    List<ID> contacts = new List<ID>();
    for(Task__c t : trigger.new)
    {
        contacts.add(t.Contact__c);
    }

    Map<Id,Contact> ContactWithTasks = new Map<Id,Contact>([select id, Total_Points_Awared__c, Title from Contact where id in: contacts]);

    List<Contact> ListContact = new List<Contact>();

    Id TaskRTtodo = Schema.SObjectType.Task__c.getRecordTypeInfosByName().get('TO-DO').getRecordTypeId();
    Id TaskRTdaily = Schema.SObjectType.Task__c.getRecordTypeInfosByName().get('Daily').getRecordTypeId();

    for(Task__c t: trigger.new)
    {
       Contact c = ContactWithTasks.get(t.Contact__c);

      // need the previous status of my record, if any
      //...

      Task__c beforeTriggerRecord = t;
      // beforeTriggerRecord is the record to be updated till this point
      if(c.Total_Points_Awared__c == null)
      {
        c.Total_Points_Awared__c = 0;
      }

      if(trigger.isUpdate)
      {
        beforeTriggerRecord = Trigger.oldMap.get(t.Id); // get the previous version of my task, if any
        // get previous status if there is one, or set to null if there is none
      }

      String previousStatus = null;

      if (beforeTriggerRecord != null) {
          previousStatus = beforeTriggerRecord.Status__c;
      }

        if(t.Status__c == 'Completed'  && ((previousStatus == null) || (previousStatus != 'Completed')))
        {
         // TO-DO Tasks Overdue
            IF((t.Due_Date__c < date.today()) && (t.RecordTypeId == TaskRTtodo) )
            {
                decimal PointsToRest = t.Points_Awareded__c / 2;

                c.Total_Points_Awared__c -= PointsToRest;
            }

         // TO-DO Tasks in Time
            ELSE IF(((t.Due_Date__c >= date.today()) || (t.Due_Date__c == null)) && (t.RecordTypeId == TaskRTtodo))
            {
                c.Total_Points_Awared__c += t.Points_Awareded__c;
            }

         // Daily task in time
            ELSE IF((t.RecordTypeId == TaskRTdaily) )
            {
                c.Total_Points_Awared__c += t.Points_Awareded__c;
            }

            ListContact.add(c);

        }

    }
    update ListContact;
}
