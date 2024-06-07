namespace Mobilizzz_BackEnd.Models
{
    public class User: BaseEntity
    {
        public string LastName { get; set; }
        public string FirstName { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }

        public List<Record>? Records { get; set; } // Read-only collection for records
        public List<Team>? Teams { get; set; } // Read-only collection for teams
    }
}
