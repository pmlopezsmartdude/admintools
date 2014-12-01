<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageUsers.aspx.cs" Inherits="WSATTest.Users" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    
    <style type="text/css">
        .style1
        {
            width: 90px;
        }
        .style2
        {
            width: 89px;
        }
        .style3
        {
            width: 100px;
        }
    </style>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <p><b>Usuarios actuales del sistema</b></p>
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
    <asp:ObjectDataSource ID="UserDataSource" runat="server" SelectMethod="CustomGetAllUsers" TypeName="WSATTest.GetAllUsers"/>
  
    <asp:GridView ID="UserGrid" DataSourceID="UserDataSource" runat="server" 
        AllowPaging="True" CellPadding="4" ForeColor="#333333" GridLines="None" 
        AllowSorting="True" Width="915px" 
        OnSelectedIndexChanged="UserGrid_IndexChanged"> 
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:CommandField ShowSelectButton="True" ButtonType="Button"  />
        </Columns>
        <EditRowStyle BackColor="#7C6F57" />
        <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#E3EAEB" />
        <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#F8FAFA" />
        <SortedAscendingHeaderStyle BackColor="#246B61" />
        <SortedDescendingCellStyle BackColor="#D4DFE1" />
        <SortedDescendingHeaderStyle BackColor="#15524A" />
    </asp:GridView>

    
    <asp:ModalPopupExtender ID="UserGrid_ModalPopupExtender" runat="server" 
        DynamicServicePath="" TargetControlID="hideButton" Enabled="True" PopupControlID="divPopUp" PopupDragHandleControlID="panelDragHandle">
    </asp:ModalPopupExtender>
    <asp:ModalPopupExtender ID="ModalPopupExtender2" runat="server" 
        DynamicServicePath="" TargetControlID="hideButton" Enabled="True" PopupControlID="divConfirmDelete" PopupDragHandleControlID="panelDragHandle">
    </asp:ModalPopupExtender>
    <asp:ModalPopupExtender ID="ModalPopupExtender3" runat="server"
        DynamicServicePath="" TargetControlID="hideButton" Enabled="true" PopupControlID="DivManagePass" PopupDragHandleControlID="panelDragHandle">
    </asp:ModalPopupExtender>


    <div id="hiddenButton" style="display:none;">
        <asp:Button id="hideButton" runat="server" />
    </div>

    <div id="divConfirmDelete" style="display:none; background-color:White; width:200px; height:94px; border: 2px solid black;">
        <p> Esta seguro que desea eliminar este usuario?</p>
        <div style="width:137px; margin: auto auto auto auto; display:inline">
            <asp:Button runat="server" Text="Confirm" ID="ConfirmDelete" 
            OnClick="DeleteUser" Width="63px" style="margin-left: 34px" />
            <asp:Button runat="server" id="CancelDelete" Text="Cancel" 
            style="margin-left: 11px" />
        </div>
    </div>

    <asp:Panel ID="DivManagePass" runat="server" BackColor="White">


     <div id="CambioContrasena" width="600px" Height="55px" style="border: 2px solid black;">

        <fieldset class="changePassword">
         <legend>Modificar contraseña</legend>

           <asp:Table ID="Datos" runat="server" Width="412px" Height="40px" Font-Names="Century Gothic" Font-Size="Small" HorizontalAlign="Center">
          <asp:TableRow HorizontalAlign="Center" VerticalAlign="Middle" Height="5">
              <asp:TableCell>
             
              </asp:TableCell><asp:TableCell >
             
              </asp:TableCell><asp:TableCell width="40" >
              <asp:Label ID="lbl_anterior" runat="server" visible="false"/>
           
              </asp:TableCell></asp:TableRow><asp:TableRow HorizontalAlign="Center" VerticalAlign="Middle"  Height="20">
              <asp:TableCell >
              <asp:Label ID="NewPasswordLabel" runat="server" AssociatedControlID="NewPassword" Text="Nueva Contraseña: " width="200" Height="20"></asp:Label>
              </asp:TableCell><asp:TableCell >
              <asp:TextBox ID="NewPassword" runat="server" CssClass="passwordEntry" TextMode="Password" ValidationGroup="ChangeUserPasswordValidationGroup" width="80" Height="20"></asp:TextBox>
              </asp:TableCell><asp:TableCell width="40">
           <asp:RequiredFieldValidator ID="NewPasswordRequired" runat="server" ControlToValidate="NewPassword" CssClass="failureNotification" Font-Size="x-Small"  ErrorMessage="Nueva contraseña requerida." ToolTip="Nueva contraseña requerida." ValidationGroup="ChangeUserPasswordValidationGroup"/>
              
              </asp:TableCell></asp:TableRow><asp:TableRow HorizontalAlign="Center" VerticalAlign="Middle" Height="20"> 
              <asp:TableCell >
              <asp:Label ID="ConfirmNewPasswordLabel" runat="server" AssociatedControlID="ConfirmNewPassword" width="200" Height="20" Text="Confirmar nueva contraseña:" ></asp:Label>
              </asp:TableCell><asp:TableCell >
              <asp:TextBox ID="ConfirmNewPassword" runat="server" CssClass="passwordEntry" TextMode="Password" width="80" Height="20" ></asp:TextBox>
              
              </asp:TableCell><asp:TableCell width="40">
           <asp:RequiredFieldValidator ID="ConfirmNewPasswordRequired" runat="server" ControlToValidate="ConfirmNewPassword" CssClass="failureNotification" Display="Dynamic" Font-Size="x-Small" ErrorMessage="Confirmar nueva contraseña es requerido." ToolTip="Confirmación de nueva contraseña requerida." ValidationGroup="ChangeUserPasswordValidationGroup"/>
              <asp:CompareValidator ID="NewPasswordCompare" runat="server" ControlToCompare="NewPassword" ControlToValidate="ConfirmNewPassword" CssClass="failureNotification" Display="Dynamic" Font-Size="x-Small" ErrorMessage="Confirmación de contraseña no coincide.." ValidationGroup="ChangeUserPasswordValidationGroup"/> 
             
              </asp:TableCell></asp:TableRow><asp:TableRow HorizontalAlign="Center" VerticalAlign="Middle" Height="20">
              <asp:TableCell Width="100">
           
              </asp:TableCell></asp:TableRow><asp:TableRow HorizontalAlign="Center" VerticalAlign="Middle"  Height="20">
              <asp:TableCell Width="100">
           <asp:Button ID="ChangePasswordPushButton" runat="server" ValidationGroup="ChangeUserPasswordValidationGroup" Text="Cambiar contraseña" onClick="chgpass"/>
              </asp:TableCell><asp:TableCell Width="30">
              <asp:Button ID="CancelPushButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancelar"/>
              </asp:TableCell><asp:TableCell >
              <asp:Label ID="lbl_listo" runat="server"  ></asp:Label>
              </asp:TableCell></asp:TableRow></asp:Table></fieldset></div></asp:Panel><asp:Panel ID="divPopUp" runat="server" BackColor="White">


     <div id="popupcontainer" style="width:620px;  border: 2px solid black;">

        <fieldset class="changePassword">
          <legend>Administrar usuario de sistema</legend><table width="580px" border="0" align="center"><tr>
    <td colspan="4"></td>
  </tr>
  <tr>
    <td height="24" colspan="3"><asp:Label ID="label5" runat="server" Text="Información del usuario" /></td>
    <td width="90"><asp:Label ID="label6" runat="server" Text="Roles" /></td>
  </tr>
  <tr>
    <td class="style1"><asp:Label ID="label7" runat="server" Text="User ID" /></td><td colspan="2"><asp:TextBox runat="server" Enabled="false" ID="UserNameText" /></td><td rowspan="3"> <div id="roleDiv" runat="server"/></td></tr><tr>
    <td 
                    class="style1"><asp:Label ID="label8" runat="server" Text="Email" /></td><td colspan="2"><asp:TextBox runat="server" ID="UserEmailTxt" /></td></tr><tr>
    <td 
                    class="style1">&nbsp;</td><td colspan="2"><asp:CheckBox ID="ActiveBox" runat="server" Text="Active User" /></td></tr><tr>
    <td 
                    class="style1"><asp:Button runat="server" ID="ManageSave" Text="Guardar" OnClick="ManageUserSave"  Width="90"/></td>
    <td 
                    class="style2"><asp:Button runat="server" ID="ManageDelete" Text="Borrar" OnClick="AskMessage" Width="90" /></td>
    <td 
                    class="style3"><asp:Button runat="server" ID="ManagePass" Text="Password" OnClick="ManagePasswd" Width="90" />
    </td><td><asp:Button ID="Button1" runat="server" Text="Cancelar" Width="90" /></td>
    </tr></table></fieldset>                      </div></asp:Panel></asp:Content>