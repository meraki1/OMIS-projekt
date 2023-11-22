<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Narudzbe.aspx.vb" Inherits="Miskovic_OMIS_projekt.Narudzbe" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Narudžbe</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        
        .navbar {
        background-color: #333;
        display: flex;
        justify-content: center;
        font-size: 20px;

        }
        
        .navbar ul {
        list-style-type: none;
        margin: 10px;
        padding: 0;
        display: flex;
    }

    .navbar li {
        margin: 0 15px;
    }

    .navbar a {
        color: #f2f2f2;
        text-decoration: none;
    }

    .navbar a:hover {
        background-color: #ddd;
        color: black;
    }

    .title {
    text-align: center;
    font-size: 36px;
    font-weight: bold;
    margin-top: 30px;
    margin-bottom: 20px;
    color: #333;
    text-transform: uppercase;
    letter-spacing: 2px;
    border: 2px solid #ddd;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}
  
    .search {
        text-align: center;
        margin-top: 15px;
        margin-bottom: 20px;
    }

    #txtSearch {
    padding: 6px 12px;
    margin: 8px 0 8px 10px;
    box-sizing: border-box;
    border: 2px solid #ccc;
    border-radius: 4px;
}

    #ButtonSearch {
        border-style: none;
            border-color: inherit;
            border-width: medium;
            background-color: darkslategrey;
            color: white;
            padding: 6px 12px;
            text-decoration: none;
            margin: 4px 2px 4px 12px;
            cursor: pointer;
}
    
    #ButtonSearch:hover {
    background-color: lightslategrey;
}

    .center-align {
        text-align: center;
    }

    .grid-container {
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
        margin-top: 20px;
        margin-bottom: 20px;
    }

    .modalBackground {
        background-color: #000;
        opacity: 0.7;
        opacity: 0.7;
    }

    .modalPopup {
        background-color: #fff;
        border: 1px solid #ccc;
        padding: 10px;
        width: 300px;
        text-align: center;
    }

    .glavni-izbornik {
    margin-left: 80px;
    margin-top: 100px;
    margin-bottom: 40px;
    font-size: 14px;
    color: #007bff;
    text-decoration: none;
    padding: 12px 20px;
    border-radius: 4px;
    background-color: #f1f1f1;
    transition: all 0.3s ease-in-out;

    }
    
    .glavni-izbornik:hover {
    background-color: #ddd;
    color: white;

    }
    
    .buttonPretrazi {
        height: 28px;
        width: 100px;
        margin-left: 10px;
    }

    .grid-container table {
        width: auto;
        border-collapse: collapse;
    }

    .grid-container th {
        text-align: center;
        padding: 8px;
        background-color: #f2f2f2;
    }

    .grid-container td {
        text-align: left;
        padding: 8px;
        border-bottom: 1px solid #ddd;
    }

    .grid-container td:nth-child(1),
    .grid-container td:nth-child(4),
    .grid-container td:nth-child(5),
    .grid-container td:nth-child(8),
    .grid-container td:nth-child(9){
        text-align: center;
    }

    .grid-container tr:last-child td {
        border-bottom: none;
    }

    /* Adjust column widths */
    .grid-container td:nth-child(3),
    .grid-container td:nth-child(4),
    .grid-container td:nth-child(5) {        
        width: 120px;
    }

    .grid-container td:nth-child(7) {
        width: 100px;
    }

    .details-button {
        background-color: #337ab7;
        color: #fff;
        border: none;
        padding: 5px 10px;
        cursor: pointer;
    }

    .command-buttons {
        text-align: center;
    }

    .command-buttons .btn {
        background-color: #d9534f;
        color: #fff;
        border: none;
        padding: 5px 10px;
        cursor: pointer;
        margin: 2px;
        border-radius: 4px;
        transition: background-color 0.2s ease;
    }

    .command-buttons .btn:hover {
        /* Hover state for command buttons */
        background-color: #c9302c;
    }

    /* Media query for responsiveness */
    @media (max-width: 768px) {
        .command-buttons {
            display: flex;
            flex-direction: column;
        }

        .command-buttons .btn {
            margin: 5px 0;
        }
    }

    .action-buttons {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 10px;
    }

    .action-button {
        background-color: #4CAF50;
        color: #fff;
        border: none;
        padding: 5px 15px;
        cursor: pointer;
        border-radius: 4px;
        transition: background-color 0.2s ease;     
        font-weight: bold;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
    }

    .action-button:hover {
        background-color: #45a049;
    }
</style>

</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
        
        <div class="navbar">
            <ul>
                <li><a href="Narudzbe.aspx">Narudžbe</a></li>
                <li><a href="Artikli.aspx">Artikli</a></li>
                <li><a href="Prijevoznici.aspx">Prijevoznici</a></li>
                <li><a href="Kupci.aspx">Kupci</a></li>
                <li><a href="GeneriranjeKomisionirnogLista.aspx">Generiranje komisionirnog lista</a></li>
            </ul>
        </div>

        <div class="title">
            NARUDŽBE
        </div>

        <div class="search">
            <asp:TextBox ID="txtSearch" runat="server" placeholder="Pretraži po broju narudžbe"></asp:TextBox>
            <asp:Button ID="ButtonSearch" runat="server" CssClass="buttonPretrazi" Text="Pretraži" OnClick="btnSearch_Click" />
        </div>

        <div class="grid-container">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="ID narudžbe" AllowPaging="True" AllowSorting="True"
                OnPageIndexChanging="GridView1_PageIndexChanging" OnRowEditing="GridView1_RowEditing"
                OnRowUpdating="GridView1_RowUpdating" OnRowCancelingEdit="GridView1_RowCancelingEdit"
                OnRowDeleting="GridView1_RowDeleting" OnSorting="GridView1_Sorting">
                <Columns>                    
                    <asp:BoundField DataField="ID narudžbe" HeaderText="Broj narudžbe" ReadOnly="True" SortExpression="[ID narudžbe]" />
                    <asp:BoundField DataField="Kupac" HeaderText="Kupac" ReadOnly="True"/>
                    <asp:TemplateField HeaderText="ID - Zaposlenik">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtSearchEmployee1" runat="server" Text='<%# Bind("[ID - Zaposlenik]") %>'></asp:TextBox>
                            <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtSearchEmployee1" ServiceMethod="GetEmployees" MinimumPrefixLength="1" CompletionInterval="100"></ajaxToolkit:AutoCompleteExtender>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblIDZaposlenik" runat="server" Text='<%# Eval("[ID - Zaposlenik]") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Datum primitka" DataFormatString="{0:d}" HeaderText="Datum primitka" ReadOnly="True"/>
                    <asp:TemplateField HeaderText="Datum isporuke">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtDatumIsporuke" runat="server" Text='<%# Bind("[Datum isporuke]", "{0:d}") %>'></asp:TextBox>
                            <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtDatumIsporuke" Format="dd/MM/yyyy" StartDate='<%# Bind("[Datum primitka]") %>'></ajaxToolkit:CalendarExtender>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblDatumIsporuke" runat="server" Text='<%# Bind("[Datum isporuke]", "{0:d}") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Prijevoznik">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtSearchPrijevoznik" runat="server" Text='<%# Bind("[Prijevoznik]") %>'></asp:TextBox>
                            <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtSearchPrijevoznik" ServiceMethod="GetCarriers" MinimumPrefixLength="1" CompletionInterval="100"></ajaxToolkit:AutoCompleteExtender>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblPrijevoznik" runat="server" Text='<%# Eval("[Prijevoznik]") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status" SortExpression="Status">
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlStatus" runat="server" SelectedValue='<%# Bind("[Status]") %>'>
                                <asp:ListItem Text="Neobrađeno" Value="Neobrađeno"></asp:ListItem>
                                <asp:ListItem Text="U obradi" Value="U obradi"></asp:ListItem>
                                <asp:ListItem Text="Završeno" Value="Završeno"></asp:ListItem>
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("[Status]") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Radnja">
                        <ItemTemplate>
                            <div class="action-buttons">
                                <asp:Button ID="IskomisionirajButton" runat="server" Text="Komisioniraj narudžbu"
                                    Visible='<%# Eval("Status").ToString() = "Neobrađeno" %>' OnClick="IskomisionirajButton_Click" CssClass="action-button" />
                                <asp:Button ID="ObradjenoButton" runat="server" Text="Narudžba obrađena" 
                                    Visible='<%# Eval("Status").ToString() = "U obradi" %>' OnClick="ObradjenoButton_Click" CssClass="action-button" />
                                <asp:Button ID="IspisPdfButton" runat="server" Text="Generiraj PDF" 
                                    Visible='<%# Eval("Status").ToString() = "Završeno" %>' OnClick="IspisPdfButton_Click" CssClass="action-button" />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="DetailsButton" runat="server" Text="Detalji" OnClick="DetailsButton_Click" CssClass="details-button"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowDeleteButton="True" DeleteText="Obriši" ShowEditButton="True" CancelText="Poništi" EditText="Uredi" UpdateText="Spremi" ItemStyle-CssClass="command-buttons"/>
                </Columns>
            </asp:GridView>
        </div>

        <asp:HyperLink ID="HyperLink1" runat="server" CssClass="glavni-izbornik" NavigateUrl="~/LandingPage.aspx">Povratak na glavni izbornik</asp:HyperLink>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MyConnectionString %>" SelectCommand="PodaciZaTablicuNarudzbe" SelectCommandType="StoredProcedure">
        </asp:SqlDataSource>
    </form>
</body>
</html>