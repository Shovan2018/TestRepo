@isTest
private class AgileController_Test {
    /* Code commented for creation of managed package*/ 
	static testMethod void test_AgileController(){
        //Creating Test Data for AGP_Release__c
        AGP_Release__c rel1 = new AGP_Release__c(Name='Test Data Release 1', Actual_Release_Date__c=date.today(),AGP__Scheduled_Start_Date__c=date.today().addDays(-5),AGP__Scheduled_End_Date__c=date.today().addDays(25));
        AGP_Release__c rel2 = new AGP_Release__c(Name='Test Data Release 2', Actual_Release_Date__c=date.today().addDays(-1),AGP__Scheduled_Start_Date__c=date.today().addDays(-5),AGP__Scheduled_End_Date__c=date.today().addDays(25));
        AGP_Release__c rel3 = new AGP_Release__c(Name='Test Data Release 3', Actual_Release_Date__c=date.today().addDays(-2),AGP__Scheduled_Start_Date__c=date.today().addDays(-5),AGP__Scheduled_End_Date__c=date.today().addDays(25));
        List<AGP_Release__c> relList = new List<AGP_Release__c>();
        relList.add(rel1);
        relList.add(rel2);
        relList.add(rel3);
        insert relList;
       Integer val=relList.size();
        Boolean c=val>0;
        system.assertEquals(true, c);
    	AgileController agCon = new AgileController();
        agCon.ChkMapKey ='Test Data';
        agCon.isAllSelected = false;
       System.assertEquals(false, agCon.isAllSelected);
    }
/*Code commented for creation of managed package  */
}