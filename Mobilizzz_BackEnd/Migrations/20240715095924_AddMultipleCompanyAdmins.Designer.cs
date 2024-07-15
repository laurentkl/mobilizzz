﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace Mobilizzz_BackEnd.Migrations
{
    [DbContext(typeof(Context))]
    [Migration("20240715095924_AddMultipleCompanyAdmins")]
    partial class AddMultipleCompanyAdmins
    {
        /// <inheritdoc />
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "8.0.6")
                .HasAnnotation("Relational:MaxIdentifierLength", 63);

            NpgsqlModelBuilderExtensions.UseIdentityByDefaultColumns(modelBuilder);

            modelBuilder.Entity("CompanyUser", b =>
                {
                    b.Property<int>("AdminsId")
                        .HasColumnType("integer");

                    b.Property<int>("CompaniesOwnerShipId")
                        .HasColumnType("integer");

                    b.HasKey("AdminsId", "CompaniesOwnerShipId");

                    b.HasIndex("CompaniesOwnerShipId");

                    b.ToTable("AdminCompany", (string)null);
                });

            modelBuilder.Entity("Mobilizzz_BackEnd.Models.Company", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("Id"));

                    b.Property<DateTime>("CreationDate")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.ToTable("Companies");
                });

            modelBuilder.Entity("Mobilizzz_BackEnd.Models.Record", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("Id"));

                    b.Property<DateTime>("CreationDate")
                        .HasColumnType("timestamp with time zone");

                    b.Property<double>("Distance")
                        .HasColumnType("double precision");

                    b.Property<int>("RecordType")
                        .HasColumnType("integer");

                    b.Property<int?>("TeamId")
                        .HasColumnType("integer");

                    b.Property<int?>("TransportMethod")
                        .HasColumnType("integer");

                    b.Property<int?>("UserId")
                        .HasColumnType("integer");

                    b.HasKey("Id");

                    b.HasIndex("TeamId");

                    b.HasIndex("UserId");

                    b.ToTable("Records");
                });

            modelBuilder.Entity("Mobilizzz_BackEnd.Models.Team", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("Id"));

                    b.Property<int?>("CompanyId")
                        .HasColumnType("integer");

                    b.Property<DateTime>("CreationDate")
                        .HasColumnType("timestamp with time zone");

                    b.Property<bool>("IsHidden")
                        .HasColumnType("boolean");

                    b.Property<bool>("IsPrivate")
                        .HasColumnType("boolean");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.HasIndex("CompanyId");

                    b.ToTable("Teams");
                });

            modelBuilder.Entity("Mobilizzz_BackEnd.Models.User", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("Id"));

                    b.Property<int?>("CompanyId")
                        .HasColumnType("integer");

                    b.Property<DateTime>("CreationDate")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("Email")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("FirstName")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("LastName")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("Password")
                        .HasColumnType("text");

                    b.Property<string>("UserName")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.ToTable("Users");
                });

            modelBuilder.Entity("TeamUser", b =>
                {
                    b.Property<int>("TeamsId")
                        .HasColumnType("integer");

                    b.Property<int>("UsersId")
                        .HasColumnType("integer");

                    b.HasKey("TeamsId", "UsersId");

                    b.HasIndex("UsersId");

                    b.ToTable("TeamMember", (string)null);
                });

            modelBuilder.Entity("TeamUser1", b =>
                {
                    b.Property<int>("PendingTeamRequestsId")
                        .HasColumnType("integer");

                    b.Property<int>("PendingUserRequestsId")
                        .HasColumnType("integer");

                    b.HasKey("PendingTeamRequestsId", "PendingUserRequestsId");

                    b.HasIndex("PendingUserRequestsId");

                    b.ToTable("TeamMemberRequest", (string)null);
                });

            modelBuilder.Entity("TeamUser2", b =>
                {
                    b.Property<int>("AdminsId")
                        .HasColumnType("integer");

                    b.Property<int>("TeamsOwnerShipId")
                        .HasColumnType("integer");

                    b.HasKey("AdminsId", "TeamsOwnerShipId");

                    b.HasIndex("TeamsOwnerShipId");

                    b.ToTable("AdminTeam", (string)null);
                });

            modelBuilder.Entity("CompanyUser", b =>
                {
                    b.HasOne("Mobilizzz_BackEnd.Models.User", null)
                        .WithMany()
                        .HasForeignKey("AdminsId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Mobilizzz_BackEnd.Models.Company", null)
                        .WithMany()
                        .HasForeignKey("CompaniesOwnerShipId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("Mobilizzz_BackEnd.Models.Record", b =>
                {
                    b.HasOne("Mobilizzz_BackEnd.Models.Team", "Team")
                        .WithMany()
                        .HasForeignKey("TeamId");

                    b.HasOne("Mobilizzz_BackEnd.Models.User", "User")
                        .WithMany("Records")
                        .HasForeignKey("UserId");

                    b.Navigation("Team");

                    b.Navigation("User");
                });

            modelBuilder.Entity("Mobilizzz_BackEnd.Models.Team", b =>
                {
                    b.HasOne("Mobilizzz_BackEnd.Models.Company", "Company")
                        .WithMany("Teams")
                        .HasForeignKey("CompanyId");

                    b.Navigation("Company");
                });

            modelBuilder.Entity("TeamUser", b =>
                {
                    b.HasOne("Mobilizzz_BackEnd.Models.Team", null)
                        .WithMany()
                        .HasForeignKey("TeamsId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Mobilizzz_BackEnd.Models.User", null)
                        .WithMany()
                        .HasForeignKey("UsersId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("TeamUser1", b =>
                {
                    b.HasOne("Mobilizzz_BackEnd.Models.Team", null)
                        .WithMany()
                        .HasForeignKey("PendingTeamRequestsId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Mobilizzz_BackEnd.Models.User", null)
                        .WithMany()
                        .HasForeignKey("PendingUserRequestsId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("TeamUser2", b =>
                {
                    b.HasOne("Mobilizzz_BackEnd.Models.User", null)
                        .WithMany()
                        .HasForeignKey("AdminsId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Mobilizzz_BackEnd.Models.Team", null)
                        .WithMany()
                        .HasForeignKey("TeamsOwnerShipId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("Mobilizzz_BackEnd.Models.Company", b =>
                {
                    b.Navigation("Teams");
                });

            modelBuilder.Entity("Mobilizzz_BackEnd.Models.User", b =>
                {
                    b.Navigation("Records");
                });
#pragma warning restore 612, 618
        }
    }
}
