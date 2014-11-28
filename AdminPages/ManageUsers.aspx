<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageUsers.aspx.cs" Inherits="WSATTest.Users" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    
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
        <div id="DivManagePass" style="display:none; background-color:White; width:400px; height:200px; border: 2px solid black;">
        <fieldset class="changePassword">
        <p> Reestablecer contraseña</p>
                            <p>
                            <asp:Label ID="label" runat="server" Text="Usuario:" />
                            <asp:TextBox runat="server" ID="NameText" ValidationGroup="ChangeUserPasswordValidationGroup"
                            style="margin-left: 110px; width:250px;" />
                        <asp:Label ID="NewPasswordLabel" runat="server" AssociatedControlID="NewPassword">Nueva Contraseña:</asp:Label>
                        <asp:TextBox ID="NewPassword" runat="server" CssClass="passwordEntry" TextMode="Password" ValidationGroup="ChangeUserPasswordValidationGroup"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="NewPasswordRequired" runat="server" ControlToValidate="NewPassword" CssClass="failureNotification" ErrorMessage="Nueva contraseña requerida." ToolTip="Nueva contraseña requerida." ValidationGroup="ChangeUserPasswordValidationGroup"/>
                    </p>
                    <p>
                        <asp:Label ID="ConfirmNewPasswordLabel" runat="server" AssociatedControlID="ConfirmNewPassword">Confirmar nueva contraseña:</asp:Label>
                        <asp:TextBox ID="ConfirmNewPassword" runat="server" CssClass="passwordEntry" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="ConfirmNewPasswordRequired" runat="server" ControlToValidate="ConfirmNewPassword" 
                             CssClass="failureNotification" Display="Dynamic" ErrorMessage="Confirmar nueva contraseña es requerido."
                             ToolTip="Confirmación de nueva contraseña requerida." ValidationGroup="ChangeUserPasswordValidationGroup"/>
                        <asp:CompareValidator ID="NewPasswordCompare" runat="server" ControlToCompare="NewPassword" ControlToValidate="ConfirmNewPassword" 
                             CssClass="failureNotification" Display="Dynamic" ErrorMessage="Confirmación de contraseña no coincide.."
                             ValidationGroup="ChangeUserPasswordValidationGroup"/>
                    </p>
                    </fieldset>
                    <div style="width:137px; margin: auto auto auto auto; display:inline">
                    <p class="submitButton">
                    <asp:Button ID="CancelPushButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"/>
                    <asp:Button ID="ChangePasswordPushButton" runat="server" ValidationGroup="ChangeUserPasswordValidationGroup" Text="Cambiar contraseña" onClick="chgpass"
                         />
                    </p>
                    </div>
    
    </div>


    <div id="divPopUp" style="display:none; background-color: White; width:540px; height:185px; border: 2px solid black;">
        <asp:Panel runat="Server" ID="panelDragHandle" Height="100%" Width="100%" >
            <p>Administrar usuario del sistema...</p>
            <table runat="server" style="width:100%;">
                <tr>
                    <td style="width:65%;">
                        <b>Información del usuario</b>
                    </td>
                    <td style="width:35%">
                        <b>Roles</b>
                    </td>
                </tr>
                <tr>
                    <td style="width:65%">
                        <span>          
                            <asp:Label ID="Label3" runat="server" Text="User ID:"></asp:Label>
                            <asp:TextBox runat="server" Enabled="false" ID="UserNameText" Width="200px" style="margin-left: 44px"  />
                        </span>
                        <br />
                   
                        <span>
                            <asp:Label ID="Label4" runat="server" Text="Email:"></asp:Label>
                            <asp:TextBox runat="server" ID="UserEmailTxt" Width="200px" style="margin-left: 27px" />
                        </span>
                        <br/>
                        <asp:CheckBox ID="ActiveBox" runat="server" Text="Active User" style="margin-left: 110px;" />
                    </td>
                    <td style="vertical-align:top;width:35%">
                        <div id="roleDiv" runat="server" style="height:100%;width:100%"/>
                    </td>
                </tr>
            </table>
        <span> </span>         
        
        <br />   
       

        <div id="btnPanel" style="margin: auto auto auto auto; width:339px;">
            <asp:Button runat="server" ID="ManageSave" Text="Guardar" OnClick="ManageUserSave" />
            <asp:Button runat="server" ID="ManageDelete" Text="Borrar" OnClick="AskMessage" style="margin-left:10px; margin-right: 10px;" />
            <asp:Button runat="server" ID="ManagePass" Text="Password" OnClick="ManagePasswd" style="margin-left:10px; margin-right: 10px;" visible="true" />
            <asp:Button ID="Button1" runat="server" Text="Cancelar" />
        </div>
        </asp:Panel>
    </div>
        
        
        
        
    
    
    </asp:Content>
