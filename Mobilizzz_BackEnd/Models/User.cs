﻿using System.Text.Json.Serialization;

namespace Mobilizzz_BackEnd.Models
{
    public class User : BaseEntity
    {
        public string UserName { get; set; }
        public string LastName { get; set; }
        public string FirstName { get; set; }
        public string Email { get; set; }
        public string? Password { get; set; }
        public List<Record>? Records { get; set; }
        [JsonIgnore]
        public List<Company>? CompaniesOwnerShip { get; set; }
        [JsonIgnore]
        public List<Team>? TeamsOwnerShip { get; set; }
        [JsonIgnore]
        public List<Team>? Teams { get; set; }
        [JsonIgnore]
        public List<Team>? PendingTeamRequests { get; set; }
    }
}
