<% '
   '  Customer Entry and Maintenance
   '

   'Initialize Standard Information
   Index     = request("Index")           ' The last selected Index number
   RowId     = request("RowId")           ' If a record Id was passed
   RunReport = (request("RunReport")<>"") ' If run report was selected
%>

<% ' redirects must occur before any html output!
    If RunReport then
        Response.redirect ("CustomerList.asp?RunReport=1&Index=" & Index)
    end if
%>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html;charset=iso-8859-1">
<meta name="GENERATOR" content="Microsoft FrontPage 3.0">
<title>Customer2</title>

<% ' LoginRights:   If 1 user has full rights, if 0 or -1, browse only rights %>
<% LoginRights = request.cookies("Rights") %>

<!-- The name of the style sheet is in Global.asa and stored in the session object -->
<LINK REL=STYLESHEET HREF="<%=Session("Style")%>" TYPE="text/css">
</head>

<body>

<% CheckFieldChange=oCustomer.call("get_peFieldMultiUser") %>
<!-- #INCLUDE FILE="inc/SetChangedStates-script.inc" -->

<!-- #INCLUDE FILE="inc/ddValue_Constants.inc" -->

<% ' DebugMode =1 ' uncomment this for page get/post debug help %>
<!-- #INCLUDE FILE="inc/DebugHelp.inc" -->

<% If LoginRights = "1" then %>
<h3>Customer Entry and Maintenance</h3>
<% else %>
<h3>Customer Query</h3>
<% end if %>

<%
  oCustomer.call "set_pbReportErrors", 1 'normally show any errors that occur
  'We either find a record, or clear the WBO
  If RowId <> "" Then
      Err = oCustomer.RequestFindbyRowId( "Customer", RowId)
  else
      Err = oCustomer.RequestClear("Customer",1)
  End if

  ' process various buttons that might have been pressed.
  ' only support Post submissions
  If request("Request_method")="POST" Then

      if Request("clear")<>"" then
          Err = oCustomer.RequestClear("Customer",1)
      end if

      if Request("save")<>"" then
          oCustomer.call "set_pbReportErrors", 0
          err = oCustomer.RequestSave("Customer")
          if err = 0 then
              Response.Write("<center> <h4>Customer record saved</h4> </center>")
          else
              Response.Write("<font color=""red"">")
              Response.Write("<center> <h4>Could not save changes. Errors Occurred</h4> </center>")
              oCustomer.call "msg_ReportAllErrors"
              Response.Write("</font>")
          end if
      end if

      if Request("delete")<>"" then
          oCustomer.call "set_pbReportErrors", 0
          Err = oCustomer.RequestDelete("Customer")
          if err = 0 then
             Response.Write("<center> <h4>The record has been deleted.</h4> </center>")
          else
             Response.Write("<font color=""red"">")
             Response.Write("<center> <h4>The record could not be deleted.</h4> </center>")
             oCustomer.call "msg_ReportAllErrors"
             Response.Write("</font>")
          end if
      end if

      ' note we use the Index variable we created above
      if Request("findprev") <>"" then  Err = oCustomer.RequestFind("Customer", Index, LT)
      if Request("find")     <>"" then  Err = oCustomer.RequestFind("Customer", Index, GE)
      if Request("findnext") <>"" then  Err = oCustomer.RequestFind("Customer", Index, GT)
      if Request("findfirst")<>"" then  Err = oCustomer.RequestFind("Customer", Index, FIRST_RECORD)
      if Request("findlast") <>"" then  Err = oCustomer.RequestFind("Customer", Index, LAST_RECORD)

 end if

Sub ShowDataLine (Obj, FileField )
    FErr = Obj.DDValue(FileField,DDFIELDERROR)
    Response.write("<tr>")
    Response.write( "<td class=""Label"">")
    If FErr<>"" then Response.Write("<font color=""red"">")
    Response.write( Obj.ddValue(FileField, DDLONGLABEL))
    If FErr<>"" then Response.Write("</font>")
    Response.Write("</td>")

    Response.write( "<td class=""Data"">" & Obj.DDValue(FileField,DDAUTO) & "</td>")

    If FErr <> "" then
       Response.write("<td class=""Error"">" & FErr & "</td>")
    end if
    Response.write("</tr>")
End Sub

Sub BuildData ()
    Response.Write("<table class=""EntryTable"">")
        ShowDataLine oCustomer, "customer.Customer_Number"
        ShowDataLine oCustomer, "customer.Name"
        ShowDataLine oCustomer, "customer.status"
        ShowDataLine oCustomer, "customer.address"
        ShowDataLine oCustomer, "customer.city"
        ShowDataLine oCustomer, "customer.state"
        ShowDataLine oCustomer, "customer.zip"
        ShowDataLine oCustomer, "customer.phone_number"
        ShowDataLine oCustomer, "customer.fax_number"
        ShowDataLine oCustomer, "customer.email_address"
        ShowDataLine oCustomer, "customer.credit_limit"
        ShowDataLine oCustomer, "customer.purchases"
        ShowDataLine oCustomer, "customer.balance"
        ShowDataLine oCustomer, "customer.comments"
    Response.Write("</table>")
End sub


%>

</font>

<form ACTION="Customer2.asp" METHOD="POST" NAME="Customer_WBO" OnSubmit="SetChangedStates(this)">
  <input type="hidden" name="Customer__RowId" value="<%=oCustomer.DDValue("Customer.RowId")%>">
  <input type="hidden" name="ChangedStates" value="">

<p class="Toolbar">
Find
<input Class="ActionButton" type="submit" name="findfirst" value="&lt;&lt;">
<input Class="ActionButton" type="submit" name="findprev" value="&lt;">
<input Class="ActionButton" type="submit" name="find" value="=">
<input Class="ActionButton" type="submit" name="findnext" value="&gt;">
<input Class="ActionButton" type="submit" name="findlast" value="&gt;&gt;">
<input Class="ActionButton" type="submit" name="RunReport" value="List">
 by
<% oCustomer.call "get_CreateFindIndexCombo", "Index", "Customer", Index %>
<% If LoginRights = "1" then %>
&nbsp;&nbsp;
<input Class="ActionButton" type="submit" name="save" value="Save">
<input Class="ActionButton" type="submit" name="delete" value="Delete">
<input Class="ActionButton" type="submit" name="clear" value="Clear">
<% end if %>
</p>

  <blockquote class="EntryBlock">
    <% BuildData %>
  </blockquote>
</form>

</body>
</html>
