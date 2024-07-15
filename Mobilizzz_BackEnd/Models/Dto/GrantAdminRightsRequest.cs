public class GrantAdminRightsRequest
{
    public int TeamId { get; set; } // Id of the team where admin rights are being granted
    public int UserToPromoteId { get; set; } // Id of the user to promote to admin
}