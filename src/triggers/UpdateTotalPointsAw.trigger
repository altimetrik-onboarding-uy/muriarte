trigger UpdateTotalPointsAw on Task__c (after insert, after update) {

    List<ID> contacts = new List<ID>();
    for(Task__c t : trigger.new)
    {
        contacts.add(t.Contact__c);
    }

    Map<Id,Contact> ContactWithTasks = new Map<Id,Contact>([select id, Total_Points_Awared__c, Title from Contact where id in: contacts]);

    List<Contact> ListContact = new List<Contact>();

    for(Task__c t: trigger.new)
    {
       Contact c = ContactWithTasks.get(t.Contact__c);

       Id TaskRTtodo = Schema.SObjectType.Task__c.getRecordTypeInfosByName().get('TO-DO').getRecordTypeId();
       Id TaskRTdaily = Schema.SObjectType.Task__c.getRecordTypeInfosByName().get('Daily').getRecordTypeId();

        if(t.Status__c == 'Completed')
        {
         // TO-DO Tasks Overdue
            IF((t.Due_Date__c < date.today()) && (t.RecordTypeId == TaskRTtodo) )
            {
                decimal PointsToRest = t.Points_Awareded__c / 2;
                c.Total_Points_Awared__c -= PointsToRest ;
            }

         // TO-DO Tasks in Time
            ELSE IF(((t.Due_Date__c >= date.today()) ||(t.Due_Date__c==null)) && (t.RecordTypeId == TaskRTtodo))
            {
                c.Total_Points_Awared__c += t.Points_Awareded__c;
            }

         // Daily task in time
            ELSE IF((t.RecordTypeId == TaskRTdaily) && (t.CreatedDate.day() == date.today().day()))
            {
                c.Total_Points_Awared__c += t.Points_Awareded__c;
            }

         // Daily task overdue

            ELSE IF(((t.CreatedDate.day()) < (date.today().day())) && (t.RecordTypeId == TaskRTdaily))
            {
                date d = date.newInstance(t.CreatedDate.year(), t.CreatedDate.month(), t.CreatedDate.day());
                c.Total_Points_Awared__c -= t.Points_Awareded__c;
            }

            ListContact.add(c);

        }

    }
    update ListContact;
}
