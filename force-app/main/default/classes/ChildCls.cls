public class ChildCls {

    public static void fetchaccounts(){
        List<Account> accounts = ParentAccountQuerySelector.queryAccounts();
        
        for(Account ac:accounts){
            System.debug('Account.Name >>>'+ac.Name);
            System.debug('Account.Industry >>'+ac.Industry);
        }
    }
    
     public static List<Contact> getContactslist(){
        List<Contact> con = [SELECT  Id, LastName, FirstName FROM Contact ];
        return con;
    }
}