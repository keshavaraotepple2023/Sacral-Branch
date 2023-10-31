public class LoanApplicationController {
    
    public Loan_Application__c loanApplication { get; set; }
    public Contact contact { get; set; }
    
    public String firstName { get; set; }
    public String lastName { get; set; }
    public String email { get; set; }
    public String loanType { get; set; }
    public Decimal loanAmount { get; set; }
    public Date dob { get; set; }
    public String phone { get; set; }
    
    public LoanApplicationController() {
        loanApplication = new Loan_Application__c();
        contact = new Contact();
    }
    
    public PageReference submitLoanApplication() {
                
        // Find duplicate accounts based on Name and DOB
        List<Contact> duplicateAccounts = [SELECT Id, Name, Birthdate, Phone, email FROM Contact WHERE Lastname = :lastName AND Birthdate = :dob];
        
        if (!duplicateAccounts.isEmpty()) {
            // Link to existing account if found
            Contact = duplicateAccounts[0];
            Contact.Phone = phone;
            Contact.email = email;
        } else {
            // Create a new account if no duplicate found
            Contact = new Contact(LastName = lastName, Birthdate = loanApplication.Date_of_Birth__c, Phone = phone, email = email);
        }
        
        upsert Contact;
        
        // Create Loan Application record
        loanApplication.First_Name__c = firstName;
        loanApplication.Last_Name__c = lastName;
        loanApplication.Email__c = email;
        loanApplication.Amount_Requested__c = loanAmount;
        loanApplication.Loan_Status__c = 'Submitted';
        loanApplication.Date_of_Birth__c = dob;
    	loanApplication.Customer__c = Contact.Id;
        
        insert loanApplication;
 if (loanApplication.First_Name__c != null && loanApplication.Last_Name__c != null && email != null && loanApplication.Amount_Requested__c != null) {
            try {
        // Send email with Loan Application ID
                        
                
                // Send email with Loan Application ID
                String emailSubject = 'Loan Application Submitted';
                String emailBody = 'Thank you for submitting your loan application. Your Loan Application ID is: ' + loanApplication.Id;
                
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(new String[] { email });
                mail.setSubject(emailSubject);
                mail.setPlainTextBody(emailBody);
                
                Messaging.SendEmailResult[] sendResults = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                
                if (sendResults[0].isSuccess()) {
                    // Redirect to thank you page
                    PageReference thankYouPage = new PageReference('/apex/ThankYouPage');
                    thankYouPage.setRedirect(true);
                    return thankYouPage;
                } else {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Failed to send email.'));
                }
            } catch (Exception e) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'An error occurred while creating the loan application.'));
            }
        } else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please fill in all mandatory fields.'));
        }
       return null;
    }
}