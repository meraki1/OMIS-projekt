<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Artikli.aspx.vb" Inherits="Miskovic_OMIS_projekt.Artikli" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Artikli</title>
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

    .glavni-izbornik {
    margin-top: 10px;
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

    #SearchTextBox {
    padding: 14px 18px;
    margin: 8px 0 8px 10px;
    box-sizing: border-box;
    border: 2px solid #ccc;
    border-radius: 4px;
}

    #SearchButton {
        border-style: none;
            border-color: inherit;
            border-width: medium;
            background-color: darkslategrey;
            color: white;
            padding: 6px 12px;
            text-decoration: none;
            margin: 4px 2px 4px 12px;
            cursor: pointer;
            height: 28px;
            width: 100px;
}
    
    #SearchButton:hover {
    background-color: lightslategrey;
}

    table {
    border-collapse: collapse;
    width: 100%;
    margin-bottom: 10px;
}
    
    table td, table th {
    border: 1px solid #ddd;
    padding: 8px;
    width: 25%;
}
    
    table tr:nth-child(even) {background-color: #f2f2f2;}
    
    table th {
    padding-top: 12px;
    padding-bottom: 12px;
    text-align: left;
    background-color:#4CAF50;
    color:white ;
}

    .first-column {
    font-weight: bold;
}

    .container {
    max-width: 1200px;
    margin: 0 auto;
}
    .pager {
    display: flex;
    justify-content: center;
    margin-bottom: 20px;
}
    
    .pager .page {
    display: inline-block;
    margin: 2px 5px;
    margin-top: 8px;
    }
    
    .pager .page a {
    background-color: midnightblue; 
    color: white;
    padding: 6px 12px;
    text-decoration: none;
    border-radius: 4px;

    }
    
    .pager .page a:hover {
    background-color: darkblue;

    }
    
    .pager input[type="submit"] {
        background-color: midnightblue; 
    color: white;
    padding: 6px 12px;
    text-decoration: none;
    border-radius: 4px;
    cursor: pointer;

    }
    
    .pager input[type="submit"]:hover {
    background-color: darkblue;

    }

    .prev-button, .next-button {
    background-color: midnightblue; 
    color: white;
    padding: 6px 12px;
    text-decoration: none;
    border-radius: 8px;
    cursor: pointer;
    margin-left: 14px;
    margin-right: 14px;
}
    
    .prev-button:hover, .next-button:hover {
    background-color: darkblue;

    }

    .formview-button {
    border: none;
    color: white;
    padding: 12px 18px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin: 12px 8px;
    cursor: pointer;
    transition: all 0.3s ease;
}

.edit-button {
    background-color: #4CAF50;
    cursor:pointer;
}

.delete-button {
    background-color: #f44336; 
    cursor:pointer;
}

.update-button {
    background-color: #008CBA;
        cursor:pointer;

}

.cancel-button {
    background-color:#555555; 
    cursor:pointer;
}

.edit-button:hover {
    background-color: lightgreen;
    cursor:pointer;
}

.delete-button:hover {
    background-color: palevioletred; 
    cursor:pointer;
}

.update-button:hover {
    background-color: dodgerblue;
        cursor:pointer;

}

.cancel-button:hover {
    background-color:darkgrey; 
    cursor:pointer;
}

.insert-button {
    background-color: #ff9800;
    color: white;
    padding: 10px 16px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 14px;
    margin: 10px 6px;
    cursor: pointer;
    border: none;
    border-radius: 4px;
    transition: all 0.3s ease;
}

.insert-button:hover {
    background-color: #ff8000;
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
            ARTIKLI
        </div>

        <div class="container">
            <div class="search">
                <asp:TextBox ID="SearchTextBox" runat="server" placeholder="Pretraži po nazivu artikla" Height="16px"></asp:TextBox>
                <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server"
                    TargetControlID="SearchTextBox"
                    ServiceMethod="SearchArtikli"
                    MinimumPrefixLength="1"
                    CompletionInterval="500"
                    EnableCaching="true"
                    CompletionSetCount="10">
                </ajaxToolkit:AutoCompleteExtender>
                <asp:Button ID="SearchButton" runat="server" CssClass="buttonPretrazi" Text="Pretraži" OnClick="btnSearch_Click" />
            </div>

            <div style="text-align: right; margin-bottom: 10px;">
                <asp:Button ID="InsertButton" runat="server" CommandName="New" Text="Dodaj novi artikl" CssClass="insert-button" OnClick="InsertButton_Click"/>
            </div>

            <asp:FormView ID="FormView1" runat="server" 
                OnPageIndexChanging="FormView1_PageIndexChanging" 
                OnDataBound="FormView1_DataBound" 
                OnModeChanging="FormView1_ModeChanging" 
                OnItemUpdating="FormView1_ItemUpdating" 
                OnItemDeleting="FormView1_ItemDeleting" 
                OnItemInserting="FormView1_ItemInserting">
                <ItemTemplate>
                    <asp:HiddenField ID="IDArtiklHiddenField" runat="server" Value='<%# Eval("[ID artikl]") %>' />
                    <table>
                        <tr>
                            <td class="first-column">Naziv:</td>
                            <td><%# Eval("Naziv") %></td>
                        </tr>
                       <tr>
                           <td class="first-column">Jedinična cijena (bez PDV-a):</td>
                           <td><%# DataBinder.GetPropertyValue(Container.DataItem, "Jedinična cijena (bez PDV-a)") %></td>                       </tr>
                        <tr>
                            <td class="first-column">Jmj:</td>
                            <td><%# Eval("Jmj") %></td>
                        </tr>
                        <tr>
                            <td class="first-column">Opis:</td>
                            <td><%# Eval("Opis") %></td>
                        </tr>
                        <tr>
                            <td class="first-column">Skladišna lokacija:</td>
                            <td><%# Eval("[Skladišna lokacija]") %></td>
                        </tr>
                    </table>
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Uredi" CssClass="edit-button"/>
                    <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Obriši" CssClass="delete-button"/>                 
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:HiddenField ID="IDArtiklHiddenField" runat="server" Value='<%# Bind("[ID artikl]") %>' />
                    <table>
                        <tr>
                            <td class="first-column">Naziv:</td>
                            <td><asp:TextBox ID="NazivTextBox" runat="server" Text='<%# Bind("Naziv") %>' /></td>
                        </tr>
                        <tr>
                            <td class="first-column">Jedinična cijena (bez PDV-a):</td>
                            <td><asp:TextBox ID="CijenaTextBox" runat="server" Text='<%# DataBinder.GetPropertyValue(Container.DataItem, "Jedinična cijena (bez PDV-a)") %>'></asp:TextBox>                              
                            </td>
                        </tr>                                                                         
                        <tr>
                            <td class="first-column">Jmj:</td>
                            <td><asp:TextBox ID="JmjTextBox" runat="server" Text='<%# Bind("Jmj") %>' /></td>
                        </tr>
                        <tr>
                            <td class="first-column">Opis:</td>
                            <td><asp:TextBox ID="OpisTextBox" runat="server" Text='<%# Bind("Opis") %>' /></td>
                        </tr>
                        <tr>
                            <td class="first-column">ID skladišna lokacija:</td>
                            <td>
                                <asp:DropDownList ID="SkladisteDropDownList" runat="server" DataSourceID="SkladisteSqlDataSource" DataTextField="Skladišna lokacija" DataValueField="Skladišna lokacija">
                                </asp:DropDownList>
                            </td>                          
                        </tr>
                    </table>
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Spremi" CssClass="update-button"/>
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Poništi" CssClass="cancel-button"/>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:HiddenField ID="IDArtiklHiddenField" runat="server" Value='<%# Eval("[ID artikl]") %>' />
                    <table>
                        <tr>
                            <td class="first-column">Naziv:</td>
                            <td><asp:TextBox ID="NazivTextBox" runat="server" placeholder="Npr. Matica"/></td>
                        </tr>
                        <tr>
                            <td class="first-column">Jedinična cijena (bez PDV-a):</td>
                            <td><asp:TextBox ID="CijenaTextBox" runat="server" placeholder="Npr. 34,99"/></td>
                        </tr>
                        <tr>
                            <td class="first-column">Jmj:</td>
                            <td><asp:TextBox ID="JmjTextBox" runat="server" placeholder="Npr. KOM"/></td>
                        </tr>
                        <tr>
                            <td class="first-column">Opis:</td>
                            <td><asp:TextBox ID="OpisTextBox" runat="server" placeholder="Npr. M10, din 934..."/></td>
                        </tr>
                        <tr>
                            <td class="first-column">ID skladišna lokacija:</td>
                            <td>
                                <asp:DropDownList ID="SkladisteDropDownList" runat="server" DataSourceID="SkladisteSqlDataSource" DataTextField="Skladišna lokacija" DataValueField="Skladišna lokacija">
                                </asp:DropDownList>                       
                            </td>
                        </tr>
                    </table>
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Spremi" CssClass="update-button"/>
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Poništi" CssClass="cancel-button"/>
                </InsertItemTemplate>
            </asp:FormView>

            <div class="pager">
                <asp:Button ID="PrevButton" runat="server" CommandName="Page" CommandArgument="Prev" Text="< Prethodno" CssClass="prev-button" OnClick="PrevButton_Click"/>
                <asp:Repeater ID="repFooter" OnItemCommand="repFooter_ItemCommand" runat="server">                    
                    <ItemTemplate>
                        <div class="page">
                            <asp:LinkButton ID="lnkPage" Text='<%# Container.DataItem %>' CommandName="ChangePage" CommandArgument='<%# Container.DataItem %>' runat="server" />
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <asp:Button ID="NextButton" runat="server" CommandName="Page" CommandArgument="Next" Text="Sljedeće >" CssClass="next-button" OnClick="NextButton_Click"/>
            </div>

            <div style="text-align: left;">
                <asp:HyperLink ID="HyperLink2" runat="server" CssClass="glavni-izbornik" NavigateUrl="~/LandingPage.aspx">Povratak na glavni izbornik</asp:HyperLink>
            </div>
        </div> 
        
        <asp:SqlDataSource ID="SkladisteSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:MyConnectionString %>" SelectCommand="GetAvailableStorageLocations">
        </asp:SqlDataSource>
    </form>
</body>
</html>