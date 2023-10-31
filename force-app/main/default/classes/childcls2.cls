public class childcls2 {
    
    public static void getallcontactsdetails(){
        grandChildCls.dmethod();
        grandChildCls2.emethod();
        grandChildCls3.fmethod();
       List<Contact> conlist = ParentAccountQuerySelector.getContactslist();
        
        for(Contact contacts : conlist){
            
            System.debug('Contact LastName'+contacts.LastName);
            
            System.debug('Contact LastName'+contacts.FirstName);
        }
        
    }
}