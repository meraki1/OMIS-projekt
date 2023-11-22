Imports System.Data
Imports System.Data.SqlClient
Imports System.Configuration
Imports System.Web.UI.WebControls
Imports AjaxControlToolkit

Partial Class CommisionedPopup
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub YesButton_Click(sender As Object, e As EventArgs)
        ' Get row index from query string parameter
        Dim rowIndexCommisioned As Integer = Integer.Parse(Request.QueryString("rowIndexCommisioned"))

        ' Redirect back to Narudzbe.aspx page with row index as query string parameters
        Dim script As String = "window.opener.location.href = '/Pages/Narudzbe.aspx?rowIndexCommisioned=" & rowIndexCommisioned & "';"
        script &= "window.close();"
        ClientScript.RegisterStartupScript(Me.GetType(), "RedirectScript", script, True)
    End Sub

    Protected Sub NoButton_Click(sender As Object, e As EventArgs)
        ' close the popup window
        ClientScript.RegisterStartupScript(Me.GetType(), "ClosePopupScript", "window.close();", True)
    End Sub
End Class