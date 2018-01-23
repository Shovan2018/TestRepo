public class AccountHandler 
{
 public static account insertNewAccount (string n)
  {
       	account acct = new account ();
      	acct.name= n;
      try { 
    	 insert acct;
    	 return acct;
     
       } catch (DmlException e) {
    System.debug('A DML exception has occurred: ' +
                e.getMessage());
        return null;
    }
}

}