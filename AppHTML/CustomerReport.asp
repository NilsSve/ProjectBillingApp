<% '
   '  Customer Information Drill Down Report
   '

   MaxRecs   = 50 ' maximum records per report
   ZoomURL   = "CustomerReportZoom.asp" ' name of zoom file. If blank none.
   RunReport = (Request("RunReport")<>"")

%>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html;charset=iso-8859-1">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<title>Customer Report</title>

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

<h3>Customer Information Drill Down Report</h3>

<%
    Index      = request("Index")           ' The last selected Index number
    StartRowId = request("Start")
    SelStart1  = request("SelStart1")
    SelStop1   = request("SelStop1")

    oCustomerReport.call "msg_SetHRefName", ZoomUrl
    oCustomerReport.call "msg_SetCustomer_Number", SelStart1, SelStop1

    EndRowId = oCustomerReport.call("get_RunCustomerReport", Index, StartRowId, MaxRecs)
%>

<% If StartRowId <>"" then %>
<A HREF="#" onClick="history.go(-1);return false;">Previous Page</A>
<% end if %>

<% If EndRowId <>"" then %>
<A HREF="CustomerReport.asp?RunReport=1&Start=<%=EndRowId%>&Index=<%=Index%>&SelStart1=<%=SelStart1%>&SelStop1=<%=SelStop1%>">Next Page</A>
<% end if %>

<br>
<A HREF="CustomerReport.asp">New Report</A>

<% else  '-------------set up the report ------------- %>

<h3>Customer Information Drill Down Report</h3>

<form action="CustomerReport.asp" method="GET">
<blockquote>

<table border="0">
  <tr>
    <td class="Label" align="right">Customer Number: From</td>
    <td class="Label" >
      <input type="text" size="6" name=SelStart1 value="" >
      to:
      <input type="text" size="6" name=SelStop1 value="" >
      </td>
  </tr>
  <tr>
    <td class="Label" align="right">Report Order</td>
    <td><% oCustomerReport.call "get_CreateFindIndexCombo", "Index", "Customer", Index %></td>
  </tr>
</table>

</blockquote>

<p>
<input Class="ActionButton" type="submit" name="RunReport"   value="Run Report">
<input Class="ActionButton" type="reset" value="Reset Form">
</p>
</form>
<% end if %>
</body>
</html>