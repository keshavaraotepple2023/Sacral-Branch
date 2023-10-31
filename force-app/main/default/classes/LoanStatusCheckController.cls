public class LoanStatusCheckController {
    public String loanId { get; set; }
    public String otp { get; set; }
    public Boolean showOtpSection { get; set; }
    public Boolean showStatusSection { get; set; }
    public String status { get; set; }
    public String enteredOTP { get; set; }
    public Loan_Application__c loanApplication { get; set; }
    
    public void verifyOtp() {
        loanApplication = [SELECT Id, Email__c, Loan_Status__c FROM Loan_Application__c WHERE Id = :loanId];
        
        if (loanApplication != null) {
            sendOtp();
            showOtpSection = true;
        }
    }
    
    public void checkStatus() {
        loanApplication = [SELECT Id, Email__c, Loan_Status__c FROM Loan_Application__c WHERE Id = :loanId];
        if (otp == enteredOTP) {
            status = loanApplication.Loan_Status__c;
            showStatusSection = true;
        } else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Invalid OTP. Please try again.'));
        }
    }
    
    public void sendOtp() {
        loanApplication = [SELECT Id, Email__c, Loan_Status__c FROM Loan_Application__c WHERE Id = :loanId];
        // Generate a random four-digit OTP
        otp = String.valueOf(Integer.valueOf(Math.floor(Math.random() * 9000) + 1000));
        showOtpSection = true;
        // Send OTP to the applicant's email address using Salesforce's email functionality
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new String[] { 'keshavarao.tepple@appshark.com' });
        email.setSubject('OTP Verification');
        email.setPlainTextBody('Your OTP is: ' + otp);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
    }
}