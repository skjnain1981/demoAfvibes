public class ContactSearch{

    public static List<contact> searchForContacts(string lastName, String mailingpostalcode){
        return [SELECT id, Name FROM Contact WHERE lastName=:lastName AND mailingpostalcode=:mailingpostalcode];
    }

}