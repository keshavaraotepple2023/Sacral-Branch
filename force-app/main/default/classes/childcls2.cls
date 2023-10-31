public class childcls2 {
    public static void getallcontactsdetails(){
       List<Contact> conlist = ChildCls.getContactslist();
        for(Contact contacts : conlist){
            System.debug('Contact LastName'+contacts.LastName);
            System.debug('Contact LastName'+contacts.FirstName);
        }
    }
}