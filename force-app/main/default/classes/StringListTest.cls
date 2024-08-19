public class StringListTest {
    public static List<String> generateStringList(Integer num) {
        // Initialize the list to hold the strings
        List<String> stringList = new List<String>();
        
        // Loop from 0 to the input integer - 1
        for (Integer i = 0; i < num; i++) {
            // Add the string with the format "Test n" to the list
            stringList.add('Test ' + i);
        }
        
        // Return the list of strings
        return stringList;
    }
}