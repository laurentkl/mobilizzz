using System.Text.Json.Serialization;

namespace Mobilizzz_BackEnd.Models
{
    public class Team: BaseEntity
    {
        public string Name { get; set; }
        public int LeaderId { get; set; }
        public int? CompanyId { get; set; }
        public Company? Company { get; set; }

        [JsonIgnore]
        public List<User> Users { get; set; } // Read-only collection for teams
    }
}
