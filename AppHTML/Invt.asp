<% '
   '  Inventory Entry and Maintenance
   '

   'Initialize Standard Information
   Index     = request("Index")           ' The last selected Index number
   RowId     = request("RowId")           ' If a Row Id was passed
   RunReport = (request("RunReport")<>"") ' If run report was selected
   RunVendorReport = (request("RunVendorReport")<>"") ' If run report was selected
%>

<% ' redirects must occur before any html output!
    If RunReport then
        Response.redirect ("InvtList.asp?RunReport=1&Index=" & Index)
    end if
    If RunVendorReport then
        VendorRowid = Request("Vendor__RowId")
        Response.redirect ("InvtList.asp?RunReport=2&VendorRowID=" & VendorRowId)
    end if
%>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html;charset=iso-8859-1">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<title>Inventory</title>

<% ' LoginRights:   If 1 user has full rights, if 0 or -1, browse only rights %>
<% LoginRights = request.cookies("Rights") %>

<!-- The name of the style sheet is in Global.asa and stored in the session object -->
<LINK REL=STYLESHEET HREF="<%=Session("Style")%>" TYPE="text/css">
</head>

<body>


<% CheckFieldChange=oInvt.call("get_peFieldMultiUser") %>
<!-- #INCLUDE FILE="inc/SetChangedStates-script.inc" -->

<!-- #INCLUDE FILE="inc/ddValue_Constants.inc" -->

<% ' DebugMode =1 ' uncomment this for page get/post debug help %>
<!-- #INCLUDE FILE="inc/DebugHelp.inc" -->

<% If LoginRights = "1" then %>
<h3>Inventory Entry and Maintenance</h3>
<% else %>
<h3>Inventory Query</h3>
<% end if %>

<%
  oInvt.call "set_pbReportErrors", 1 'normally show any errors that occur
  'We either find a record, or clear the WBO
  If RowId <> "" Then
      Err = oInvt.RequestFindbyRowId( "Invt", RowId)
  else
      Err = oInvt.RequestClear("Invt",1)
  End if

  ' process various buttons that might have been pressed.
  ' only support Post submissions
  If request("Request_method")="POST" Then

      if Request("clear")<>"" then
          Err = oInvt.RequestClear("Invt",1)
      end if

      if Request("save")<>"" then
          oInvt.call "set_pbReportErrors", 0
          err = oInvt.RequestSave("Invt")
          if err = 0 then
              Response.Write("<center> <h4>Invt record saved</h4> </center>")
          else
              Response.Write("<font color=""red"">")
              Response.Write("<center> <h4>Could not save changes. Errors Occurred</h4> </center>")
              oInvt.call "msg_ReportAllErrors"
              Response.Write("</font>")
          end if
      end if

      if Request("delete")<>"" then
          oInvt.call "set_pbReportErrors", 0
          Err = oInvt.RequestDelete("Invt")
          if err = 0 then
             Response.Write("<center> <h4>The record has been deleted.</h4> </center>")
          else
             Response.Write("<font color=""red"">")
             Response.Write("<center> <h4>The record could not be deleted.</h4> </center>")
             oInvt.call "msg_ReportAllErrors"
             Response.Write("</font>")
          end if
      end if

      ' note we use the Index variable we created above
      if Request("findprev") <>"" then  Err = oInvt.RequestFind("Invt", Index, LT)
      if Request("find")     <>"" then  Err = oInvt.RequestFind("Invt", Index, GE)
      if Request("findnext") <>"" then  Err = oInvt.RequestFind("Invt", Index, GT)
      if Request("findfirst")<>"" then  Err = oInvt.RequestFind("Invt", Index, FIRST_RECORD)
      if Request("findlast") <>"" then  Err = oInvt.RequestFind("Invt", Index, LAST_RECORD)

 end if

OldInvt = oInvt.ddvalue("Invt.RowId")

%>


<Form action="Invt.asp" method="POST" name="Invt" onsubmit="SetChangedStates(this)">

<% ' You MUST have a hidden rowid field for each DDO in your WBO %>
<input type="hidden" size="15" name="Invt__RowId" Value="<%=oInvt.DDValue("Invt.RowId")%>" >
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
<% oInvt.call "get_CreateFindIndexCombo", "Index", "Invt", Index %>
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
      <td Class="Label"><%=oInvt.DDValue("Vendor.Name",DDLONGLABEL,1)%></td>

      <%
       ' We are using the parent combo form to select the vendor.
       ' When you use this, you do not need to create a hidden
       ' rowid field for Vendor. It is created here as
       ' Vendor__RowId
       %>
      <td Class="Data">
           <%=oInvt.DDValue("Vendor.Name",DDPARENTCOMBO)%>
          <input Class="ActionButton" type="submit" value="List Parts" name="RunVendorReport">
      </td>
  </tr>
  <% If OldInvt<>"" then %>
  <tr>
    <td Class="Label">Vendor</td>
    <td Class="Data">
        <%=oInvt.DDValue("Vendor.Id")%>&nbsp;-&nbsp;<%=oInvt.DDValue("Vendor.Name")%>
        &nbsp;&nbsp;
        <em><%=oInvt.DDValue("Vendor.Phone_Number") %></em>
     </td>
  </tr>
  <% end if %>

  <tr>
      <%FieldError=oInvt.DDValue("Invt.Item_Id",DDFIELDERROR) %>
      <td Class="Label"><%=oInvt.DDValue("Invt.Item_Id",DDLONGLABEL,1)%></td>
      <td Class="Data">
      <%=oInvt.DDValue("Invt.Item_Id",DDFORM)%>
      </td>
      <% If FieldError<>"" then %>
      <td Class="Error"><%=FieldError%></td>
      <% end if %>
  </tr>
  <tr>
      <%FieldError=oInvt.DDValue("Invt.Description",DDFIELDERROR) %>
      <td Class="Label"><%=oInvt.DDValue("Invt.Description",DDLONGLABEL,1)%></td>
      <td Class="Data">
      <%=oInvt.DDValue("Invt.Description",DDFORM)%>
      </td>
      <% If FieldError<>"" then %>
      <td Class="Error"><%=FieldError%></td>
      <% end if %>
  </tr>
  <tr>
      <%FieldError=oInvt.DDValue("Invt.Vendor_Part_Id",DDFIELDERROR) %>
      <td Class="Label"><%=oInvt.DDValue("Invt.Vendor_Part_Id",DDLONGLABEL,1)%></td>
      <td Class="Data">
      <%=oInvt.DDValue("Invt.Vendor_Part_Id",DDFORM)%>
      </td>
      <% If FieldError<>"" then %>
      <td Class="Error"><%=FieldError%></td>
      <% end if %>
  </tr>
  <tr>
      <%FieldError=oInvt.DDValue("Invt.Unit_Price",DDFIELDERROR) %>
      <td Class="Label"><%=oInvt.DDValue("Invt.Unit_Price",DDLONGLABEL,1)%></td>
      <td Class="Data">
      <%=oInvt.DDValue("Invt.Unit_Price",DDFORM)%>
      </td>
      <% If FieldError<>"" then %>
      <td Class="Error"><%=FieldError%></td>
      <% end if %>
  </tr>
  <tr>
      <%FieldError=oInvt.DDValue("Invt.On_Hand",DDFIELDERROR) %>
      <td Class="Label"><%=oInvt.DDValue("Invt.On_Hand",DDLONGLABEL,1)%></td>
      <td Class="Data">
      <%=oInvt.DDValue("Invt.On_Hand",DDFORM)%>
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