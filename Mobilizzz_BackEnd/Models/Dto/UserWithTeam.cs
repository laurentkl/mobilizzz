using System.Text.Json.Serialization;
using Mobilizzz_BackEnd.Dtos;

namespace Mobilizzz_BackEnd.Models
{
    public class UserWithTeamDto : BaseEntityDto
    {
        public string UserName { get; set; }
        public string LastName { get; set; }
        public string FirstName { get; set; }
        public string Email { get; set; }
        public string? Password { get; set; }
        public List<Record>? Records { get; set; }
        [JsonIgnore]
        public List<Company>? CompaniesOwnerShip { get; set; }
        public List<Team>? TeamsOwnerShip { get; set; }
        public List<Team>? Teams { get; set; }

    }
}
