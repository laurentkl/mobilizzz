using System.Text.Json.Serialization;

namespace Mobilizzz_BackEnd.Models
{
    public class Company: BaseEntity
    {
        public string Name { get; set; }
        // [JsonIgnore]
        // public List<User> Users { get; set; }
        [JsonIgnore]
        public List<Team>? Teams { get; set; }
    }
}
