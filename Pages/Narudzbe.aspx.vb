Imports System.Data
Imports System.Data.SqlClient
Imports System.Configuration
Imports System.Web.UI.WebControls
Imports AjaxControlToolkit
Imports iTextSharp.text
Imports iTextSharp.text.pdf

Partial Class Narudzbe
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
            SearchNarudzbe("")
            If Not String.IsNullOrEmpty(Request.QueryString("selectedEmployee")) AndAlso Not String.IsNullOrEmpty(Request.QueryString("rowIndex")) Then
                ' Get selected employee value from query string parameter
                Dim selectedEmployee As String = Request.QueryString("selectedEmployee")

                ' Extract employee ID from selected employee value
                Dim employeeID As String = selectedEmployee.Split(" - ")(0)

                ' Get order ID from specified row index
                Dim rowIndex As Integer = Integer.Parse(Request.QueryString("rowIndex"))
                Dim row As GridViewRow = GridView1.Rows(rowIndex)
                Dim orderID As Integer = Integer.Parse(row.Cells(0).Text)

                ' Update database with selected employee value for specified order ID
                Dim constr As String = ConfigurationManager.ConnectionStrings("MyConnectionString").ConnectionString
                Using conn As New SqlConnection(constr)
                    Dim cmd As New SqlCommand("UPDATE Narudžba SET [ID zaposlenik] = @employeeID, [ID statusa] = '2' WHERE [ID narudžbe] = @orderID", conn)
                    cmd.Parameters.AddWithValue("@employeeID", employeeID)
                    cmd.Parameters.AddWithValue("@orderID", orderID)
                    conn.Open()
                    cmd.ExecuteNonQuery()
                    conn.Close()
                End Using

                ' Refresh GridView data
                SearchNarudzbe("")
            End If

            If Not String.IsNullOrEmpty(Request.QueryString("rowIndexCommisioned")) Then
                ' Get row index from query string parameter
                Dim rowIndex As Integer = Integer.Parse(Request.QueryString("rowIndexCommisioned"))

                ' Get order ID from specified row index
                Dim row As GridViewRow = GridView1.Rows(rowIndex)
                Dim orderID As Integer = Integer.Parse(row.Cells(0).Text)

                ' update the data in the database for specified order ID
                Using conn As New SqlConnection(ConfigurationManager.ConnectionStrings("MyConnectionString").ConnectionString)
                    conn.Open()
                    Using cmd As New SqlCommand("UPDATE Narudžba SET [Datum isporuke] = @Datum_isporuke, [ID statusa] = @Status WHERE [ID narudžbe] = @orderID", conn)
                        cmd.Parameters.AddWithValue("@Datum_isporuke", DateTime.Now)
                        cmd.Parameters.AddWithValue("@Status", 3)
                        cmd.Parameters.AddWithValue("@orderID", orderID)
                        cmd.ExecuteNonQuery()
                    End Using
                    conn.Close()
                End Using

                ' Refresh GridView data
                SearchNarudzbe("")
            End If
        End If
    End Sub

    Protected Sub SearchNarudzbe(ByVal searchValue As String)
        Dim constr As String = ConfigurationManager.ConnectionStrings("MyConnectionString").ConnectionString
        Using conn As New SqlConnection(constr)
            Dim cmd As New SqlCommand("SearchBrojNarudzbe", conn)
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
        SearchNarudzbe(searchValue)
    End Sub

    Protected Sub GridView1_PageIndexChanging(sender As Object, e As GridViewPageEventArgs)
        GridView1.PageIndex = e.NewPageIndex
        Dim searchValue As String = txtSearch.Text.Trim()
        SearchNarudzbe(searchValue)
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
        BindData()
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

    Private Sub BindData()
        ' Bind data to the GridView control
        GridView1.DataSource = SqlDataSource1
        GridView1.DataBind()
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As GridViewRowEventArgs)
        Dim dRowView As DataRowView = DirectCast(e.Row.DataItem, DataRowView)
        If e.Row.RowType = DataControlRowType.DataRow Then
            If (e.Row.RowState And DataControlRowState.Edit) > 0 Then
                Dim ddlStatus As DropDownList = DirectCast(e.Row.FindControl("ddlStatus"), DropDownList)
                ddlStatus.SelectedValue = dRowView(8).ToString()
            End If
        End If
    End Sub

    Protected Sub GridView1_RowEditing(sender As Object, e As GridViewEditEventArgs)
        ' Set the EditIndex property to put the selected row in edit mode
        GridView1.EditIndex = e.NewEditIndex
        ' Rebind the data to the GridView control to show the row in edit mode
        BindData()

        ' Find the DropDownList control and check its value
        Dim ddlStatus As DropDownList = CType(GridView1.Rows(e.NewEditIndex).FindControl("ddlStatus"), DropDownList)
        If ddlStatus.SelectedValue = "Neobrađeno" Then
            ' Find the TextBox control and clear its value
            Dim txtSearchEmployee1 As TextBox = CType(GridView1.Rows(e.NewEditIndex).FindControl("txtSearchEmployee1"), TextBox)
            txtSearchEmployee1.Text = String.Empty
        End If
    End Sub

    Protected Sub GridView1_RowUpdating(sender As Object, e As GridViewUpdateEventArgs)
        Dim orderDate As Date

        ' Retrieve the new values entered by the user
        Dim orderID As Integer = Integer.Parse(GridView1.DataKeys(e.RowIndex).Value.ToString())
        Dim ddlStatus As DropDownList = CType(GridView1.Rows(e.RowIndex).FindControl("ddlStatus"), DropDownList)
        Dim txtDatumIsporuke As TextBox = CType(GridView1.Rows(e.RowIndex).FindControl("txtDatumIsporuke"), TextBox)
        Dim deliveryDate As Date?
        If Not String.IsNullOrEmpty(txtDatumIsporuke.Text) Then
            deliveryDate = Date.Parse(txtDatumIsporuke.Text)
        End If
        Dim carrier As String = CType(GridView1.Rows(e.RowIndex).FindControl("txtSearchPrijevoznik"), TextBox).Text
        Dim employeeIDWithName As String = CType(GridView1.Rows(e.RowIndex).FindControl("txtSearchEmployee1"), TextBox).Text

        ' Perform validations
        If ddlStatus.SelectedValue <> "Završeno" And Not String.IsNullOrEmpty(txtDatumIsporuke.Text) Then
            ' Show error message
            lblError.Text = "Datum isporuke moguće je unijeti samo ako je status 'Završeno'."
            Return
        End If

        ' Retrieve the order date from the database        
        Dim constr As String = ConfigurationManager.ConnectionStrings("MyConnectionString").ConnectionString
        Using connection As New SqlConnection(constr)
            Using command As New SqlCommand("SELECT [Datum primitka] FROM Narudžba WHERE [ID narudžbe] = @OrderID", connection)
                command.Parameters.AddWithValue("@OrderID", orderID)
                connection.Open()
                Using reader As SqlDataReader = command.ExecuteReader()
                    If reader.Read() Then
                        orderDate = reader.GetDateTime(0)
                    Else
                        ' Handle the case where no rows were returned
                    End If
                End Using
            End Using
        End Using


        If Not String.IsNullOrEmpty(txtDatumIsporuke.Text) And ddlStatus.SelectedValue = "Završeno" Then
            If deliveryDate < orderDate Then
                ' Show error message
                lblError.Text = "Datum isporuke mora biti veći ili jednak datumu primitka u istom retku."
                Return
            End If
        End If


        ' Update your data source with the new values using a stored procedure
        Using connection As New SqlConnection(constr)
            Using command As New SqlCommand("UpdateRowOperation", connection)
                command.CommandType = CommandType.StoredProcedure
                command.Parameters.AddWithValue("@OrderID", orderID)
                If Not String.IsNullOrEmpty(txtDatumIsporuke.Text) Then
                    command.Parameters.AddWithValue("@DeliveryDate", deliveryDate)
                End If
                command.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue)
                command.Parameters.AddWithValue("@Carrier", carrier)
                If Not String.IsNullOrEmpty(employeeIDWithName) Then
                    command.Parameters.AddWithValue("@employeeIDWithName", employeeIDWithName)
                End If
                connection.Open()
                command.ExecuteNonQuery()
            End Using
        End Using

        ' Reset the EditIndex property and rebind the data to the GridView control
        GridView1.EditIndex = -1
        BindData()
    End Sub

    Protected Sub GridView1_RowCancelingEdit(sender As Object, e As GridViewCancelEditEventArgs)
        ' Reset the EditIndex property to exit edit mode
        GridView1.EditIndex = -1
        ' Rebind the data to the GridView control to show the row in normal mode
        BindData()
    End Sub

    Protected Sub GridView1_RowDeleting(sender As Object, e As GridViewDeleteEventArgs)
        ' Retrieve the order ID of the row being deleted
        Dim orderID As Integer = Integer.Parse(GridView1.DataKeys(e.RowIndex).Value.ToString())

        ' Delete the row from the database using a stored procedure
        Dim constr As String = ConfigurationManager.ConnectionStrings("MyConnectionString").ConnectionString
        Using connection As New SqlConnection(constr)
            Using command As New SqlCommand("DeleteRowOperation", connection)
                command.CommandType = CommandType.StoredProcedure
                command.Parameters.AddWithValue("@OrderID", orderID)
                connection.Open()
                command.ExecuteNonQuery()
            End Using
        End Using

        ' Rebind the data to the GridView control
        BindData()
    End Sub


    <System.Web.Services.WebMethod()>
    Public Shared Function GetCarriers(ByVal prefixText As String) As String()
        Dim constr As String = ConfigurationManager.ConnectionStrings("MyConnectionString").ConnectionString
        Using conn As New SqlConnection(constr)
            Dim cmd As New SqlCommand("SELECT Prijevoznik.[Naziv] FROM Prijevoznik WHERE Prijevoznik.[Naziv] LIKE '%' + @prefixText + '%'", conn)
            cmd.Parameters.AddWithValue("@prefixText", prefixText)
            Dim da As New SqlDataAdapter(cmd)
            Dim dt As New DataTable()
            da.Fill(dt)
            Dim carriers(dt.Rows.Count - 1) As String
            For i As Integer = 0 To dt.Rows.Count - 1
                carriers(i) = dt.Rows(i)("Naziv").ToString()
            Next
            Return carriers
        End Using
    End Function

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

    Protected Sub IskomisionirajButton_Click(sender As Object, e As EventArgs)
        ' Get the button that raised the event
        Dim btn As Button = CType(sender, Button)

        ' Get the row that contains this button
        Dim row As GridViewRow = CType(btn.NamingContainer, GridViewRow)

        ' Get the row index
        Dim rowIndex As Integer = row.RowIndex

        ' Open popup window with row index as query string parameter
        Dim width As Integer = 400
        Dim height As Integer = 400
        Dim left As Integer = (System.Web.HttpContext.Current.Request.Browser.ScreenPixelsWidth) / 2
        Dim top As Integer = (System.Web.HttpContext.Current.Request.Browser.ScreenPixelsHeight) / 2

        Dim script As String = "window.open('/Popup window/EmployeePopup.aspx?rowIndex=" & rowIndex & "', 'EmployeePopup', 'width=" & width.ToString() & ",height=" & height.ToString() & ",left=" & left.ToString() & ",top=" & top.ToString() & "');"
        ClientScript.RegisterStartupScript(Me.GetType(), "PopupScript", script, True)
    End Sub

    Protected Sub ObradjenoButton_Click(sender As Object, e As EventArgs)
        ' Get the button that raised the event
        Dim btn As Button = CType(sender, Button)

        ' Get the row that contains this button
        Dim row As GridViewRow = CType(btn.NamingContainer, GridViewRow)

        ' Get the row index
        Dim rowIndexCommisioned As Integer = row.RowIndex

        ' Open popup window with row index as query string parameter
        Dim width As Integer = 400
        Dim height As Integer = 400
        Dim left As Integer = (System.Web.HttpContext.Current.Request.Browser.ScreenPixelsWidth) / 2
        Dim top As Integer = (System.Web.HttpContext.Current.Request.Browser.ScreenPixelsHeight) / 2

        ' Open popup window with row index as query string parameter
        Dim script As String = "window.open('/Popup window/CommisionedPopup.aspx?rowIndexCommisioned=" & rowIndexCommisioned & "', 'CommisionedPopup', 'width=" & width.ToString() & ",height=" & height.ToString() & ",left=" & left.ToString() & ",top=" & top.ToString() & "');"
        ClientScript.RegisterStartupScript(Me.GetType(), "PopupScript", script, True)
    End Sub

    Protected Sub IspisPdfButton_Click(sender As Object, e As EventArgs) Handles IspisPdfButton.Click
        ' Get the button that raised the event
        Dim btn As Button = CType(sender, Button)

        ' Retrieve orderID from CommandArgument property
        Dim row As GridViewRow = CType(btn.NamingContainer, GridViewRow)
        Dim selectedrowIndex As Integer = row.RowIndex
        Dim selectedrow As GridViewRow = GridView1.Rows(selectedrowIndex)
        Dim orderID As Integer = Integer.Parse(selectedrow.Cells(0).Text)

        ' Redirect to NarudzbeIspis.aspx page with orderID as query string parameter
        Response.Redirect("/Report/NarudzbeIspis.aspx?orderID=" & orderID)
    End Sub

    Protected WithEvents IspisPdfButton As Button

    Protected Sub DetailsButton_Click(sender As Object, e As EventArgs)
        ' Get the button that raised the event
        Dim btn As Button = CType(sender, Button)

        ' Retrieve orderID from CommandArgument property
        Dim row As GridViewRow = CType(btn.NamingContainer, GridViewRow)
        Dim selectedrowIndex As Integer = row.RowIndex
        Dim selectedrow As GridViewRow = GridView1.Rows(selectedrowIndex)
        Dim orderID As Integer = Integer.Parse(selectedrow.Cells(0).Text)

        ' Open popup window with orderID as query string parameter
        Dim width As Integer = 1000
        Dim height As Integer = 800
        Dim left As Integer = (System.Web.HttpContext.Current.Request.Browser.ScreenPixelsWidth) / 2
        Dim top As Integer = (System.Web.HttpContext.Current.Request.Browser.ScreenPixelsHeight) / 2

        Dim script As String = "window.open('/Popup window/DetailsPopup.aspx?orderID=" & orderID & "', 'DetailsPopup', 'width=" & width.ToString() & ",height=" & height.ToString() & ",left=" & left.ToString() & ",top=" & top.ToString() & "');"
        ClientScript.RegisterStartupScript(Me.GetType(), "PopupScript", script, True)
    End Sub
End Class