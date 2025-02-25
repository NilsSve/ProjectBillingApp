<% '
   '  Inventory Listing
   '

   MaxRecs   = 20 ' maximum records per report
   ZoomURL   = "Invt.asp" ' name of zoom file. If blank none.
   ZoomVendorURL   = "Vendor.asp" ' name of zoom file. If blank none.
   RunReport = (Request("RunReport")<>"")
   RunVendorReport = (Request("RunReport")="2")

%>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html;charset=iso-8859-1">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<title>Inventory Listing</title>

<% ' LoginRights:   If 1 user has full rights, if 0 or -1, browse only rights %>
<% LoginRights = request.cookies("Rights") %>

<!-- The name of the style sheet is in Global.asa and stored in the session object -->
<LINK REL=STYLESHEET HREF="<%=Session("Style")%>" TYPE="text/css">
</head>

<body>

<!-- #INCLUDE FILE="inc/ddValue_Constants.inc" -->

<% ' DebugMode =1 ' uncomment this for page get/post debug help %>
<!-- #INCLUDE FILE="inc/DebugHelp.inc" -->

<% If RunReport then '-------------run the report ------------- %>

   <% If RunVendorReport then ' %>

<h3>Vendor Parts List</h3>
     <%
        ' If we list only for Vendor we must get the current Vendor
        ' rowid and pass it to the VDF report
        VRowId = request("VendorRowId")
        ' this calls the VDF report passing row Id and the URLs to link
        ' the report back to the Invt or Vendor entry screen.
        oInvt.call "msg_SetHRefName", ZoomUrl
        oInvt.call "msg_SetVendorHRefName", ZoomVendorUrl
        oInvt.call "msg_RunVndrInvtList", VRowId
     %>


   <% else '-------------%>
<h3>Inventory Listing</h3>

    <%
    Index      = request("Index")           ' The last selected Index number
    StartRowId = request("Start")

    oInvt.call "msg_SetHRefName", ZoomUrl
    oInvt.call "msg_SetVendorHRefName", ZoomVendorUrl
    EndRowId = oInvt.call("get_RunInvtList", Index, StartRowId, MaxRecs)
    %>

<% If StartRowId <>"" then %>
<A HREF="#" onClick="history.go(-1);return false;">Previous Page</A>
<% end if %>

<% If EndRowId <> "" then %>
<A HREF="InvtList.asp?RunReport=1&Start=<%=EndRowId%>&Index=<%=Index%>">Next Page</A>
<% end if %>


<br>
<A HREF="InvtList.asp">New Report</A>

    <% end if %>

<% else  '-------------set up the report ------------- %>

<h3>Inventory Listing</h3>

<form action="InvtList.asp" method="GET">
<blockquote>

<table border="0">
  <tr>
    <td align="right"><strong>Report Order</strong></td>
    <td><% oInvt.call "get_CreateFindIndexCombo", "Index", "Invt", Index %></td>
  </tr>
</table>

</blockquote>

<p>
<input type="submit" name="RunReport"   value="Run Report">
<input type="reset" value="Reset Form">
</p>
</form>
<% end if %>
</body>
</html>