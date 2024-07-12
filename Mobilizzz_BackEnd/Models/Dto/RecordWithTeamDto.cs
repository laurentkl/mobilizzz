using System.Text.Json.Serialization;
using Mobilizzz_BackEnd.Dtos;

namespace Mobilizzz_BackEnd.Models
{
    public class RecordWithTeamDto : BaseEntityDto
    {
        public TransportMethod TransportMethod { get; set; }
        public RecordType RecordType { get; set; }
        public double Distance { get; set; }
        public int? UserId { get; set; }
        public int? TeamId { get; set; }
        public Team? Team { get; set; }
    }
}
