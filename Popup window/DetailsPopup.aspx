<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="DetailsPopup.aspx.vb" Inherits="Miskovic_OMIS_projekt.DetailsPopup" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Lista stavki u narudžbi</title>
    <style>
        .body {
  font-family: Arial, sans-serif;
  font-size: 14px;
  padding: 20px;
}
        
        .container {
  max-width: auto;
  margin: 0 auto;
  background-color: #f8f8f8;
  border: 1px solid #ccc;
  border-radius: 6px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  padding: 20px;
}
        
        .header {
  text-align: center;
  margin-bottom: 20px;
  padding: 10px;
  background-color: #f1f1f1;
  border-radius: 5px;
}
        
        .header span {
  font-size: 24px;
  margin-bottom: 10px;
  color: #333;
}
        
        .button {
  display: inline-block;
  padding: 8px 16px;
  font-size: 14px;
  font-weight: bold;
  text-align: center;
  text-decoration: none;
  background-color: #007bff;
  color: #fff;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  transition: background-color 0.3s ease;
}
        
        .button:hover {
  background-color: #0056b3;
}
        
        .cancel-button {
    background-color: #dc3545;
            margin-left: 36px;
        }
        
        .cancel-button:hover {
    background-color: #c82333;
}


        .gridview {
  margin-top: 20px;
}
        
        .gridview table {
  width: auto;
  border-collapse: collapse;
}
        
        .gridview th,
.gridview td {
  padding: 10px;
  text-align: left;
  border-bottom: 1px solid #ddd;
}
        
        .gridview th {
  background-color: #f2f2f2;
  font-weight: bold;
}
        
        .gridview tr:hover {
  background-color: #f9f9f9;
}
        
        .command-buttons {
            white-space: nowrap;
        }

        #PanelAddNew {
            padding: 16px;
            border: 1px solid #ccc;
        }

        
        #PanelAddNew td {
            padding: 8px;
        }

        #PanelAddNew input[type="text"] {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        #ButtonAddNew {
            margin-bottom: 16px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

        <div class="container">
            <div class="header">
                <asp:Label ID="LabelOrderID" runat="server"></asp:Label>
            </div>

            <div>
                <asp:Button ID="ButtonAddNew" runat="server" Text="Dodaj novu stavku" OnClick="ButtonAddNew_Click" CssClass="button" />
                <asp:Panel ID="PanelAddNew" runat="server" Visible="False">
                    <table>
                        <tr>
                            <td>Količina:</td>
                            <td><asp:TextBox ID="TextBoxKolicina" runat="server"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>Rabat (%):</td>
                            <td>
                                <asp:TextBox ID="TextBoxRab" runat="server" TextMode="SingleLine" placeholder="0,00-100,00 (2 dec. mjesta)"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Artikl:</td>
                            <td>
                                <asp:TextBox ID="TextBoxArtikl" runat="server"></asp:TextBox>
                                <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtenderArtikl" runat="server"
                                    TargetControlID="TextBoxArtikl"
                                    ServiceMethod="GetArticles"
                                    MinimumPrefixLength="1"
                                    CompletionInterval="500"
                                    EnableCaching="true"
                                    CompletionSetCount="10">
                                </ajaxToolkit:AutoCompleteExtender>
                            </td>
                        </tr>
                    </table>
                    <br />
                    <asp:Button ID="ButtonInsert" runat="server" Text="Unesi" OnClick="ButtonInsert_Click" CssClass="button" />
                    <asp:Button ID="ButtonCancel" runat="server" Text="Odustani" OnClick="ButtonCancel_Click" CssClass="button cancel-button" />
                </asp:Panel>
            </div>

            <div class="gridview">
                <asp:GridView ID="GridViewItems" runat="server" AutoGenerateColumns="False" DataKeyNames="ID stavka" AllowPaging="True"
                    OnPageIndexChanging="GridViewItems_PageIndexChanging" OnRowEditing="GridViewItems_RowEditing"
                    OnRowUpdating="GridViewItems_RowUpdating" OnRowCancelingEdit="GridViewItems_RowCancelingEdit"
                    OnRowDeleting="GridViewItems_RowDeleting" OnRowDataBound="GridViewItems_RowDataBound">
                    <Columns>
                        <asp:TemplateField HeaderText="Red. br.">
                            <ItemTemplate>
                                <asp:Label ID="LabelRowNumber" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="ID stavka" HeaderText="Šifra stavke" ReadOnly="True" />
                        <asp:BoundField DataField="Naziv" HeaderText="Naziv" ReadOnly="True"/>
                        <asp:BoundField DataField="Opis" HeaderText="Opis" ReadOnly="True"/>
                        <asp:TemplateField HeaderText="Količina">
                            <ItemTemplate>
                                <asp:Label ID="lblKoličina" runat="server" Text='<%# Eval("Količina") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtKoličina" runat="server" Text='<%# Bind("Količina") %>'></asp:TextBox>                           
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Jmj" HeaderText="Jmj" ReadOnly="True"/>
                        <asp:BoundField DataField="Jedinična cijena (bez PDV-a)" HeaderText="Jedinična cijena (bez PDV-a)" DataFormatString="{0:C}" ReadOnly="True"/>
                        <asp:TemplateField HeaderText="Rabat (%)">
                            <ItemTemplate>
                                <asp:Label ID="LabelDiscount" runat="server" Text='<%# Eval("[Rab, %]") %>'></asp:Label>                              
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtRab" runat="server" Text='<%# Bind("[Rab, %]") %>' TextMode="SingleLine" placeholder="0,00-100,00 (2 dec. mjesta)"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Iznos (bez PDV-a)">
                            <ItemTemplate>
                                <asp:Label ID="LabelTotal" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:CommandField ShowDeleteButton="True" DeleteText="Obriši" ShowEditButton="True" CancelText="Poništi" EditText="Uredi" UpdateText="Spremi" ItemStyle-CssClass="command-buttons" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>

        <asp:SqlDataSource ID="DetailsSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:MyConnectionString %>"
            SelectCommand="PodaciZaDetailsPopup" SelectCommandType="StoredProcedure">            
        </asp:SqlDataSource>
    </form>
</body>
</html>
