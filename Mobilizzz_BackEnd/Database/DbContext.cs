using Mobilizzz_BackEnd.Models;
using Microsoft.EntityFrameworkCore;

public class Context: DbContext
{
    public Context(){}

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        optionsBuilder.UseNpgsql(@"Server=localhost;Database=MobilizzzTest;Port=5432;User Id=MobilizzzTestUser;Password=toor");
    }

    public DbSet<Record> Records { get; set; }
    public DbSet<Team> Teams { get; set; }
    public DbSet<User> Users { get; set; }
    public DbSet<Company> Companies { get; set; }
}