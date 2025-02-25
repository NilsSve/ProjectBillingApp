<% '
   '  Sales Person Entry and Maintenance
   '

   'Initialize Standard Information
   Index     = request("Index")           ' The last selected Index number
   RowId     = request("RowId")           ' If a row Id was passed
   RunReport = (request("RunReport")<>"") ' If run report was selected
%>

<% ' redirects must occur before any html output!
    If RunReport then
        Response.redirect ("SalesPList.asp?RunReport=1&Index=" & Index)
    end if
%>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html;charset=iso-8859-1">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<title>Sales Person Report</title>

<% ' LoginRights:   If 1 user has full rights, if 0 or -1, browse only rights %>
<% LoginRights = request.cookies("Rights") %>

<!-- The name of the style sheet is in Global.asa and stored in the session object -->
<LINK REL=STYLESHEET HREF="<%=Session("Style")%>" TYPE="text/css">
</head>

<body>

<% CheckFieldChange=oSalesP.call("get_peFieldMultiUser") %>
<!-- #INCLUDE FILE="inc/SetChangedStates-script.inc" -->

<!-- #INCLUDE FILE="inc/ddValue_Constants.inc" -->

<% ' DebugMode =1 ' uncomment this for page get/post debug help %>
<!-- #INCLUDE FILE="inc/DebugHelp.inc" -->

<% If LoginRights = "1" then %>
<h3>Sales Person Entry and Maintenance</h3>
<% else %>
<h3>Sales Person Query</h3>
<% end if %>

<%
  oSalesP.call "set_pbReportErrors", 1 'normally show any errors that occur
  'We either find a record, or clear the WBO
  If RowId <> "" Then
      Err = oSalesP.RequestFindbyRowId( "Salesp", RowId)
  else
      Err = oSalesP.RequestClear("Salesp",1)
  End if

  ' process various buttons that might have been pressed.
  ' only support Post submissions
  If request("Request_method")="POST" Then

      if Request("clear")<>"" then
          Err = oSalesP.RequestClear("Salesp",1)
      end if

      if Request("save")<>"" then
          oSalesP.call "set_pbReportErrors", 0
          err = oSalesP.RequestSave("Salesp")
          if err = 0 then
              Response.Write("<center> <h4>Salesp record saved</h4> </center>")
          else
              Response.Write("<font color=""red"">")
              Response.Write("<center> <h4>Could not save changes. Errors Occurred</h4> </center>")
              oSalesP.call "msg_ReportAllErrors"
              Response.Write("</font>")
          end if
      end if

      if Request("delete")<>"" then
          oSalesP.call "set_pbReportErrors", 0
          Err = oSalesP.RequestDelete("Salesp")
          if err = 0 then
             Response.Write("<center> <h4>The record has been deleted.</h4> </center>")
          else
             Response.Write("<font color=""red"">")
             Response.Write("<center> <h4>The record could not be deleted.</h4> </center>")
             oSalesP.call "msg_ReportAllErrors"
             Response.Write("</font>")
          end if
      end if

      ' note we use the Index variable we created above
      if Request("findprev") <>"" then  Err = oSalesP.RequestFind("Salesp", Index, LT)
      if Request("find")     <>"" then  Err = oSalesP.RequestFind("Salesp", Index, GE)
      if Request("findnext") <>"" then  Err = oSalesP.RequestFind("Salesp", Index, GT)
      if Request("findfirst")<>"" then  Err = oSalesP.RequestFind("Salesp", Index, FIRST_RECORD)
      if Request("findlast") <>"" then  Err = oSalesP.RequestFind("Salesp", Index, LAST_RECORD)

 end if

%>


<Form action="SalesP.asp" method="POST" name="Salesp" onsubmit="SetChangedStates(this)">

<% ' You MUST have a hidden rowid field for each DDO in your WBO %>
<input type="hidden" size="15" name="Salesp__RowId" Value="<%=oSalesP.DDValue("Salesp.RowId")%>" >
<% ' This is needed if you need field level change state checking %>
<Input type="hidden" name="ChangedStates" value="">

<p class="Toolbar">
Find
<input Class="ActionButton" type="submit" name="findfirst" value="&lt;&lt;">
<input Class="ActionButton" type="submit" name="findprev" value="&lt;">
<input Class="ActionButton" type="submit" name="find" value="=">
<input Class="ActionButton" type="submit" name="findnext" value="&gt;">
<input Class="ActionButton" type="submit" name="findlast" value="&gt;&gt;">
<input Class="ActionButton" type="submit" name="RunReport" value="List">
 by
<% oSalesP.call "get_CreateFindIndexCombo", "Index", "SalesP", Index %>
<% If LoginRights = "1" then %>
&nbsp;&nbsp;
<input Class="ActionButton" type="submit" name="save" value="Save">
<input Class="ActionButton" type="submit" name="delete" value="Delete">
<input Class="ActionButton" type="submit" name="clear" value="Clear">
<% end if %>
</p>

<blockquote class="EntryBlock">


<table border="0" Class="EntryTable">

  <tr>
      <%FieldError=oSalesP.DDValue("Salesp.Id",DDFIELDERROR) %>
      <td Class="Label"><%=oSalesP.DDValue("Salesp.Id",DDLONGLABEL,1)%></td>
      <td Class="Data">
      <%=oSalesP.DDValue("Salesp.Id",DDFORM)%>
      </td>
      <% If FieldError<>"" then %>
      <td Class="Error"><%=FieldError%></td>
      <% end if %>
  </tr>
  <tr>
      <%FieldError=oSalesP.DDValue("Salesp.Name",DDFIELDERROR) %>
      <td Class="Label"><%=oSalesP.DDValue("Salesp.Name",DDLONGLABEL,1)%></td>
      <td Class="Data">
      <%=oSalesP.DDValue("Salesp.Name",DDFORM)%>
      </td>
      <% If FieldError<>"" then %>
      <td Class="Error"><%=FieldError%></td>
      <% end if %>
  </tr>

</table>

</blockquote>

</form>

</body>
</html>