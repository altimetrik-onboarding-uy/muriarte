<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>ResetHabitDailyStatus</fullName>
        <description>Workflow to reset Habit and Daily status to NEW after 23.59 of each day</description>
        <field>Status__c</field>
        <literalValue>New</literalValue>
        <name>ResetHabitDailyStatus</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
</Workflow>
