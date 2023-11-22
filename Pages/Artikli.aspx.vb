Imports System.Data.SqlClient

Public Class Artikli
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
            BindFormViewData()
        End If
    End Sub

    Private Sub BindFormViewData()
        Dim constr As String = ConfigurationManager.ConnectionStrings("MyConnectionString").ConnectionString
        Using conn As New SqlConnection(constr)
            Dim cmd As New SqlCommand("CRUDFormArtikli", conn) With {
                .CommandType = CommandType.StoredProcedure
            }
            cmd.Parameters.AddWithValue("@Operation", "R")
            Dim da As New SqlDataAdapter(cmd)
            Dim dt As New DataTable()
            da.Fill(dt)
            FormView1.DataSource = dt
            FormView1.DataBind()
        End Using
    End Sub

    Protected Sub btnSearch_Click(sender As Object, e As EventArgs)
        Dim searchValue As String = SearchTextBox.Text.Trim()
        SearchArtikliForButton(searchValue)
    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function SearchArtikli(ByVal prefixText As String) As String()
        Dim suggestions As New List(Of String)
        Dim constr As String = ConfigurationManager.ConnectionStrings("MyConnectionString").ConnectionString
        Using conn As New SqlConnection(constr)
            Dim cmd As New SqlCommand("SELECT Naziv FROM Artikl WHERE Naziv LIKE '%' + @prefixText + '%'", conn)
            cmd.Parameters.AddWithValue("@prefixText", prefixText)
            conn.Open()
            Using sdr As SqlDataReader = cmd.ExecuteReader()
                While sdr.Read()
                    suggestions.Add(sdr("Naziv").ToString())
                End While
            End Using
            conn.Close()
        End Using
        Return suggestions.ToArray()
    End Function

    Protected Sub SearchArtikliForButton(ByVal searchValue As String)
        Dim constr As String = ConfigurationManager.ConnectionStrings("MyConnectionString").ConnectionString
        Using conn As New SqlConnection(constr)
            Dim cmd As New SqlCommand("SearchArtikli", conn)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@searchValue", searchValue)
            Dim da As New SqlDataAdapter(cmd)
            Dim dt As New DataTable()
            da.Fill(dt)
            FormView1.DataSource = dt
            FormView1.DataBind()
        End Using
    End Sub

    Protected Sub FormView1_PageIndexChanging(sender As Object, e As FormViewPageEventArgs) Handles FormView1.PageIndexChanging
        FormView1.PageIndex = e.NewPageIndex
        BindFormViewData()
    End Sub

    Protected Sub FormView1_DataBound(sender As Object, e As EventArgs)
        Dim pages As New List(Of Integer)()
        For i As Integer = 0 To FormView1.PageCount - 1
            pages.Add(i + 1)
        Next
        repFooter.DataSource = pages
        repFooter.DataBind()
    End Sub

    Protected Sub repFooter_ItemCommand(source As Object, e As RepeaterCommandEventArgs)
        If e.CommandName = "ChangePage" Then
            FormView1.PageIndex = Convert.ToInt32(e.CommandArgument) - 1
            BindFormViewData()
        End If
    End Sub

    Protected Sub PrevButton_Click(sender As Object, e As EventArgs) Handles PrevButton.Click
        ' Move to the previous page
        If FormView1.PageIndex > 0 Then
            FormView1.PageIndex -= 1
            BindFormViewData()
            FormView1.DataBind()
        End If
    End Sub

    Protected Sub NextButton_Click(sender As Object, e As EventArgs) Handles NextButton.Click
        ' Move to the next page
        If FormView1.PageIndex < FormView1.PageCount - 1 Then
            FormView1.PageIndex += 1
            BindFormViewData()
            FormView1.DataBind()
        End If
    End Sub

    Protected Sub FormView1_ModeChanging(sender As Object, e As FormViewModeEventArgs)
        FormView1.ChangeMode(e.NewMode)
        BindFormViewData()
    End Sub

    Protected Sub InsertButton_Click(sender As Object, e As EventArgs)
        FormView1.ChangeMode(FormViewMode.Insert)
    End Sub

    Protected Sub FormView1_ItemUpdating(sender As Object, e As FormViewUpdateEventArgs)
        Dim IDArtikl As Integer = Integer.Parse(DirectCast(FormView1.FindControl("IDArtiklHiddenField"), HiddenField).Value)
        Dim Naziv As String = DirectCast(FormView1.FindControl("NazivTextBox"), TextBox).Text
        Dim Cijena As Decimal = Decimal.Parse(DirectCast(FormView1.FindControl("CijenaTextBox"), TextBox).Text)
        Dim Jmj As String = DirectCast(FormView1.FindControl("JmjTextBox"), TextBox).Text
        Dim Opis As String = DirectCast(FormView1.FindControl("OpisTextBox"), TextBox).Text
        Dim SkladisteDropDownList As DropDownList = CType(FormView1.FindControl("SkladisteDropDownList"), DropDownList)
        Dim SkladisteLokacija As String = SkladisteDropDownList.SelectedValue

        Dim constr As String = ConfigurationManager.ConnectionStrings("MyConnectionString").ConnectionString
        Using conn As New SqlConnection(constr)
            Dim cmd As New SqlCommand("CRUDFormArtikli", conn) With {
                .CommandType = CommandType.StoredProcedure
            }
            cmd.Parameters.AddWithValue("@Operation", "U")
            cmd.Parameters.AddWithValue("@IDArtikl", IDArtikl)
            cmd.Parameters.AddWithValue("@Naziv", Naziv)
            cmd.Parameters.AddWithValue("@Cijena", Cijena)
            cmd.Parameters.AddWithValue("@Jmj", Jmj)
            cmd.Parameters.AddWithValue("@Opis", Opis)
            cmd.Parameters.AddWithValue("@SkladisteLokacija", SkladisteLokacija)
            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()
        End Using

        FormView1.ChangeMode(FormViewMode.ReadOnly)
        BindFormViewData()
    End Sub

    Protected Sub FormView1_ItemDeleting(sender As Object, e As FormViewDeleteEventArgs)
        Dim IDArtikl As Integer = Integer.Parse(DirectCast(FormView1.FindControl("IDArtiklHiddenField"), HiddenField).Value)
        Dim constr As String = ConfigurationManager.ConnectionStrings("MyConnectionString").ConnectionString
        Using conn As New SqlConnection(constr)
            Dim cmd As New SqlCommand("CRUDFormArtikli", conn) With {
                .CommandType = CommandType.StoredProcedure
            }
            cmd.Parameters.AddWithValue("@Operation", "D")
            cmd.Parameters.AddWithValue("@IDArtikl", IDArtikl)
            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()
        End Using
        BindFormViewData()
    End Sub

    Protected Sub FormView1_ItemInserting(sender As Object, e As FormViewInsertEventArgs)
        Dim Naziv As String = DirectCast(FormView1.FindControl("NazivTextBox"), TextBox).Text
        Dim Cijena As Decimal = Decimal.Parse(DirectCast(FormView1.FindControl("CijenaTextBox"), TextBox).Text)
        Dim Jmj As String = DirectCast(FormView1.FindControl("JmjTextBox"), TextBox).Text
        Dim Opis As String = DirectCast(FormView1.FindControl("OpisTextBox"), TextBox).Text
        Dim SkladisteDropDownList As DropDownList = CType(FormView1.FindControl("SkladisteDropDownList"), DropDownList)
        Dim SkladisteLokacija As String = SkladisteDropDownList.SelectedValue

        Dim constr As String = ConfigurationManager.ConnectionStrings("MyConnectionString").ConnectionString
        Using conn As New SqlConnection(constr)
            Dim cmd As New SqlCommand("CRUDFormArtikli", conn) With {
                .CommandType = CommandType.StoredProcedure
            }
            cmd.Parameters.AddWithValue("@Operation", "C")
            cmd.Parameters.AddWithValue("@Naziv", Naziv)
            cmd.Parameters.AddWithValue("@Cijena", Cijena)
            cmd.Parameters.AddWithValue("@Jmj", Jmj)
            cmd.Parameters.AddWithValue("@Opis", Opis)
            cmd.Parameters.AddWithValue("@SkladisteLokacija", SkladisteLokacija)
            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()
        End Using

        FormView1.ChangeMode(FormViewMode.ReadOnly)
        BindFormViewData()
    End Sub
End Class
