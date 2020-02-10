public class controller4 {

    public list<Account> Accounts { get; set; }
    public controller4()
    {
        Accounts=[select Id,Name,Phone,Rating,AccountNumber,Type from Account];
    }
}