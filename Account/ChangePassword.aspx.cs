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

namespace WSATTest.Account
{
    public partial class ChangePassword : System.Web.UI.Page
    {

        MembershipUser u;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Membership.EnablePasswordReset)
            {
                FormsAuthentication.RedirectToLoginPage();
            }

            Msg.Text = "";

            if (!IsPostBack)
            {
                Msg.Text = "Please supply a username.";
            }
            //else
            //{
            //    VerifyUsername();
            //}
        }


        protected void ChangePasswordPushButton_Click(object sender, EventArgs e)
        {

            string newPassword;
            MembershipUser u = Membership.GetUser(UsernameTextBox.Text, false);

            if (u == null)
            {
                Msg.Text = "Username " + Server.HtmlEncode(UsernameTextBox.Text) + " not found. Please check the value and re-enter.";
                return;
            }

            try
            {
                newPassword = u.ResetPassword();
            }
            catch (MembershipPasswordException eu)
            {
                Msg.Text = "Invalid password answer. Please re-enter and try again.";
                return;
            }
            catch (Exception eu)
            {
                Msg.Text = eu.Message;
                return;
            }

            if (newPassword != null)
            {
                CurrentPassword.Text = Server.HtmlEncode(newPassword);
                Msg.Text = "Password reset. Your new password is: " + Server.HtmlEncode(newPassword);
            }
            else
            {
                Msg.Text = "Password reset failed. Please re-enter your values and try again.";
            }



            try
            {
                if (u.ChangePassword(CurrentPassword.Text, NewPassword.Text))
                {
                    Msg.Text = "Password changed.";
                }
                else
                {
                    Msg.Text = "Password change failed. Please re-enter your values and try again.";
                }
            }
            catch (Exception eu)
            {
                Msg.Text = "An exception occurred: " + Server.HtmlEncode(eu.Message) + ". Please re-enter your values and try again.";
            }








        }

    }
}
