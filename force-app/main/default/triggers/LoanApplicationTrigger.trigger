trigger LoanApplicationTrigger on Loan_Application__c (after update) {
    public static void sendEmails(List<Loan_Application__c> newLoanApplications, Map<Id, Loan_Application__c> oldLoanApplicationMap) {
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();

        for (Loan_Application__c loanApp : newLoanApplications) {
            Loan_Application__c oldLoanApp = oldLoanApplicationMap.get(loanApp.Id);

            if (loanApp.Loan_Status__c == 'Success' && (oldLoanApp == null || oldLoanApp.Loan_Status__c != 'Success')) {
                // Loan Application updated to Success
                Messaging.SingleEmailMessage successEmail = new Messaging.SingleEmailMessage();
                successEmail.setToAddresses(new List<String>{loanApp.Customer__r.Email});
                successEmail.setSubject('Loan Application Accepted');
                successEmail.setPlainTextBody('Hi ' + loanApp.Last_Name__c + ', Thank you for applying for the loan. Your loan application is accepted. Please visit the bank within the next 5 working days.');
                emailList.add(successEmail);
            } else if (loanApp.Loan_Status__c == 'Declined' && (oldLoanApp == null || oldLoanApp.Loan_Status__c != 'Declined')) {
                // Loan Application updated to Declined
                Messaging.SingleEmailMessage declinedEmail = new Messaging.SingleEmailMessage();
                declinedEmail.setToAddresses(new List<String>{loanApp.Customer__r.Email});
                declinedEmail.setSubject('Loan Application Declined');
                declinedEmail.setPlainTextBody('Hi ' + loanApp.Last_Name__c + ', We regret to inform you that your loan application has been declined. ' + loanApp.feedback__c);
                emailList.add(declinedEmail);
            }
        }

        if (!emailList.isEmpty()) {
            Messaging.sendEmail(emailList);
        }
    }

    // Entry point for the trigger
    public void afterUpdate(List<Loan_Application__c> newLoanApplications, List<Loan_Application__c> oldLoanApplications) {
        Map<Id, Loan_Application__c> oldLoanApplicationMap = new Map<Id, Loan_Application__c>(oldLoanApplications);
        sendEmails(newLoanApplications, oldLoanApplicationMap);
    }
}