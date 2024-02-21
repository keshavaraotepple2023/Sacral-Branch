public class ChildCls {
// This is used to fetch accounts 

// This is used to fetch accounts 

// This is used to fetch accounts 
    public static void fetchaccounts(){
        childclsgrandchild1.gmethod();
        childclsgrandchild2.hmethod();
        childclsgrandchild3.imethod();
        List<Account> accounts = ParentAccountQuerySelector.queryAccounts();
        
        for(Account ac:accounts){
            System.debug('Account.Name >>>'+ac.Name);
            System.debug('Account.Industry >>'+ac.Industry);
        }
    }
    
    
}