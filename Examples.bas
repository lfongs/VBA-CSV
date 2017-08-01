Attribute VB_Name = "Examples"
'
' Examples for VBA-CSV
'
Option Explicit

'
' Example for ParseCSVToCollection()
'
Sub Example1()
    Dim csv As Collection
    Dim rec As Collection, fld As Variant

    Set csv = ParseCSVToCollection("aaa,bbb,ccc" & vbCr & "xxx,yyy,zzz")
    If csv Is Nothing Then
        Debug.Print Err.Number & " (" & Err.Source & ") " & Err.Description
    End If
    
    Debug.Print csv(1)(3) '----> ccc
    Debug.Print csv(2)(1) '----> xxx
    For Each rec In csv
      For Each fld In rec
        Debug.Print fld
      Next
    Next
End Sub

'
' Example for ParseCSVToArray()
'
Sub Example2()
    Dim csv As Variant
    Dim i As Long, j As Variant

    csv = ParseCSVToArray("aaa,bbb,ccc" & vbCr & "xxx,yyy,zzz")
    If IsNull(csv) Then
        Debug.Print Err.Number & " (" & Err.Source & ") " & Err.Description
    End If
    
    Debug.Print csv(1, 3) '----> ccc
    Debug.Print csv(2, 1) '----> xxx
    For i = LBound(csv, 1) To UBound(csv, 1)
      For j = LBound(csv, 2) To UBound(csv, 2)
        Debug.Print csv(i, j)
      Next
    Next
End Sub

'
' Example for usage of readCSVFile() and debugPrintResults()
'
Sub Example3()
    Dim text As String
    Dim csv As Variant

    text = readCSVFile("C:\Users\sdkn1\Desktop\Book1.csv")
    'text = "aaa,bbb,ccc" & vbCr & "xxx,yyy,zzz"
    Set csv = ParseCSVToCollection(text)
    debugPrintResults csv
    csv = ParseCSVToArray(text)
    debugPrintResults csv
End Sub


'
' read text file and return String
'
Function readCSVFile(fileName As String) As String
    Dim FSO As Object
    Set FSO = CreateObject("Scripting.FileSystemObject")
    With FSO.GetFile(fileName).OpenAsTextStream
        readCSVFile = .ReadAll
        .Close
    End With
End Function



'
' Debug.Print the returned variable from the parser
'
Sub debugPrintResults(csv As Variant)
    
    Debug.Print "TypeName: " & TypeName(csv)
    If TypeName(csv) = "Collection" Then
        Dim r As Collection, f As Variant
        For Each r In csv
          Debug.Print "----------"
          For Each f In r
            Debug.Print "[" & f & "]"
          Next
        Next
        Debug.Print "--------"
    
    ElseIf TypeName(csv) = "String()" Then
        Dim i As Long, j As Long
        For i = LBound(csv, 1) To UBound(csv, 1)
          Debug.Print "----------"
          For j = LBound(csv, 2) To UBound(csv, 2)
            Debug.Print "[" & csv(i, j) & "]"
          Next
        Next
        Debug.Print "----------"
    
    Else
       Debug.Print "Not collection nor array"
    End If
End Sub

