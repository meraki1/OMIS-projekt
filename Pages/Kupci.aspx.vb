Imports System.Data.SqlClient

Public Class Kupci
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
            BindFormViewData()
        End If
    End Sub

    Private Sub BindFormViewData()
        Dim constr As String = ConfigurationManager.ConnectionStrings("MyConnectionString").ConnectionString
        Using conn As New SqlConnection(constr)
            Dim cmd As New SqlCommand("SELECT * FROM Kupac", conn)
            Dim da As New SqlDataAdapter(cmd)
            Dim dt As New DataTable()
            da.Fill(dt)
            FormView1.DataSource = dt
            FormView1.DataBind()
        End Using
    End Sub

    Protected Sub btnSearch_Click(sender As Object, e As EventArgs)
        Dim searchValue As String = SearchTextBox.Text.Trim()
        SearchKupciForButton(searchValue)
    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function SearchKupci(ByVal prefixText As String) As String()
        Dim suggestions As New List(Of String)
        Dim constr As String = ConfigurationManager.ConnectionStrings("MyConnectionString").ConnectionString
        Using conn As New SqlConnection(constr)
            Dim cmd As New SqlCommand("SELECT Naziv FROM Kupac WHERE Naziv LIKE '%' + @prefixText + '%'", conn)
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

    Protected Sub SearchKupciForButton(ByVal searchValue As String)
        Dim constr As String = ConfigurationManager.ConnectionStrings("MyConnectionString").ConnectionString
        Using conn As New SqlConnection(constr)
            Dim cmd As New SqlCommand("SELECT * FROM Kupac WHERE Naziv LIKE '%' + @searchValue + '%'", conn)
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

    Protected Sub FormView1_ItemDeleting(sender As Object, e As FormViewDeleteEventArgs)
        Dim OIB As String = DirectCast(FormView1.FindControl("OIBTextBox"), TextBox).Text
        Dim constr As String = ConfigurationManager.ConnectionStrings("MyConnectionString").ConnectionString
        Using conn As New SqlConnection(constr)
            Dim cmd As New SqlCommand("DELETE FROM Kupac WHERE OIB = @OIB", conn)
            cmd.Parameters.AddWithValue("@OIB", OIB)
            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()
        End Using
        BindFormViewData()
    End Sub

    Protected Sub FormView1_ItemUpdating(sender As Object, e As FormViewUpdateEventArgs)
        Dim IDKupac As Integer = Integer.Parse(DirectCast(FormView1.FindControl("IDKupacHiddenField"), HiddenField).Value)
        Dim Ime As String = DirectCast(FormView1.FindControl("ImeTextBox"), TextBox).Text
        Dim Prezime As String = DirectCast(FormView1.FindControl("PrezimeTextBox"), TextBox).Text
        Dim OIB As String = DirectCast(FormView1.FindControl("OIBTextBox"), TextBox).Text
        Dim Email As String = DirectCast(FormView1.FindControl("EmailTextBox"), TextBox).Text
        Dim Naziv As String = DirectCast(FormView1.FindControl("NazivTextBox"), TextBox).Text
        Dim BrojTelefona As String = DirectCast(FormView1.FindControl("BrojTelefonaTextBox"), TextBox).Text
        Dim Adresa As String = DirectCast(FormView1.FindControl("AdresaTextBox"), TextBox).Text

        Dim constr As String = ConfigurationManager.ConnectionStrings("MyConnectionString").ConnectionString
        Using conn As New SqlConnection(constr)
            Dim cmd As New SqlCommand("UpdateFormKupci", conn)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@IDKupac", IDKupac)
            cmd.Parameters.AddWithValue("@Ime", Ime)
            cmd.Parameters.AddWithValue("@Prezime", Prezime)
            cmd.Parameters.AddWithValue("@OIB", OIB)
            cmd.Parameters.AddWithValue("@Email", Email)
            cmd.Parameters.AddWithValue("@Naziv", Naziv)
            cmd.Parameters.AddWithValue("@BrojTelefona", BrojTelefona)
            cmd.Parameters.AddWithValue("@Adresa", Adresa)
            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()
        End Using

        FormView1.ChangeMode(FormViewMode.ReadOnly)
        BindFormViewData()
    End Sub
End Class