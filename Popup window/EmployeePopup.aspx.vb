Imports System.Data
Imports System.Data.SqlClient
Imports System.Configuration
Imports System.Web.UI.WebControls
Imports AjaxControlToolkit

Public Class EmployeePopup
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function GetEmployees(ByVal prefixText As String) As String()
        Dim constr As String = ConfigurationManager.ConnectionStrings("MyConnectionString").ConnectionString
        Using conn As New SqlConnection(constr)
            Dim cmd As New SqlCommand("SELECT CONCAT([ID zaposlenik], ' - ', [Ime], ' ', [Prezime]) AS FullName FROM Zaposlenik WHERE [ID zaposlenik] LIKE '%' + @prefixText + '%'", conn)
            cmd.Parameters.AddWithValue("@prefixText", prefixText)
            Dim da As New SqlDataAdapter(cmd)
            Dim dt As New DataTable()
            da.Fill(dt)
            Dim employees(dt.Rows.Count - 1) As String
            For i As Integer = 0 To dt.Rows.Count - 1
                employees(i) = dt.Rows(i)("FullName").ToString()
            Next
            Return employees
        End Using
    End Function

    Protected Sub btnConfirmIskomisioniraj_Click(sender As Object, e As EventArgs)
        ' Get selected employee value
        Dim selectedEmployee As String = txtSearchEmployee2.Text

        ' Get row index from query string parameter
        Dim rowIndex As Integer = Integer.Parse(Request.QueryString("rowIndex"))

        ' Redirect back to Narudzbe.aspx page with selected employee value and row index as query string parameters
        Dim script As String = "window.opener.location.href = '/Pages/Narudzbe.aspx?selectedEmployee=" & selectedEmployee & "&rowIndex=" & rowIndex & "';"
        script &= "window.close();"
        ClientScript.RegisterStartupScript(Me.GetType(), "RedirectScript", script, True)
    End Sub
End Class