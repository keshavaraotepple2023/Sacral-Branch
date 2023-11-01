public class CustomerUpdateController {
    
 public String customerName { get; set; }
    
    public List<Customer> updatedCustomers { get; set; }
	
    public CustomerUpdateController(ApexPages.StandardController controller){
        
    }
   
    public void updateAccountType() {
        updatedCustomers = new List<Customer>();

        List<Customer> customersToUpdate = [SELECT Id, Name, Account_Type__c FROM Customer WHERE Name = :customerName];
        
        for (Customer customer : customersToUpdate) {
            customer.Account_Type__c = 'Saving';
            updatedCustomers.add(customer);
        }

        // calling batch apex here:
        CustomerUpdateBatch mybatch = new CustomerUpdateBatch(updatedCustomers);
        Database.executeBatch(mybatch);
    }

}