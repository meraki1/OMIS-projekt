Imports System.Data.SqlClient
Imports System.Data

Public Class DetailsPopup
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ' Get row index from query string parameter
            Dim orderID As Integer = Integer.Parse(Request.QueryString("orderID"))

            ' Bind the order items to the GridView
            GridViewItems.DataSource = GetOrderItems(orderID)
            GridViewItems.DataBind()

            ' Set text of Label control
            LabelOrderID.Text = "Narudžba br.: " & orderID.ToString()
        End If
    End Sub

    Private Function GetOrderItems(ByVal orderID As String) As DataTable
        ' Logic to retrieve the order items based on the order ID using the stored procedure 'PodaciZaDetailsPopup'
        ' Create a SqlConnection and SqlCommand to execute the stored procedure
        Dim constr As String = ConfigurationManager.ConnectionStrings("MyConnectionString").ConnectionString
        Using connection As New SqlConnection(constr)
            Using command As New SqlCommand("PodaciZaDetailsPopup", connection)
                command.CommandType = CommandType.StoredProcedure
                command.Parameters.AddWithValue("@OrderID", orderID)

                ' Create a DataTable to hold the result
                Dim orderItems As New DataTable()

                ' Open the connection and execute the command
                connection.Open()
                Using adapter As New SqlDataAdapter(command)
                    adapter.Fill(orderItems)
                End Using

                ' Return the DataTable with order items
                Return orderItems
            End Using
        End Using
    End Function

    Protected Sub GridViewItems_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            ' Set row number
            Dim rowNumber As Integer = e.Row.RowIndex + 1
            Dim labelRowNumber As Label = CType(e.Row.FindControl("LabelRowNumber"), Label)
            labelRowNumber.Text = rowNumber.ToString()

            ' Get values from data row
            Dim row As DataRowView = CType(e.Row.DataItem, DataRowView)
            Dim quantity As Integer = CType(row("Količina"), Integer)
            Dim unitPrice As Decimal = CType(row("Jedinična cijena (bez PDV-a)"), Decimal)
            Dim discount As Decimal = CType(row("Rab, %"), Decimal)

            ' Calculate total
            Dim total As Decimal = quantity * unitPrice
            total *= (1 - discount / 100)

            ' Set text of Label control
            Dim labelTotal As Label = CType(e.Row.FindControl("LabelTotal"), Label)
            labelTotal.Text = total.ToString("C")
        End If
    End Sub

    Protected Sub GridViewItems_PageIndexChanging(sender As Object, e As GridViewPageEventArgs)
        GridViewItems.PageIndex = e.NewPageIndex
    End Sub

    Protected Sub GridViewItems_RowEditing(sender As Object, e As GridViewEditEventArgs)
        ' Put the row into edit mode
        GridViewItems.EditIndex = e.NewEditIndex

        ' Re-bind the GridView to show the row in edit mode
        Dim orderID As Integer = Integer.Parse(Request.QueryString("orderID"))
        GridViewItems.DataSource = GetOrderItems(orderID)
        GridViewItems.DataBind()
    End Sub

    Protected Sub GridViewItems_RowUpdating(sender As Object, e As GridViewUpdateEventArgs)
        ' Get values from form controls
        ' Find the row being edited
        Dim row As GridViewRow = GridViewItems.Rows(GridViewItems.EditIndex)

        ' Find the txtRab control in the row
        Dim txtRab As TextBox = CType(row.FindControl("txtRab"), TextBox)

        ' Get the value from the txtRab control
        Dim rab As Decimal = Decimal.Parse(txtRab.Text)

        ' Find the txtKoličina control in the row
        Dim txtKoličina As TextBox = CType(row.FindControl("txtKoličina"), TextBox)

        ' Get the value from the txtKoličina control
        Dim kolicina As Integer = Integer.Parse(txtKoličina.Text)


        ' Get orderID and stavkaID from query string or command argument
        Dim orderID As Integer = Integer.Parse(Request.QueryString("orderID"))
        Dim stavkaID As Integer = Integer.Parse(GridViewItems.DataKeys(e.RowIndex).Value.ToString())

        ' Call stored procedure to update row
        Using conn As New SqlConnection(ConfigurationManager.ConnectionStrings("MyConnectionString").ConnectionString)
            conn.Open()
            Using cmd As New SqlCommand("UpdateRowDetailsPopup", conn)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@orderID", orderID)
                cmd.Parameters.AddWithValue("@idStavka", stavkaID)
                cmd.Parameters.AddWithValue("@kolicina", kolicina)
                cmd.Parameters.AddWithValue("@rab", rab)
                cmd.ExecuteNonQuery()
            End Using
        End Using

        ' Refresh GridView to show updated row
        GridViewItems.DataSource = GetOrderItems(orderID)
        GridViewItems.DataBind()
    End Sub

    Protected Sub GridViewItems_RowCancelingEdit(sender As Object, e As GridViewCancelEditEventArgs)
        ' Cancel the edit operation
        GridViewItems.EditIndex = -1

        ' Re-bind the GridView to show the row in normal mode
        Dim orderID As Integer = Integer.Parse(Request.QueryString("orderID"))
        GridViewItems.DataSource = GetOrderItems(orderID)
        GridViewItems.DataBind()
    End Sub

    Protected Sub GridViewItems_RowDeleting(sender As Object, e As GridViewDeleteEventArgs)
        ' Get orderID and stavkaID from query string or command argument
        Dim orderID As Integer = Integer.Parse(Request.QueryString("orderID"))
        Dim stavkaID As Integer = Integer.Parse(GridViewItems.DataKeys(e.RowIndex).Value.ToString())

        ' Call stored procedure to delete row
        Using conn As New SqlConnection(ConfigurationManager.ConnectionStrings("MyConnectionString").ConnectionString)
            conn.Open()
            Using cmd As New SqlCommand("DeleteRowDetailsPopup", conn)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@orderID", orderID)
                cmd.Parameters.AddWithValue("@idStavka", stavkaID)
                cmd.ExecuteNonQuery()
            End Using
        End Using

        ' Refresh GridView to remove deleted row
        GridViewItems.DataSource = GetOrderItems(orderID)
        GridViewItems.DataBind()
    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function GetArticles(ByVal prefixText As String) As String()
        Dim constr As String = ConfigurationManager.ConnectionStrings("MyConnectionString").ConnectionString
        Using conn As New SqlConnection(constr)
            Dim cmd As New SqlCommand("SELECT Naziv FROM Artikl WHERE Naziv LIKE '%' + @prefixText + '%'", conn)
            cmd.Parameters.AddWithValue("@prefixText", prefixText)
            Dim da As New SqlDataAdapter(cmd)
            Dim dt As New DataTable()
            da.Fill(dt)
            Dim articles(dt.Rows.Count - 1) As String
            For i As Integer = 0 To dt.Rows.Count - 1
                articles(i) = dt.Rows(i)("Naziv").ToString()
            Next
            Return articles
        End Using
    End Function

    Protected Sub ButtonInsert_Click(sender As Object, e As EventArgs)
        ' Get values from form controls
        Dim kolicina As Integer = Integer.Parse(TextBoxKolicina.Text)
        Dim rab As Decimal = Decimal.Parse(TextBoxRab.Text)
        Dim nazivArtikl As String = TextBoxArtikl.Text
        Dim idNarudzba As Integer = Integer.Parse(Request.QueryString("orderID"))

        ' Call stored procedure to insert new row
        Using conn As New SqlConnection(ConfigurationManager.ConnectionStrings("MyConnectionString").ConnectionString)
            conn.Open()
            Using cmd As New SqlCommand("InsertStavka", conn)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@Kolicina", kolicina)
                cmd.Parameters.AddWithValue("@Rab", rab)
                cmd.Parameters.AddWithValue("@NazivArtikl", nazivArtikl)
                cmd.Parameters.AddWithValue("@IDNarudzba", idNarudzba)
                cmd.ExecuteNonQuery()
            End Using
        End Using

        ' Refresh GridView to show new row
        GridViewItems.DataSource = GetOrderItems(idNarudzba)
        GridViewItems.DataBind()
    End Sub

    Protected Sub ButtonAddNew_Click(sender As Object, e As EventArgs)
        PanelAddNew.Visible = True
    End Sub

    Protected Sub ButtonCancel_Click(sender As Object, e As EventArgs)
        ' Hide the PanelAddNew control
        PanelAddNew.Visible = False

        ' Clear any input fields
        TextBoxKolicina.Text = ""
        TextBoxRab.Text = ""
        TextBoxArtikl.Text = ""
    End Sub
End Class
