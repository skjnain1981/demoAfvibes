public class SalesforceAFVibes {
    
    /**
     * Method to query Cases and return Case Number and Status
     * @param caseIds Set of Case record IDs to query
     * @return List of Case records containing CaseNumber and Status fields
     */
    public static List<Case> getCaseDetails(Set<Id> caseIds) {
        if (caseIds.isEmpty()) {
            return new List<Case>();
        }
        
        List<Case> cases = [
            SELECT CaseNumber, Status
            FROM Case
            WHERE Id IN :caseIds
        ];
        
        return cases;
    }
}