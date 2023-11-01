global class CustomerUpdateBatch implements Database.Batchable<sObject> {
    public List<Customer> customersToUpdate;
    
    global CustomerUpdateBatch(List<Customer> customerslist) {
        customersToUpdate = customerslist;
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator ([SELECT Id, Name, Account_Type__c FROM Customer WHERE Id IN :customersToUpdate]);
    }
    
    global void execute(Database.BatchableContext bc, List<sObject> scope) {
        for (sObject record : scope) {
            Customer customers = (Customer)record;
            customers.Account_Type__c = 'Saving';
        }
        update scope;
    }
    
    global void finish(Database.BatchableContext bc) {
        // Sending an email when Account_Type is updated.
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toAddresses = new String[] { 'nagarjuna.sadhu@appshark.com' };
        message.subject = 'Account Type is Updated';
        message.plainTextBody = 'Account Type is updated successfully based on customer Name';
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { message });
        
    }
}