using System.Text.Json.Serialization;

namespace Mobilizzz_BackEnd.Models
{
    public class Company: BaseEntity
    {
        public string Name { get; set; }
        [JsonIgnore]
        public List<User>? Leaders { get; set; }
        [JsonIgnore]
        public List<Team>? Teams { get; set; }
    }
}
