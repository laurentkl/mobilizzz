using System.Text.Json.Serialization;

namespace Mobilizzz_BackEnd.Models
{
    public class Record: BaseEntity
    {
        public string TransportMethod { get; set; }
        public string Type { get; set; }
        public double Distance { get; set; }
        public int UserId { get; set; }
        [JsonIgnore]
        public User? User { get; set; }
        public int TeamId { get; set; }
        [JsonIgnore]
        public Team? Team { get; set; }

    }
}
