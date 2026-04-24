public class RandomContactFactory{
    public static List<Contact> generateRandomContacts(Integer numContacts, String lastName) {
        List<Contact> contactList= new List<Contact>();
        
        for(Integer i=1;i<=numContacts;i++) {
            Contact a = new Contact(FirstName='TestContact' + i,lastName=lastName);
            contactList.add(a);
        }
        return contactList;
    }
}