<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CommisionedPopup.aspx.vb" Inherits="Miskovic_OMIS_projekt.CommisionedPopup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Potvrda za iskomisioniranu narudžbu</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        
        .title {
            font-size: 24px;
            font-weight: bold;
            text-align: center;
            margin-bottom: 20px;
        }
        
        .form-container {
            max-width: 400px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f5f5f5;
            border-radius: 5px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
        }
        
        .btn-confirm {
            display: block;
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            background-color: #4caf50;
            color: #fff;
            text-align: center;
            text-decoration: none;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        
        .btn-refuse {
            display: block;
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            background-color: #f44336;
            color: #fff;
            text-align: center;
            text-decoration: none;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">     
        <div class="form-container">
            <div class="title">
                Potvrđujete da je narudžba u potpunosti obrađena?
            </div>

            <button id="btnConfirmObrađeno" runat="server" class="btn-confirm" onserverclick="YesButton_Click">Da</button>           
            <button id="btnRefuseObrađeno" runat="server" class="btn-refuse" onserverclick="NoButton_Click">Ne</button>
            
            <asp:SqlDataSource ID="EmployeeSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:MyConnectionString %>"
                SelectCommand="PodaciZaTablicuNarudzbe" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
