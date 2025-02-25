<% '
   '  Vendor Entry and Maintenance
   '

   'Initialize Standard Information
   Index     = request("Index")           ' The last selected Index number
   RowId     = request("RowId")           ' If a row Id was passed
   RunReport = (request("RunReport")<>"") ' If run report was selected
   RunInvtReport = (request("ListParts")<>"")
%>


<html>

<head>
<meta http-equiv="Content-Type" content="text/html;charset=iso-8859-1">
<meta name="GENERATOR" content="Microsoft FrontPage 3.0">
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

<% If (RunReport=False AND RunInvtReport=False) then %>


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

<Form action="Vendor0.asp" method="POST" name="Vendor" onsubmit="SetChangedStates(this)">

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
<% if oVendor.ddvalue("Vendor.RowId") <>"" then %>
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

<%

' generate vendor input forms automatically

oVendor.call "set_psAutoEntryLabelStart", "<td Class=""Label"">"
oVendor.call "set_psAutoEntryDataStart",  "<td Class=""Data"">"
oVendor.call "get_AutoEntry","Vendor"
%>
</blockquote>
</form>


<% else %>

<% ' If here we are generating a report. Could be one of two reports %>


<% if RunReport then %>

<% ' If here we are generating a report for all Vendors %>

<h3>Vendor List</h3>
<%
  oVendor.call "get_autoreport","Vendor", Index ,"Vendor0.asp", 0, 0
%>

<%  else %>

<% ' If here we are generating an Invt report for the selected Vendor %>

<h3>Vendor Parts List</h3>
     <%
        ' If we list only for Vendor we must get the current Vendor
        ' rowid and pass it to the VDF report
        VRowId = request("Vendor__RowId")
        ' this calls the Vdf report passing row Id and the URLs to link
        ' the report back to the Invt or Vendor entry screen.
        oInvt.call "msg_SetHRefName", "Invt.asp"
        oInvt.call "msg_SetVendorHRefName", "Vendor0.asp"
        oInvt.call "msg_RunVndrInvtList", VRowId
     %>
<%end if %>

<%end if %>

</form>


</body>
</html>
