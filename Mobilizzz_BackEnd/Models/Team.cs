using System.Text.Json.Serialization;

namespace Mobilizzz_BackEnd.Models
{
    public class Team : BaseEntity
    {
        public string Name { get; set; }
        public int? CompanyId { get; set; }
        public Company? Company { get; set; }
        public bool IsHidden { get; set; }
        public bool IsPrivate { get; set; }

        public List<User>? Users { get; set; }
        public List<User>? Admins { get; set; }
        public List<User>? PendingUserRequests { get; set; }
    }
}
