Imports System.Data.SqlClient
Imports System.Configuration
Imports System.Web.UI.WebControls
Imports AjaxControlToolkit
Imports iTextSharp.text
Imports iTextSharp.text.pdf
Imports iTextSharp.text.pdf.draw
Imports System.IO
Public Class GeneriranjeKomisionirnogListaIspis
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ' Retrieve orderID from query string
            Dim orderID As Integer = Integer.Parse(Request.QueryString("orderID"))

            ' Retrieve data and generate report
            GenerateReport(orderID)
        End If
    End Sub

    Private Sub GenerateReport(orderID As Integer)
        ' Declare DataTable to store basic information about the order
        Dim orderInfo As New DataTable()
        ' Declare DataTable to store information about items in the order
        Dim itemsInOrder As New DataTable()

        ' Retrieve data using stored procedures
        Using conn As New SqlConnection(ConfigurationManager.ConnectionStrings("MyConnectionString").ConnectionString)
            conn.Open()

            ' Retrieve basic information about the order
            Using cmd As New SqlCommand("GeneriranjeKomisionirnogListaIspisOrderBasics", conn)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@orderID", orderID)
                Using reader As SqlDataReader = cmd.ExecuteReader()
                    orderInfo.Load(reader) ' Load the result into orderInfo DataTable
                End Using
            End Using

            ' Retrieve information about items in the order
            Using cmd As New SqlCommand("GeneriranjeKomisionirnogListaIspisOrderItems", conn)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@orderID", orderID)
                Using reader As SqlDataReader = cmd.ExecuteReader()
                    itemsInOrder.Load(reader) ' Load the result into itemsInOrder DataTable
                End Using
            End Using

            conn.Close()
        End Using

        ' Generate report using iTextSharp
        Dim doc As New Document()
        Dim filePath As String = Server.MapPath("~/Komisionirni list.pdf")
        Dim writer As PdfWriter = PdfWriter.GetInstance(doc, New FileStream(filePath, FileMode.Create))
        doc.Open()

        ' Set up document styles
        Dim titleFont As Font = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 24, BaseColor.BLACK)
        Dim headerFont As Font = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 12, BaseColor.WHITE)
        Dim cellFont As Font = FontFactory.GetFont(FontFactory.HELVETICA, 10, BaseColor.BLACK)
        Dim MaininfoFont As Font = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 12, BaseColor.BLACK)
        Dim infoFont As Font = FontFactory.GetFont(FontFactory.HELVETICA, 12, BaseColor.BLACK)
        Dim totalFont As Font = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 12, BaseColor.BLACK)
        Dim totalSmallFont As Font = FontFactory.GetFont(FontFactory.HELVETICA, 12, BaseColor.BLACK)

        ' Add title and header
        Dim title As New Paragraph("Komisionirni list narudžbe br.: ", titleFont)
        title.Add(New Chunk(orderInfo.Rows(0)("ID narudžbe").ToString(), titleFont))
        title.Alignment = Element.ALIGN_CENTER
        doc.Add(title)

        doc.Add(Chunk.NEWLINE)

        Dim employeeParagraph As New Paragraph()
        employeeParagraph.Add(New Chunk("ID zaposlenika: ", MaininfoFont))
        employeeParagraph.Add(New Chunk(orderInfo.Rows(0)("ID zaposlenik").ToString(), infoFont))
        employeeParagraph.SpacingAfter = 5
        doc.Add(employeeParagraph)

        Dim employeeNameParagraph As New Paragraph()
        employeeNameParagraph.Add(New Chunk("Zaposlenik: ", MaininfoFont))
        employeeNameParagraph.Add(New Chunk(orderInfo.Rows(0)("Zaposlenik").ToString(), infoFont))
        employeeNameParagraph.SpacingAfter = 5
        doc.Add(employeeNameParagraph)

        doc.Add(Chunk.NEWLINE)

        Dim customerParagraph As New Paragraph()
        customerParagraph.Add(New Chunk("Kupac: ", MaininfoFont))
        customerParagraph.Add(New Chunk(orderInfo.Rows(0)("Kupac").ToString(), infoFont))
        customerParagraph.SpacingAfter = 5
        doc.Add(customerParagraph)

        Dim customerPhoneNumberParagraph As New Paragraph()
        customerPhoneNumberParagraph.Add(New Chunk("Broj telefona: ", MaininfoFont))
        customerPhoneNumberParagraph.Add(New Chunk(orderInfo.Rows(0)("Broj telefona").ToString(), infoFont))
        customerPhoneNumberParagraph.SpacingAfter = 5
        doc.Add(customerPhoneNumberParagraph)

        Dim customerEmailParagraph As New Paragraph()
        customerEmailParagraph.Add(New Chunk("E-mail: ", MaininfoFont))
        customerEmailParagraph.Add(New Chunk(orderInfo.Rows(0)("Email").ToString(), infoFont))
        customerEmailParagraph.SpacingAfter = 5
        doc.Add(customerEmailParagraph)

        Dim customerFirstNameParagraph As New Paragraph()
        customerFirstNameParagraph.Add(New Chunk("Ime: ", MaininfoFont))
        customerFirstNameParagraph.Add(New Chunk(orderInfo.Rows(0)("Ime").ToString(), infoFont))
        customerFirstNameParagraph.SpacingAfter = 5
        doc.Add(customerFirstNameParagraph)

        Dim customerLastNameParagraph As New Paragraph()
        customerLastNameParagraph.Add(New Chunk("Prezime: ", MaininfoFont))
        customerLastNameParagraph.Add(New Chunk(orderInfo.Rows(0)("Prezime").ToString(), infoFont))
        customerLastNameParagraph.SpacingAfter = 5
        doc.Add(customerLastNameParagraph)

        doc.Add(Chunk.NEWLINE)

        Dim receiveDateParagraph As New Paragraph()
        receiveDateParagraph.Add(New Chunk("Datum primitka: ", MaininfoFont))
        receiveDateParagraph.Add(New Chunk(orderInfo.Rows(0).Field(Of DateTime)("Datum primitka").ToString("d.M.yyyy."), infoFont))
        receiveDateParagraph.SpacingAfter = 5
        doc.Add(receiveDateParagraph)

        ' Create data table
        Dim dataTable As New PdfPTable(7)
        dataTable.WidthPercentage = 100

        ' Add table headers
        Dim headers() As String = {"ID artikl", "Naziv", "Opis", "Kolicina", "Jmj", "Skladišna lokacija", "Potvrdni okvir"}
        For Each Naslov In headers
            Dim CelijaNaslova As New PdfPCell(New Phrase(Naslov, headerFont))
            CelijaNaslova.BackgroundColor = New BaseColor(79, 129, 189)
            CelijaNaslova.MinimumHeight = 50
            dataTable.AddCell(CelijaNaslova)
        Next

        ' Add data rows
        For Each row As DataRow In itemsInOrder.Rows
            Dim rowData() As String = {
                row.Field(Of Integer)("ID artikl").ToString(),
                row.Field(Of String)("Naziv"),
                row.Field(Of String)("Opis"),
                row.Field(Of Integer)("Količina").ToString(),
                row.Field(Of String)("Jmj"),
                row.Field(Of String)("Skladišna lokacija")
            }

            For Each podatak In rowData
                Dim dataCell As New PdfPCell(New Phrase(podatak, cellFont))
                dataCell.MinimumHeight = 40
                dataTable.AddCell(dataCell)
            Next

            ' Create checkbox field using RadioCheckField class
            Dim checkbox As New RadioCheckField(writer, New Rectangle(0, 0, 20, 20), "checkbox" & row.Field(Of Integer)("ID artikl").ToString(), "Yes")
            checkbox.CheckType = RadioCheckField.TYPE_CHECK
            Dim checkboxField As PdfFormField = checkbox.CheckField

            ' Create cell and add checkbox field
            Dim cell As New PdfPCell()
            cell.CellEvent = New CheckboxCellEvent(checkboxField)
            dataTable.AddCell(cell)
        Next

        ' Add data table to the report
        doc.Add(dataTable)

        doc.Close()

        ' Send file to user's browser
        Response.Clear()
        Response.ContentType = "application/pdf"
        Response.AppendHeader("Content-Disposition", "attachment; filename=Komisionirni list.pdf")
        Response.TransmitFile(filePath)
        Response.End()
    End Sub

    ' Checkbox cell event class
    Public Class CheckboxCellEvent
        Implements IPdfPCellEvent

        Private _checkbox As PdfFormField

        Public Sub New(checkbox As PdfFormField)
            _checkbox = checkbox
        End Sub

        Public Sub CellLayout(cell As PdfPCell, position As Rectangle, canvases() As PdfContentByte) Implements IPdfPCellEvent.CellLayout
            Dim writer As PdfWriter = canvases(PdfPTable.TEXTCANVAS).PdfWriter
            _checkbox.SetWidget(position, PdfAnnotation.HIGHLIGHT_INVERT)
            _checkbox.SetFieldFlags(PdfAnnotation.FLAGS_PRINT)
            writer.AddAnnotation(_checkbox)
        End Sub
    End Class
End Class