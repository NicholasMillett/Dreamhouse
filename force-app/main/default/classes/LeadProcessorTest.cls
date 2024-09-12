/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
public class LeadProcessorTest {

    @isTest
    static void testLeadProcessorBatch() {
        // Create a list to hold test Lead records
        List<Lead> testLeads = new List<Lead>();

        // Insert 200 test Lead records
        for (Integer i = 0; i < 200; i++) {
            testLeads.add(new Lead(FirstName = 'Test', LastName = 'Lead' + i, Company = 'Test Company'));
        }
        insert testLeads;

        // Execute the batch job with a batch size of 200
        Test.startTest();
        LeadProcessor batch = new LeadProcessor();
        Database.executeBatch(batch, 200); // Batch size is set to 200
        Test.stopTest();

        // Query the leads to verify the LeadSource was updated
        List<Lead> updatedLeads = [SELECT LeadSource FROM Lead WHERE Id IN :testLeads];

        // Assert that all Leads have LeadSource = 'Dreamforce'
        for (Lead l : updatedLeads) {
            System.assertEquals('Dreamforce', l.LeadSource, 'LeadSource should be updated to Dreamforce');
        }
    }
}

