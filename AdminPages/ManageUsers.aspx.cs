using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Security.Cryptography;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

 
namespace WSATTest
{
    public partial class Users : System.Web.UI.Page
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            List<string> roles = new List<string>(System.Web.Security.Roles.GetAllRoles());

            foreach (var role in roles)
            {
                CheckBox box = new CheckBox();

                box.ID = role.ToString();
                box.Text = role.ToString();

                roleDiv.Controls.Add(box);

                LiteralControl control = new LiteralControl("<br />");

                roleDiv.Controls.Add(control);
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void UserGrid_IndexChanged(object sender, EventArgs e)
        {
            UserNameText.Text = UserGrid.SelectedRow.Cells[1].Text;
            UserEmailTxt.Text = UserGrid.SelectedRow.Cells[2].Text;

            MembershipUser user = Membership.GetUser(UserNameText.Text);

            if (user != null)
            {

                ActiveBox.Checked = user.IsApproved;

                List<string> roles = new List<string>(System.Web.Security.Roles.GetAllRoles());
                List<string> rolesOfUser = new List<string>(System.Web.Security.Roles.GetRolesForUser(user.UserName));

                foreach (string role in roles)
                {
                    CheckBox box = (CheckBox)roleDiv.FindControl(role);
                    if (rolesOfUser.Contains(role))
                    {
                        box.Checked = true;
                    }    
                }
               
                UserGrid_ModalPopupExtender.Show();
            }

        }

        protected void ManageUserSave(object sender, EventArgs e)
        {
            MembershipUser user = Membership.GetUser(UserGrid.SelectedRow.Cells[1].Text);

            if (user != null)
            {
                user.Email = UserEmailTxt.Text;
                user.IsApproved = ActiveBox.Checked;                
                Membership.UpdateUser(user);

                foreach (Control control in roleDiv.Controls)
                {
                    if (control is CheckBox)
                    {
                        CheckBox box = (CheckBox) control;
                        List<string> roleUsers = new List<string>(System.Web.Security.Roles.GetUsersInRole(box.ID));

                        if (box.Checked)
                        {
                            if (!roleUsers.Contains(user.UserName))
                            {
                                System.Web.Security.Roles.AddUserToRole(user.UserName, box.ID);
                            }
                        }
                        else
                        {
                            if (roleUsers.Contains(user.UserName))
                            {
                                System.Web.Security.Roles.RemoveUserFromRole(user.UserName, box.ID);
                            }
                        }
                    }
                    
                }

                UserGrid.DataBind();                
            } 
        }

        protected void DeleteUser(object sender, EventArgs e)
        {  
            if (!String.IsNullOrEmpty(UserNameText.Text))
            {
                Membership.DeleteUser(UserNameText.Text);
                UserGrid.DataBind();
            }

        }

        protected void chgpass(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(UserNameText.Text))
            {
                string newPassword;
                MembershipUser u = Membership.GetUser(UserNameText.Text);
               

                if (u == null)
                {
                    lbl_anterior.Text = "Username " + Server.HtmlEncode(UserNameText.Text) + " not found. Please check the value and re-enter.";
                    return;
                }

                try
                {
                    newPassword = u.ResetPassword();
                }
                catch (MembershipPasswordException eu)
                {
                    lbl_anterior.Text = "Invalid password answer. Please re-enter and try again.";
                    return;
                } 
                catch (Exception eu)
                {
                    lbl_anterior.Text = eu.Message;
                    return;
                }

                if (newPassword != null)
                {
                    lbl_anterior.Text = Convert.ToString(Server.HtmlEncode(newPassword));
                    //lbl_anterior.Text = newPassword;
                    //  lbl_anterior.Text = "Password reset. Your new password is: " + Server.HtmlEncode(newPassword);
                }
                else
                {
                    Response.Write("<script language=javascript > alert('reset fail'); </script>");
                    //lbl_anterior.Text = "Password reset failed. Please re-enter your values and try again.";
                }



                try
                {
                    if (u.ChangePassword(lbl_anterior.Text, NewPassword.Text))
                    {
                        Response.Write("<script language=javascript > alert('Password changed'); </script>");
                      //  lbl_listo.Text = "Password changed.";
                    }
                    else
                    {
                        Response.Write("<script language=javascript > alert('Password change failed'); </script>");
                        //lbl_listo.Text = "Password change failed. Please re-enter your values and try again.";
                    }
                }
                catch (Exception eu)
                {
                   // lbl_listo.Text = "An exception occurred: " + Server.HtmlEncode(eu.Message) + ". Please re-enter your values and try again.";
                    Response.Write("<script language=javascript > alert('" + Server.HtmlEncode(eu.Message) + "'); </script>");
                }

            }


        }
        
        protected void AskMessage(object sender, EventArgs e)
        {
           ModalPopupExtender2.Show();
        }

        protected void ManagePasswd(object sender, EventArgs e)
        {
            ModalPopupExtender3.Show();
        }

    }
}