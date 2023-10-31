public class ParentAccountQuerySelector {
    
	public static List<Account> queryAccounts() {
       
        String queryString = 'SELECT Id, Name, Industry FROM Account';

        List<Account> accountList = Database.query(queryString);

        return accountList;
    }
    
   
}