using MySql.Data.MySqlClient;

class Database
{
    private static string connectionString =
        "Server=localhost;Database=Loja1;Uid=root;Pwd=root;";

    public static MySqlConnection GetConnection()
    {
        return new MySqlConnection(connectionString);
    }
}
