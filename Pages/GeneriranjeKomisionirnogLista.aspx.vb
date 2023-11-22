Imports System.Data
Imports System.Data.SqlClient
Imports System.Configuration
Imports System.Web.UI.WebControls
Imports AjaxControlToolkit
Imports iTextSharp.text
Imports iTextSharp.text.pdf

Public Class GeneriranjeKomisionirnogLista
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
            SearchBrojNarudzbeKomisionirnogLista("")
        End If
    End Sub

    Protected Sub SearchBrojNarudzbeKomisionirnogLista(ByVal searchValue As String)
        Dim constr As String = ConfigurationManager.ConnectionStrings("MyConnectionString").ConnectionString
        Using conn As New SqlConnection(constr)
            Dim cmd As New SqlCommand("SearchBrojNarudzbeKomisionirnogLista", conn)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@searchValue", searchValue)
            Dim da As New SqlDataAdapter(cmd)
            Dim dt As New DataTable()
            da.Fill(dt)
            GridView1.DataSource = dt
            GridView1.DataBind()
        End Using
    End Sub

    Protected Sub btnSearch_Click(sender As Object, e As EventArgs)
        Dim searchValue As String = txtSearch.Text.Trim()
        SearchBrojNarudzbeKomisionirnogLista(searchValue)
    End Sub

    Protected Sub GridView1_PageIndexChanging(sender As Object, e As GridViewPageEventArgs)
        GridView1.PageIndex = e.NewPageIndex
        Dim searchValue As String = txtSearch.Text.Trim()
        SearchBrojNarudzbeKomisionirnogLista(searchValue)
    End Sub

    Protected Sub GridView1_Sorting(ByVal sender As Object, ByVal e As GridViewSortEventArgs)
        Dim sortExpression As String = e.SortExpression
        Dim direction As String = String.Empty

        If SortDirection = SortDirection.Ascending Then
            SortDirection = SortDirection.Descending
            direction = "DESC"
        Else
            SortDirection = SortDirection.Ascending
            direction = "ASC"
        End If

        SqlDataSource1.SelectParameters.Clear()
        SqlDataSource1.SelectParameters.Add("SortExpression", sortExpression)
        SqlDataSource1.SelectParameters.Add("SortDirection", direction)
        BindGridView()
    End Sub

    Public Property SortDirection() As SortDirection
        Get
            If ViewState("SortDirection") Is Nothing Then
                ViewState("SortDirection") = SortDirection.Ascending
            End If
            Return DirectCast(ViewState("SortDirection"), SortDirection)
        End Get
        Set(ByVal value As SortDirection)
            ViewState("SortDirection") = value
        End Set
    End Property

    Protected Sub BindGridView()
        ' Bind the GridView to the SqlDataSource control
        GridView1.DataSource = SqlDataSource1
        GridView1.DataBind()
    End Sub

    Protected Sub GenerirajKomisionirniListButton_Click(sender As Object, e As EventArgs) Handles GenerirajKomisionirniListButton.Click
        ' Get the button that raised the event
        Dim btn As Button = CType(sender, Button)

        ' Retrieve orderID from CommandArgument property
        Dim row As GridViewRow = CType(btn.NamingContainer, GridViewRow)
        Dim selectedrowIndex As Integer = row.RowIndex
        Dim selectedrow As GridViewRow = GridView1.Rows(selectedrowIndex)
        Dim orderID As Integer = Integer.Parse(selectedrow.Cells(0).Text)

        ' Redirect to NarudzbeIspis.aspx page with orderID as query string parameter
        Response.Redirect("/Report/GeneriranjeKomisionirnogListaIspis.aspx?orderID=" & orderID)
    End Sub

    Protected WithEvents GenerirajKomisionirniListButton As Button
End Class