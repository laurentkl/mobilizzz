using Mobilizzz_BackEnd.Models;
using Microsoft.EntityFrameworkCore;

public class Context : DbContext
{
    public Context() { }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        optionsBuilder.UseNpgsql(@"Server=localhost;Database=MobilizzzTest;Port=5432;User Id=MobilizzzTestUser;Password=toor");
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        modelBuilder.Entity<Team>()
           .HasMany(t => t.Users)
           .WithMany(u => u.Teams)
           .UsingEntity(j => j.ToTable("TeamMember"));
        modelBuilder.Entity<Team>()
            .HasMany(t => t.PendingUserRequests)
            .WithMany(u => u.PendingTeamRequests)
            .UsingEntity(j => j.ToTable("TeamMemberRequest"));
        modelBuilder.Entity<Team>()
        .HasMany(t => t.Admins)
        .WithMany(u => u.TeamsOwnerShip)
        .UsingEntity(j => j.ToTable("AdminTeam"));
        modelBuilder.Entity<User>();
        modelBuilder.Entity<Company>()
            .HasMany(c => c.Admins)
            .WithMany(u => u.CompaniesOwnerShip)
            .UsingEntity(j => j.ToTable("AdminCompany"));
        modelBuilder.Entity<Record>()
        .Property(r => r.TeamId)
        .IsRequired(false);
    }

    public DbSet<Record> Records { get; set; }
    public DbSet<Team> Teams { get; set; }
    public DbSet<User> Users { get; set; }
    public DbSet<Company> Companies { get; set; }
}