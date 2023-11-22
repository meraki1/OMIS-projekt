<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LandingPage.aspx.vb" Inherits="Miskovic_OMIS_projekt.LandingPage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
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
        margin: 10;
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

        .logo {
            border: 1px solid #333;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            margin-top: -15px;

        }


        .logo img {
            width: 600px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="navbar">
            <ul>
                <li><a href="Pages/Narudzbe.aspx">Narudžbe</a></li>
                <li><a href="Pages/Artikli.aspx">Artikli</a></li>
                <li><a href="Pages/Prijevoznici.aspx">Prijevoznici</a></li>
                <li><a href="Pages/Kupci.aspx">Kupci</a></li>
                <li><a href="Pages/GeneriranjeKomisionirnogLista.aspx">Generiranje komisionirnog lista</a></li>
            </ul>
        </div>
        
        <div class="logo">
            <img src="Images/logo.png" alt="OMIS Logo" />
        </div>
    </form>
</body>
</html>