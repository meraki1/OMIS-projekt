<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="GeneriranjeKomisionirnogLista.aspx.vb" Inherits="Miskovic_OMIS_projekt.GeneriranjeKomisionirnogLista" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Generiranje komisionirnog lista</title>
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



        .subtitle {
    text-align: left;
    font-size: 20px;
    font-weight: bold;
    margin-top: 30px;
    margin-left: 100px;
    margin-bottom: 30px;
    color: #555;
    letter-spacing: 1px;
}


        .search {
        text-align: center;
        margin-top: 30px;
        margin-bottom: 30px;
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
      
    .buttonPretrazi {
        height: 28px;
        width: 100px;
        margin-left: 10px;
    }

    .grid-container table {
        width: 600px;
        border-collapse: collapse;
    }

    .grid-container th {
        text-align: center;
        padding: 8px;
        background-color: #f2f2f2;
    }

    .grid-container td {
        max-width:1200px;
        text-align: center;
        padding: 8px;
        border-bottom: 1px solid #ddd;
    }

    .grid-container td:nth-child(2){
        text-align: left;
    }

    .grid-container tr:last-child td {
        border-bottom: none;
    }    

    .action-buttons {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 10px;
    }

    .action-button {
        /* Styles for the action button */
        background-color: #4CAF50;
        color: #fff;
        border: none;
        padding: 5px 15px;
        cursor: pointer;
        border-radius: 4px;
        transition: background-color 0.2s ease;
        /* Additional styles for color */
        font-weight: bold;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
    }

    .action-button:hover {
        background-color: #45a049;
    }

    .glavni-izbornik {
    margin-left: 100px;
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

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>       

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
            GENERIRANJE KOMISIONIRNOG LISTA             
        </div>

        <div class="search">
            <asp:TextBox ID="txtSearch" runat="server" placeholder="Pretraži po broju narudžbe"></asp:TextBox>
            <asp:Button ID="ButtonSearch" runat="server" CssClass="buttonPretrazi" Text="Pretraži" OnClick="btnSearch_Click" />
        </div>

        <div class="subtitle">
            Narudžbe s mogućnošću generiranja komisionirnog lista:
        </div>

        <div class="grid-container">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="ID narudžbe" AllowPaging="True" AllowSorting="True"
                OnPageIndexChanging="GridView1_PageIndexChanging" OnSorting="GridView1_Sorting">
                <Columns>                    
                    <asp:BoundField DataField="ID narudžbe" HeaderText="Broj narudžbe" ReadOnly="True" SortExpression="[ID narudžbe]" />
                    <asp:TemplateField HeaderText="ID - Zaposlenik">                        
                        <ItemTemplate>
                            <asp:Label ID="lblIDZaposlenik" runat="server" Text='<%# Eval("[ID - Zaposlenik]") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>                                        
                    <asp:TemplateField HeaderText="Radnja">
                        <ItemTemplate>
                            <div class="action-buttons">
                                <asp:Button ID="GenerirajKomisionirniListButton" runat="server" Text="Generiraj komisionirni list" OnClick="GenerirajKomisionirniListButton_Click" CssClass="action-button"/>
                            </div>
                        </ItemTemplate>                        
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <div style="text-align: left;">
            <asp:HyperLink ID="HyperLink1" runat="server" CssClass="glavni-izbornik" NavigateUrl="~/LandingPage.aspx">Povratak na glavni izbornik</asp:HyperLink>
        </div>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MyConnectionString %>" SelectCommand="PodaciZaTablicuKomisionirnogLista" SelectCommandType="StoredProcedure">
        </asp:SqlDataSource>
    </form>
</body>
</html>
