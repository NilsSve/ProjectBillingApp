<% '
   '  Vendor Entry and Maintenance
   '

   'Initialize Standard Information
   Index     = request("Index")           ' The last selected Index number
   RowId      = request("RowId")           ' If a row Id was passed
   RunReport = (request("RunReport")<>"") ' If run report was selected
   RunInvtReport = (request("ListParts")<>"") ' If run report was selected
%>

<% ' redirects must occur before any html output!
    If RunReport then
        Response.redirect ("VendorList.asp?RunReport=1&Index=" & Index)
    end if
    If RunInvtReport then
        VendorRowId = Request("Vendor__Rowid")
        Response.redirect ("InvtList.asp?RunReport=2&VendorRowID=" & VendorRowId)
    end if
%>


<html>

<head>
<meta http-equiv="Content-Type" content="text/html;charset=iso-8859-1">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<title>Vendor</title>

<% ' LoginRights:   If 1 user has full rights, if 0 or -1, browse only rights %>
<% LoginRights = request.cookies("Rights") %>

<!-- The name of the style sheet is in Global.asa and stored in the session object -->
<LINK REL=STYLESHEET HREF="<%=Session("Style")%>" TYPE="text/css">
</head>

<body>

<% CheckFieldChange=oVendor.call("get_peFieldMultiUser") %>
<!-- #INCLUDE FILE="inc/SetChangedStates-script.inc" -->

<!-- #INCLUDE FILE="inc/ddValue_Constants.inc" -->

<% ' DebugMode =1 ' uncomment this for page get/post debug help %>
<!-- #INCLUDE FILE="inc/DebugHelp.inc" -->

<% If LoginRights = "1" then %>
<h3>Vendor Entry and Maintenance</h3>
<% else %>
<h3>Vendor Query</h3>
<% end if %>

<%
  oVendor.call "set_pbReportErrors", 1 'normally show any errors that occur
  'We either find a record, or clear the WBO
  If RowId <> "" Then
      Err = oVendor.RequestFindbyRowId( "Vendor", RowId)
  else
      Err = oVendor.RequestClear("Vendor",1)
  End if

  ' process various buttons that might have been pressed.
  ' only support Post submissions
  If request("Request_method")="POST" Then

      if Request("clear")<>"" then
          Err = oVendor.RequestClear("Vendor",1)
      end if

      if Request("save")<>"" then
          oVendor.call "set_pbReportErrors", 0
          err = oVendor.RequestSave("Vendor")
          if err = 0 then
              Response.Write("<center> <h4>Vendor record saved</h4> </center>")
          else
              Response.Write("<font color=""red"">")
              Response.Write("<center> <h4>Could not save changes. Errors Occurred</h4> </center>")
              oVendor.call "msg_ReportAllErrors"
              Response.Write("</font>")
          end if
      end if

      if Request("delete")<>"" then
          oVendor.call "set_pbReportErrors", 0
          Err = oVendor.RequestDelete("Vendor")
          if err = 0 then
             Response.Write("<center> <h4>The record has been deleted.</h4> </center>")
          else
             Response.Write("<font color=""red"">")
             Response.Write("<center> <h4>The record could not be deleted.</h4> </center>")
             oVendor.call "msg_ReportAllErrors"
             Response.Write("</font>")
          end if
      end if

      ' note we use the Index variable we created above
      if Request("findprev") <>"" then  Err = oVendor.RequestFind("Vendor", Index, LT)
      if Request("find")     <>"" then  Err = oVendor.RequestFind("Vendor", Index, GE)
      if Request("findnext") <>"" then  Err = oVendor.RequestFind("Vendor", Index, GT)
      if Request("findfirst")<>"" then  Err = oVendor.RequestFind("Vendor", Index, FIRST_RECORD)
      if Request("findlast") <>"" then  Err = oVendor.RequestFind("Vendor", Index, LAST_RECORD)

 end if

%>
<Form action="Vendor.asp" method="POST" name="Vendor" onsubmit="SetChangedStates(this)">

<% ' You MUST have a hidden rowid field for each DDO in your WBO %>
<input type="hidden" size="15" name="Vendor__Rowid" Value="<%=oVendor.DDValue("Vendor.Rowid")%>" >
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
<% oVendor.call "get_CreateFindIndexCombo", "Index", "Vendor", Index %>
<% if oVendor.ddvalue("Vendor.RowId") <> "" then %>
    <input Class="ActionButton" type="submit" name="listparts" value="List Vendor Parts">
<% end if%>
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
      <%FieldError=oVendor.DDValue("Vendor.Id",DDFIELDERROR) %>
      <td Class="Label"><%=oVendor.DDValue("Vendor.Id",DDLONGLABEL,1)%></td>
      <td Class="Data">
      <%=oVendor.DDValue("Vendor.Id",DDFORM)%>
      </td>
      <% If FieldError<>"" then %>
      <td Class="Error"><%=FieldError%></td>
      <% end if %>
  </tr>
  <tr>
      <%FieldError=oVendor.DDValue("Vendor.Name",DDFIELDERROR) %>
      <td Class="Label"><%=oVendor.DDValue("Vendor.Name",DDLONGLABEL,1)%></td>
      <td Class="Data">
      <%=oVendor.DDValue("Vendor.Name",DDFORM)%>
      </td>
      <% If FieldError<>"" then %>
      <td Class="Error"><%=FieldError%></td>
      <% end if %>
  </tr>
  <tr>
      <%FieldError=oVendor.DDValue("Vendor.Address",DDFIELDERROR) %>
      <td Class="Label"><%=oVendor.DDValue("Vendor.Address",DDLONGLABEL,1)%></td>
      <td Class="Data">
      <%=oVendor.DDValue("Vendor.Address",DDFORM)%>
      </td>
      <% If FieldError<>"" then %>
      <td Class="Error"><%=FieldError%></td>
      <% end if %>
  </tr>
  <tr>
      <%FieldError=oVendor.DDValue("Vendor.City",DDFIELDERROR) %>
      <td Class="Label"><%=oVendor.DDValue("Vendor.City",DDLONGLABEL,1)%></td>
      <td Class="Data">
      <%=oVendor.DDValue("Vendor.City",DDFORM)%>
      </td>
      <% If FieldError<>"" then %>
      <td Class="Error"><%=FieldError%></td>
      <% end if %>
  </tr>
  <tr>
      <%FieldError=oVendor.DDValue("Vendor.State",DDFIELDERROR) %>
      <td Class="Label"><%=oVendor.DDValue("Vendor.State",DDLONGLABEL,1)%></td>
      <td Class="Data">
     <%=oVendor.DDValue("Vendor.State",DDCOMBO)%>      </td>
      <% If FieldError<>"" then %>
      <td Class="Error"><%=FieldError%></td>
      <% end if %>
  </tr>
  <tr>
      <%FieldError=oVendor.DDValue("Vendor.Zip",DDFIELDERROR) %>
      <td Class="Label"><%=oVendor.DDValue("Vendor.Zip",DDLONGLABEL,1)%></td>
      <td Class="Data">
      <%=oVendor.DDValue("Vendor.Zip",DDFORM)%>
      </td>
      <% If FieldError<>"" then %>
      <td Class="Error"><%=FieldError%></td>
      <% end if %>
  </tr>
  <tr>
      <%FieldError=oVendor.DDValue("Vendor.Phone_Number",DDFIELDERROR) %>
      <td Class="Label"><%=oVendor.DDValue("Vendor.Phone_Number",DDLONGLABEL,1)%></td>
      <td Class="Data">
      <%=oVendor.DDValue("Vendor.Phone_Number",DDFORM)%>
      </td>
      <% If FieldError<>"" then %>
      <td Class="Error"><%=FieldError%></td>
      <% end if %>
  </tr>
  <tr>
      <%FieldError=oVendor.DDValue("Vendor.Fax_Number",DDFIELDERROR) %>
      <td Class="Label"><%=oVendor.DDValue("Vendor.Fax_Number",DDLONGLABEL,1)%></td>
      <td Class="Data">
      <%=oVendor.DDValue("Vendor.Fax_Number",DDFORM)%>
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