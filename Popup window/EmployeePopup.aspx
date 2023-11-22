<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EmployeePopup.aspx.vb" Inherits="Miskovic_OMIS_projekt.EmployeePopup" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Zaposlenik koji će napraviti komisioniranje narudžbe</title>
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
        
        .form-container label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }
        
        .form-container input[type="text"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        
        .form-container .autocomplete {
            position: relative;
        }
        
        .form-container .autocomplete .autocomplete-dropdown {
            position: absolute;
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
            max-height: 200px;
            overflow-y: auto;
            z-index: 1;
        }
        
        .form-container .autocomplete .autocomplete-dropdown ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
        }
        
        .form-container .autocomplete .autocomplete-dropdown li {
            padding: 8px 12px;
            cursor: pointer;
        }
        
        .form-container .autocomplete .autocomplete-dropdown li:hover {
            background-color: #f2f2f2;
        }
        
        .form-container .autocomplete .autocomplete-dropdown li.selected {
            background-color: #ddd;
        }
        
        .form-container .btn-confirm {
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
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

        <div class="form-container">
            <div class="title">
                Zaposlenik koji će napraviti komisioniranje narudžbe
            </div>

            <div>
                <label for="txtSearchEmployee2">Izbor zaposlenika:</label>
            </div>
            <div class="autocomplete">
                <asp:TextBox ID="txtSearchEmployee2" runat="server"></asp:TextBox>
                <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender" runat="server" TargetControlID="txtSearchEmployee2" ServiceMethod="GetEmployees" MinimumPrefixLength="1" CompletionInterval="100"></ajaxToolkit:AutoCompleteExtender>
                <ul class="autocomplete-dropdown" style="display: none;"></ul>
            </div>   
            <button id="btnConfirmIskomisioniraj" runat="server" class="btn-confirm" onserverclick="btnConfirmIskomisioniraj_Click">Potvrdi</button>           
            
            <asp:SqlDataSource ID="EmployeeSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:MyConnectionString %>"
                SelectCommand="PodaciZaTablicuNarudzbe" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
        </div>
    </form>
</body>
</html>

