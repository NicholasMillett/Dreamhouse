@isTest
public class DailyLeadProcessorTest {
    
    @isTest
    static void testLeadSourceUpdate() {
        // Insert 200 Lead records with a blank LeadSource
        List<Lead> leads = new List<Lead>();
        for (Integer i = 0; i < 200; i++) {
            leads.add(new Lead(FirstName = 'Test', LastName = 'Lead' + i, Company = 'Test Company'));
        }
        insert leads;
        
        // Schedule the DailyLeadProcessor job
        Test.startTest();
        String jobId = System.schedule('Test DailyLeadProcessor', '0 0 12 * * ?', new DailyLeadProcessor());
        Test.stopTest();
        
        // Verify that the LeadSource has been updated to 'Dreamforce'
        List<Lead> updatedLeads = [SELECT LeadSource FROM Lead WHERE LeadSource = 'Dreamforce'];
        System.assertEquals(200, updatedLeads.size(), 'All 200 leads should have been updated to Dreamforce');
    }
}
