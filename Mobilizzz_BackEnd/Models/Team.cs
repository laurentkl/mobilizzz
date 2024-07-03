using System.Text.Json.Serialization;

namespace Mobilizzz_BackEnd.Models
{
    public class Team: BaseEntity
    {
        public string Name { get; set; }
        public int? CompanyId { get; set; }
        public Company? Company { get; set; }
        public List<int>? AdminIds { get; set; } // Read-only collection for teams

        public List<User>? Users { get; set; } // Read-only collection for teams
        public List<User>? PendingUserRequests { get; set; } // Pending requests to join the team
    }
}
